Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262921AbVA2OhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbVA2OhQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 09:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbVA2OhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 09:37:16 -0500
Received: from fmr14.intel.com ([192.55.52.68]:22492 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S262921AbVA2OhG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 09:37:06 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Discuss][i386] Platform SMIs and their interferance with tsc based delay calibration
Date: Sat, 29 Jan 2005 06:36:54 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6003E1D12B@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Discuss][i386] Platform SMIs and their interferance with tsc based delay calibration
Thread-Index: AcUFwcY3536heqkPThS69jiy21knSgASwnmA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>,
       "Seth, Rohit" <rohit.seth@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 29 Jan 2005 14:36:56.0156 (UTC) FILETIME=[FB5FC1C0:01C5060F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Andrew Morton [mailto:akpm@osdl.org] 
>Subject: Re: [Discuss][i386] Platform SMIs and their 
>interferance with tsc based delay calibration
>
>
>Please don't send emails which contain 500-column lines?

Sorry. Something got messed up during cut and paste onto my mailer.

>>  Solution:
>>  The patch below makes the calibration routine aware of 
>asynchronous events
>> like SMIs. We increase the delay calibration time and also 
>identify any
>> significant errors (greater than 12.5%) in the calibration 
>and notify it
>> to user. Like to know your comments on this.
>
>I find calibrate_delay_tsc() quite confusing.  Are you sure that the
>variable names are correct?
>
> +	tsc_rate_max = (post_end - pre_start) / DELAY_CALIBRATION_TICKS;
> +	tsc_rate_min = (pre_end - post_start) / DELAY_CALIBRATION_TICKS;
>
>that looks strange.  I'm sure it all makes sense if one understands the
>algorithm, but it shouldn't be this hard.  Please reissue the 
>patch with
>adequate comments which describe what the code is doing.
>

I will resend the patch soon with more comments. I think the variable 
names here are bit confusing.

>Shouldn't calibrate_delay_tsc() be __devinit?  (That may 
>generate warnings
>from reference_discarded.pl, but they're false positives)
>
>
>From a maintainability POV it's not good that x86 is no longer 
>using the
>generic calibrate_delay() code.  Can you rework the code so that all
>architectures must implement arch_calibrate_delay(), then 
>provide stubs for
>all except x86?  After all, other architectures/platforms may 
>have the same
>problem.
>

Agreed. I will add a stub in other architectures. That way we don't 
have to duplicate the current delay_calibration under i386.

Thanks,
Venki
