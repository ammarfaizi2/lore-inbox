Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbUKPS2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbUKPS2a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 13:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbUKPS2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 13:28:30 -0500
Received: from fmr02.intel.com ([192.55.52.25]:37539 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262073AbUKPS1Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 13:27:24 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] prefer TSC over PM Timer
Date: Tue, 16 Nov 2004 10:27:05 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB60035C613D@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] prefer TSC over PM Timer
Thread-Index: AcTLfS6ReBtFlnI6SlCqV8B/LtI37wAg5wjg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "john stultz" <johnstul@us.ibm.com>,
       "dean gaudet" <dean-list-linux-kernel@arctic.org>
Cc: "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Nov 2004 18:27:06.0235 (UTC) FILETIME=[E04114B0:01C4CC09]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of john stultz
>Sent: Monday, November 15, 2004 5:38 PM
>To: dean gaudet
>Cc: lkml
>Subject: Re: [patch] prefer TSC over PM Timer
>
>On Mon, 2004-11-15 at 16:23, dean gaudet wrote:
>> i've heard other folks have independently run into this 
>problem -- in fact 
>> i see the most recent fc2 kernels already do this.  i'd like 
>this to be 
>> accepted into the main kernel though.
>> 
>> the x86 PM Timer is an order of magnitude slower than the TSC for 
>> gettimeofday calls.  i'm seeing 8%+ of the time spent doing 
>gettimeofday 
>> in someworkloads... and apparently kernel.org was seeing 80% 
>of its time 
>> go to gettimeofday during the fc3-release overload.  PM 
>timer is also less 
>> accurate than TSC.
>> 

I think trying to remove repeated inl()'s in read_pmtmr is a better 
fix for this issue. As John mentioned in other thread, we should do 
repeated reads only when something looks broken. Not always.

TSC counter stops couting when the CPU is in deep sleep state. It 
should be OK to use tsc with Centrinos which support Enhanced Speedstep
Technology. But, it will have issues with older system that supports 
Older Speedstep. So, I would say using pm_timer as default is better 
as that works correctly on most of the systems. 

Thanks,
Venki
