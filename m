Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263437AbVCEAhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263437AbVCEAhL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263289AbVCEANh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:13:37 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:53479 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S263166AbVCDXgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:36:23 -0500
Subject: Re: BIOS overwritten during resume (was: Re: Asus L5D resume on
	battery power)
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Bernard Blackham <bernard@blackham.com.au>
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com
In-Reply-To: <200503050026.06378.rjw@sisk.pl>
References: <200502252237.04110.rjw@sisk.pl>
	 <200503041415.35162.rjw@sisk.pl> <20050304201109.GB2385@elf.ucw.cz>
	 <200503050026.06378.rjw@sisk.pl>
Content-Type: text/plain
Message-Id: <1109979448.3772.312.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 05 Mar 2005 10:37:29 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2005-03-05 at 10:26, Rafael J. Wysocki wrote:
> Yes.  I thought about using PG_nosave in the begining, but there's a
> 
> BUG_ON(PageReserved(page) && PageNosave(page));
> 
> in swsusp.c:saveable() that I just didn't want to trigger.  It seems to me,
> though, that we don't need it any more, do we?
> 
> > He also found a few places where reserved page becomes un-reserved,
> > and you probably need to fix those, too.
> 
> Yes, I think I'll just port the Nigel's patch to x86-64.  BTW, it's striking
> that we found similar solutions independently (I didn't know the Nigel's
> patch before :-)).

I should clarify credit. I didn't work on that code. I don't recall now
whether it was Michael Frank or Bernard Blackham that came up with this
version. (This was about a year ago IIRC).

> Unfortunately, it turns out that the patch does not fix my problem with random
> reboots during resume on battery power, but I really think that we need to mark
> non-RAM areas with PG_nosave, at least for sanity reasons (eg to be sure that
> we do not break things by dumping stuff to where we should not write to).

Yes. I believed that that's what this patch does. Since I didn't write
it myself, I'm a little fuzzy on that issue. I'll bring Bernard in,
perhaps he can clarify?..

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de


