Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279603AbRKIHRA>; Fri, 9 Nov 2001 02:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279617AbRKIHQo>; Fri, 9 Nov 2001 02:16:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10882 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279603AbRKIHQi>;
	Fri, 9 Nov 2001 02:16:38 -0500
Date: Thu, 08 Nov 2001 23:16:32 -0800 (PST)
Message-Id: <20011108.231632.18311891.davem@redhat.com>
To: ak@suse.de
Cc: anton@samba.org, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011109073946.A19373@wotan.suse.de>
In-Reply-To: <20011109064540.A13498@wotan.suse.de>
	<20011108.220444.95062095.davem@redhat.com>
	<20011109073946.A19373@wotan.suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Fri, 9 Nov 2001 07:39:46 +0100
   
   I'm assuming that walking on average 5-10 pages on a lookup is not
   too big a deal, especially when you use prefetch for the list walk.

Oh no, not this again...

It _IS_ a big deal.  Fetching _ONE_ hash chain cache line
is always going to be cheaper than fetching _FIVE_ to _TEN_
page struct cache lines while walking the list.

Even if prefetch would kill all of this overhead (sorry, it won't), it
is _DUMB_ and _STUPID_ to bring those _FIVE_ to _TEN_ cache lines into
the processor just to lookup _ONE_ page.

Franks a lot,
David S. Miller
davem@redhat.com

