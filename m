Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbUCAL0N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 06:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbUCAL0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 06:26:13 -0500
Received: from mail017.syd.optusnet.com.au ([211.29.132.168]:12444 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261217AbUCAL0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 06:26:08 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMT Nice 2.6.4-rc1-mm1
Date: Mon, 1 Mar 2004 22:25:59 +1100
User-Agent: KMail/1.6
Cc: Andrew Morton <akpm@osdl.org>
References: <200403011752.56600.kernel@kolivas.org>
In-Reply-To: <200403011752.56600.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403012225.59538.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2004 05:52 pm, Con Kolivas wrote:
> This patch provides full per-package priority support for SMT processors
> (aka pentium4 hyperthreading) when combined with CONFIG_SCHED_SMT.

And here are some benchmarks to demonstrate what happens. 
P4 3.06Ghz booted with bios HT off as UP (up), SMP with mm1(mm1), SMP with 
mm1-smtnice(sn)

What would a benchmark from me be if not based on a kernel compile?  These 
numbers are coarse so the range is about +/- 2 seconds however the results 
should be clear. Time is in seconds, rounded.


Straight kernel compile: make
		Time
up		87
mm1		88
sn		88


Concurrent kernel compiles, one make, the other nice +19 make
		Nice0	Nice19
up		183		235
mm1		208		211
sn		180		237


Kernel compile with an artifical cpu load running nice +19 (while true ; do 
a=1 ; done)
		Time
up		92
mm1		129
sn		104


Kernel compile with a true distributed computing cache burner running nice +19 
(mprime www.mersenne.org)
		Time
up		96
mm1		168
sn		94


Clearly the type of load running will influence the balance here depending on 
how long the task actually runs and how cache intensive it is. Basically for 
real world loads priority is very poorly preserved by default because of the 
shared cpu resources, and the worst case is a very common one; running a 
distributed computing client.

Note this patch has no demonstrable effect if tasks are run at the same nice 
value.

Con
