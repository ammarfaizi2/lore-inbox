Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314706AbSD1Xzy>; Sun, 28 Apr 2002 19:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314707AbSD1Xzx>; Sun, 28 Apr 2002 19:55:53 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40718 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314706AbSD1Xzw>; Sun, 28 Apr 2002 19:55:52 -0400
Subject: Re: Why HZ on i386 is 100 ?
To: george@mvista.com (george anzinger)
Date: Mon, 29 Apr 2002 01:14:26 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ak@suse.de (Andi Kleen),
        linux-kernel@vger.kernel.org
In-Reply-To: <3CCC6EAD.22A439F7@mvista.com> from "george anzinger" at Apr 28, 2002 02:50:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E171yoE-0004ym-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is the extra code in the schedule() path, not in the timer
> tick path.  It is traversed FAR more often.

Thats still in most cases a single compare. The tick timer will mostly be
going off before our time slice completes. Also importantly the more we
context switch the less timers go off - so it scales correctly.

> The current tick at 1/HZ is really quite relaxed.  Given the PIT (ugh!)
> the longest we can put off a tick is about 50 ms.  This means that any
> time greater than this will require more than one interrupt, i.e. the
> best case improvement by going tick less (again given the PIT) is about
> 5 times.  Other platforms/ hardware, of course, change this.

If you are arguing that the PIT makes it impractical on basic x86 then
we are in violent agreement. I don't propose this kind of stuff for the
PIT but for real computers where a timer reload is a couple of clocks
