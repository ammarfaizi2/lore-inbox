Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289888AbSAWPsD>; Wed, 23 Jan 2002 10:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289889AbSAWPrx>; Wed, 23 Jan 2002 10:47:53 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:24010 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S289888AbSAWPrn>; Wed, 23 Jan 2002 10:47:43 -0500
From: <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: <drobbins@gentoo.org>, <linux-kernel@vger.kernel.org>, <andrea@suse.de>,
        <alan@redhat.com>, <akpm@zip.com.au>, <vherva@niksula.hut.fi>,
        <lwn@lwn.net>, <paulus@samba.org>
Subject: Re: Athlon/AGP issue update
Date: Wed, 23 Jan 2002 16:47:37 +0100
Message-Id: <20020123154737.19204@mailhost.mipsys.com>
In-Reply-To: <20020123.060855.26275529.davem@redhat.com>
In-Reply-To: <20020123.060855.26275529.davem@redhat.com>
X-Mailer: CTM PowerMail 3.1.1 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I don't think your PPC case needs the kernel mappings messed with.
>I really doubt the PPC will speculatively fetch/store to a TLB
>missing address.... unless you guys have large TLB mappings on
>PPC too?

Yes, we use BATs (sort of built-in fixed large TLBs) to map
the lowmem (or entire RAM without CONFIG_HIGHMEM).

So if some kind of loop is fetching memory near the end of a non-AGP
page via the linear RAM mapping (BAT mapping) and the next page is an
AGP bound page, the CPU may do speculative access to the AGP page via
the BAT mapping thus bringing in a cache line for the AGP page.

At least, that's my understanding, it has to be validated by some
CPU gurus from IBM though.

Ben.



