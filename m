Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbTCJSCO>; Mon, 10 Mar 2003 13:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261391AbTCJSCN>; Mon, 10 Mar 2003 13:02:13 -0500
Received: from sdfw-ext.castandcrew.com ([63.113.17.130]:16115 "EHLO
	sddev.castandcrew.com") by vger.kernel.org with ESMTP
	id <S261390AbTCJSCM>; Mon, 10 Mar 2003 13:02:12 -0500
From: "Gregory K. Ruiz-Ade" <gregory@castandcrew.com>
Organization: Cast & Crew Entertainment Services, Inc.
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: system lockup issues w/ 2.4.19
Date: Mon, 10 Mar 2003 10:12:01 -0800
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <13694.1047106361@ocs3.intra.ocs.com.au>
In-Reply-To: <13694.1047106361@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303101012.02294.gregory@castandcrew.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 March 2003 22:52, Keith Owens wrote:
> Those symptoms do not necessarily mean a full process table.  You get
> exactly those symptoms if some code has grabbed a spin lock related to
> process creation and not released it.

Hmm... Well, it happened again on Friday night, and pouring through the 
syslogs, sendmail started refusing mail due to a load average of 18 and 
then 19...  This system, even under it's heaviest use, never breaks a 
system load average of 4-5.  Would a "stuck" spinlock result in an 
artificial inflation of system load averages (as a symptom)?

> You need kernel debugging features to find out which lock is the
> problem.  Booting with nmi_watchdog and a serial console (see
> linux/Documentation) will often tell you what has hung.

I'm building a 2.4.20 kernel using sources from kernel.org, and turning on 
the following options:

-->8--[Cut Here (.config)]-->8--
#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_HIGHMEM=y
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_FRAME_POINTER=y
-->8--[Cut Here (.config)]-->8--

Should I enable the other two, as well?

Also, do I've wired up the serial console on this machine to another machine 
(that's much more stable) so that I can access it remotely... should I try 
to set something up that simply monitors the serial console constantly and 
logs it to a file, or will I be able to get the info I need via a program 
like minicom by poking the kernel after the fact?

> The kdb patch (ftp://oss.sgi.com/projects/kdb/download/v3.0) will let
> you print the state of each process and find out where they are
> spinning.  Note: kdb patches are against standard kernels, ask your
> distributor about how to patch the distributor's kernel with kdb.

I'll add this in to the kernel as well.  Hopefully I'll be able to get some 
more useful information out of the system the next time this happens.

Thanks for all the pointers!

Gregory

-- 
Gregory K. Ruiz-Ade <gregory@castandcrew.com>
Sr. Systems Administrator
Cast & Crew Entertainment Services, Inc.

