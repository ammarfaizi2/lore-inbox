Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261751AbSJMWiB>; Sun, 13 Oct 2002 18:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261753AbSJMWiA>; Sun, 13 Oct 2002 18:38:00 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:40788 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261751AbSJMWht>; Sun, 13 Oct 2002 18:37:49 -0400
Date: Mon, 14 Oct 2002 00:42:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre10aa1 oops report (was Re: Linux-2.4.20-pre8-aa2 oops report. [solved])
Message-ID: <20021013224247.GC24468@dualathlon.random>
References: <200210051247.14368.harisri@bigpond.com> <20021010012626.GW2958@dualathlon.random> <200210102017.04048.harisri@bigpond.com> <200210131153.30036.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210131153.30036.harisri@bigpond.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 11:53:29AM +1000, Srihari Vijayaraghavan wrote:
> Oct 11 22:43:19 localhost kernel: Process modprobe (pid: 1675, 

this smells like a problem with one of your modules. Please make 100%
sure you use exactly the same .config for both 2.4.20pre10 and
2.4.20pre10aa1 and please try to find which is the module that is
crashing the kernel after it's being loaded. Expect always different
kind of crashes and oopses. You can also try to turn on the slab
debugging option in the kernel hacking menu.

> Code;  c01e55e2 <fast_clear_page+12/50>

you also may want to configure the kernel as i686 instead of K7 so
fast_clear_page won't be used to see if it makes any difference.

> The mainline (2.4.20-pre10) does not exhibit this issue. Unlike 
> 2.4.20-pre8aa1, 2.4.20-pre10aa1 rebooted itself after the above oops.
> 
> I am hoping some of these oops might reveal the real issue/reason/bug to 
> kernel developers one of these days.

the place where the oops happens is most certainly not the problem,
either something is wrong with fast_clear_page for whatever hardware
reason, or more likely the moduled by modprobe is corrupting the
freelist and alloc_pages returned garbage.

btw, how much memory do you have? If you've more than 800M it could be a
broken driver using pte_offset by hand, try to reproduce with mem=800m
in such case. To fix this you should find which is the module that is
destabilizing the kernel.

thanks for the reports.

Andrea
