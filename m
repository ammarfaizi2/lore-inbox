Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVHHSiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVHHSiD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 14:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVHHSiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 14:38:02 -0400
Received: from fmr16.intel.com ([192.55.52.70]:23491 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S932182AbVHHSiC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 14:38:02 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
Date: Mon, 8 Aug 2005 11:37:37 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB600565DD73@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
Thread-Index: AcWb6XvlRtGvZEylTeGK8ENeObfkRgAXmnEg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Stefan Seyfried" <seife@suse.de>, "Con Kolivas" <kernel@kolivas.org>,
       "Thomas Renninger" <trenn@suse.de>
Cc: <tony@atomide.com>, <ck@vds.kolivas.org>, <tuukka.tikkanen@elektrobit.com>,
       <linux-kernel@vger.kernel.org>, <tytso@mit.edu>
X-OriginalArrivalTime: 08 Aug 2005 18:37:38.0939 (UTC) FILETIME=[40D7CCB0:01C59C48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Stefan Seyfried
>Sent: Sunday, August 07, 2005 10:43 PM
>To: Con Kolivas
>Cc: tony@atomide.com; ck@vds.kolivas.org; 
>tuukka.tikkanen@elektrobit.com; linux-kernel@vger.kernel.org; 
>tytso@mit.edu
>Subject: Re: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
>
>Con Kolivas wrote:
>
>>> When I enabled dynamic tick using:
>>>
>>> 	echo 1 > /sys/devices/system/timer/timer0/dyn_tick_state
>>>
>>> The number of ticks dropped down to 60-70 HZ, bus mastering activity
>>> jumpped up to being almost always active,
>> 
>> Anyone know why this would happen?
>
>This is just a guess, without any actual code-reading:
>Maybe the C-state decision process just relies on being called every
>tick, so "after X ticks with no BM activity, go to next deeper 
>C state".
>As long as 1000 ticks per second are coming in, everything is fine and
>we enter C[n+1] after X miliseconds without BM activity. Now if there
>are only 60-70 ticks per second, you never get X ticks without BM
>activity so you never go deeper than C2.
>
>Just a guess.

That is correct. The C-state policy right now looks at jiffies to decide
on which C-state to go to (instead of absolute time).
This patch from Thomas should help with respect to going to proper 
C-state in presence of dynamic tick.
http://lkml.org/lkml/2005/4/19/96

Thanks,
Venki
