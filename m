Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbTETRaK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 13:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263817AbTETRaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 13:30:09 -0400
Received: from [208.186.192.194] ([208.186.192.194]:42140 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263804AbTETRaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 13:30:08 -0400
Message-Id: <200305201743.h4KHhMC25023@es175.pdx.osdl.net>
To: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: re-aim - 2.5.69, -mm6
Date: Tue, 20 May 2003 10:43:22 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This is the result of running the Reaim test against the 
2.5.69 and 2.5.69-mm6 kernels. The -mm kernels are a bit
slower, and i'm wondering if i'm missing a tuning knob somewhere..
advice appreciated.

Re-aim is a rework of the AIM suite. (locations below)

Two data points i look at-
1. Maximum jobs per minute  
2. Number of children when Jobs/second/child less than 1.0. 
	(convergence)

Load is the new_dbase load. (AIM7 dbase load with less synch IO)
System is a 4-CPU PIII with 4GB of physical
memory, test used 4 SCSI disks on a qlogicfc adapter. 
Test is run with two different convergence methods, 3 runs each.
Peak load is the average of 3 runs, i pick the best results
regardless of convergence method. 

Kernel                Peak Load
2.5.69 - base         5216.68 Jobs/Minute
2.5.69-mm6(AS)        4963.36 JPM
2.5.69-mm6(deadline)  4966.71 JPM
2.5.69-mm7(AS)        4966.86 JPM

Load when JPS/child < 1.0 (c_ times are total for all children)
Average of six runs

Kernel             Children  JPM       RunTime  c_utime  c_systime

2.5.69 - base      88         5185.88  104.87   376.01   40.28
2.5.69-mm6(AS)     84         4894.73  106.08   374.91   45.54  
2.5.69-mm6(deadln) 84         4858.36  106.90   376.55   46.41
2.5.69-mm7(AS)     84         4853.80  106.95   378.02   46.26


Attempting a second pass of -mm7 caused the hang reported earlier. 
cliffw
OSDL

report details and profile data at:
http://www.osdl.org/archive/cliffw/reaim 

Reaim code at:
http://sourceforge.net/projects/re-aim-7
or
bk://bk.osdl.org/aimrework
