Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289728AbSAWOKb>; Wed, 23 Jan 2002 09:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289739AbSAWOKV>; Wed, 23 Jan 2002 09:10:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49280 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289697AbSAWOKK>;
	Wed, 23 Jan 2002 09:10:10 -0500
Date: Wed, 23 Jan 2002 06:08:55 -0800 (PST)
Message-Id: <20020123.060855.26275529.davem@redhat.com>
To: benh@kernel.crashing.org
Cc: drobbins@gentoo.org, linux-kernel@vger.kernel.org, andrea@suse.de,
        alan@redhat.com, akpm@zip.com.au, vherva@niksula.hut.fi, lwn@lwn.net,
        paulus@samba.org
Subject: Re: Athlon/AGP issue update
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020123024610.30988@mailhost.mipsys.com>
In-Reply-To: <20020123.021819.21955581.davem@redhat.com>
	<20020123024610.30988@mailhost.mipsys.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: benh@kernel.crashing.org
   Date: Wed, 23 Jan 2002 03:46:10 +0100
   
   The workaround here would be for AGP to also _unmap_ the AGP pages from
   the main kernel mapping, which isn't always possible, for example on PPC
   we use the BATs to map the kernel lowmem, we can't easily make "holes" in
   a BAT mapping. That's one reason why I did some experiments to make the
   PPC kernel able to disable it's BAT mapping.

This would be impossible on sparc64 too, since we implement these
mappings statically with an add instruction in the TLB handler.

But we also lack AGP on sparc64 so...

I don't think your PPC case needs the kernel mappings messed with.
I really doubt the PPC will speculatively fetch/store to a TLB
missing address.... unless you guys have large TLB mappings on
PPC too?
