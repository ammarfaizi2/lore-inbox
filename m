Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbRE3VlT>; Wed, 30 May 2001 17:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262762AbRE3VlK>; Wed, 30 May 2001 17:41:10 -0400
Received: from coruscant.franken.de ([193.174.159.226]:28433 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S262733AbRE3Vk6>; Wed, 30 May 2001 17:40:58 -0400
Date: Wed, 30 May 2001 18:40:35 -0300
From: Harald Welte <laforge@gnumonks.org>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 2.4.5-ac4 non-init functions calling init functions
Message-ID: <20010530184035.Q14293@corellia.laforge.distro.conectiva>
In-Reply-To: <200105302008.NAA07710@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <200105302008.NAA07710@csl.Stanford.EDU>; from engler@csl.Stanford.EDU on Wed, May 30, 2001 at 01:08:40PM -0700
X-Operating-System: Linux corellia.laforge.distro.conectiva 2.4.3
X-Date: Today is Pungenday, the 2nd day of Confusion in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 01:08:40PM -0700, Dawson Engler wrote:

> Here are *uninspected* 2.4.5-ac4 results of a checker that warns when a
> non-__init function calls an __init function (suggested by
> jlundell@lobitos.net).  There seem to be two cases:
> 
>         1. The best case: the caller should actually be an __init function
> 	as well.  This is a performance bug since it won't be freed.
> 
>         2. The worst case: some random post-initialization routine
>         calls an __init routine which can cause the kernel to go into
>         hyperspace if the __init routine's code has been deleted.
> 
> The current messages do not differentiate between these two cases.  If these
> results are generally useful, I can fix up the checker, but as it now stands
> there shouldn't be that many false positives.
> 
> Dawson
> MC linux bug database: http://hands.stanford.edu/linux
> 

> /u2/engler/mc/oses/linux/2.4.5-ac4/net/ipv4/netfilter/ip_nat_standalone.c:278:init_or_cleanup: ERROR:INIT: non-init fn 'init_or_cleanup' calling init fn 'ip_nat_rule_init'

This is not a bug. init_or_cleanup is only called from one place with
an argument of 1: from the init() function. If the argument is 0,
as called by the exit() function, the code for calling the ip_nat_rule_setup
is never reached.

So it is definitely not a bug.

Anyway, one should maybe make this a little bit cleaner. Will look into that.

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
