Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756701AbWKSOnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756701AbWKSOnF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 09:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756695AbWKSOnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 09:43:04 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:20140 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S1756701AbWKSOnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 09:43:03 -0500
Date: Sun, 19 Nov 2006 15:42:42 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-rt4, changed yum repository
Message-ID: <20061119144242.GN18636@pengutronix.de>
References: <20061118163032.GA14625@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20061118163032.GA14625@elte.hu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

On Sat, Nov 18, 2006 at 05:30:32PM +0100, Ingo Molnar wrote:
> i've released the 2.6.18-rc6-rt4 tree, which can be downloaded from
> the usual place:

I have problems runinng cyclictest on later -rt kernels, up to -rt4.

This is a Dell Latitude D610, with Pentium M & ICH6 chipset.

Symptoms: 

- "cyclictest -n -p 90 -t 4" is just "running upwards"

  With 2.6.18-rt5 it looked like this, much better:

  isonoe:/home/rsc/tmp/rtpreempt/cyclictest-0.11# ./cyclictest -n -t 4 -p 90 -l 1000
  1.51 0.99 0.41 1/117 9885          
  
  T: 0 ( 9802) P:90 I:    1000 C:    1000 Min:       7 Act:      11 Avg:      16 Max:     561
  T: 1 ( 9803) P:89 I:    1500 C:     671 Min:       7 Act:      11 Avg:      15 Max:     498
  T: 2 ( 9804) P:88 I:    2000 C:     504 Min:       7 Act:      11 Avg:      16 Max:     533
  T: 3 ( 9805) P:87 I:    2500 C:     403 Min:       6 Act:      11 Avg:      13 Max:     394

- Using a relative timer (-r), I get huge latencies:

  isonoe:/home/rsc/tmp/rtpreempt/cyclictest-0.11# ./cyclictest -n -p 90 -t 4 -r -l 1000
  0.47 0.76 0.61 3/128 16112           
  
  T: 0 (15901) P:90 I:    1000 C:    1000 Min:    2963 Act:    2990 Avg:    4334 Max:    7039
  T: 1 (15902) P:89 I:    1500 C:     667 Min:    4003 Act:    6495 Avg:    6492 Max:    6541
  T: 2 (15903) P:88 I:    2000 C:     667 Min:    3498 Act:    5995 Avg:    5993 Max:    6041
  T: 3 (15904) P:87 I:    2500 C:     667 Min:    5433 Act:    5488 Avg:    5498 Max:    6898

This is with "lapic lapictimer" on the kernel commandline. I've manually
switched the clocksource from pit to tsc:

isonoe:/sys/devices/system/clocksource/clocksource0# cat available_clocksource 
jiffies tsc pit 
isonoe:/sys/devices/system/clocksource/clocksource0# cat current_clocksource 
tsc 

Some related dmesg output:

Kernel command line: root=/dev/sda7 ro lapic lapictimer
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
...
WARNING: experimental RCU implementation.
Clock event device pit configured with caps set: 07
...
Clock event device pit new caps set: 03
Clock event device lapic configured with caps set: 04
...
Time: pit clocksource has been installed.
...
*****************************************************************************
*                                                                           *
*  REMINDER, the following debugging options are turned on in your .config: *
*                                                                           *
*        CONFIG_CRITICAL_PREEMPT_TIMING                                     *
*        CONFIG_CRITICAL_IRQSOFF_TIMING                                     *
*        CONFIG_FUNCTION_TRACE                                              *
*                                                                           *
*  they may increase runtime overhead and latencies.                        *
*                                                                           *
*****************************************************************************

Last time this machine worked was with 2.6.18-rt5, 2.6.18-rt7 didn't work any
more. If it is helpful, I can do some further boot tests to find out which
patch broke it. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

