Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262922AbVA2OjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262922AbVA2OjY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 09:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbVA2OjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 09:39:24 -0500
Received: from fmr14.intel.com ([192.55.52.68]:45020 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S262922AbVA2Oi2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 09:38:28 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Discuss][i386] Platform SMIs and their interferance with tsc based delay calibration
Date: Sat, 29 Jan 2005 06:37:45 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6003E1D12C@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Discuss][i386] Platform SMIs and their interferance with tsc based delay calibration
Thread-Index: AcUFyyqck1qpKHPpRYqFZ00z/2MGSgAQGrog
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Andi Kleen" <ak@muc.de>
Cc: "Seth, Rohit" <rohit.seth@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
X-OriginalArrivalTime: 29 Jan 2005 14:37:46.0678 (UTC) FILETIME=[197CCD60:01C50610]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-----Original Message-----
>From: Andi Kleen [mailto:ak@muc.de] 
>Sent: Friday, January 28, 2005 10:24 PM
>To: Pallipadi, Venkatesh
>Cc: Seth, Rohit; Mallick, Asit K; 
>linux-kernel@vger.kernel.org; akpm@osdl.org
>Subject: Re: [Discuss][i386] Platform SMIs and their 
>interferance with tsc based delay calibration
>
>Venkatesh Pallipadi <venkatesh.pallipadi@intel.com> writes:
>> +
>> +	/*
>> +	 * If the upper limit and lower limit of the tsc_rate 
>is more than
>> +	 * 12.5% apart.
>> +	 */
>> +	if (pre_start == 0 || pre_end == 0 ||
>> +	    (tsc_rate_max - tsc_rate_min) > (tsc_rate_max >> 3)) {
>> +		printk(KERN_WARNING "TSC calibration may not be 
>precise. " 
>> +		       "Too many SMIs? "
>> +		       "Consider running with \"lpj=\" boot option\n");
>> +		return 0;
>> +	}
>
>I think it would be better to rerun it a few times automatically
>before giving up. This way it would hopefully work 
>transparently but slower
>for most users. 

Agreed. Actually, I was doing that earlier, with each retry 
calibrating for 1 HZ. But, once I moved to 10 HZ, I removed the retires.

>The message is too obscure too to be usable and needs
>more explanation.

I will try to improve the message in next revision of the patch.

>And also in case the platforms in questions support EM64T 
>x86-64 would need to be changed too :)

Yes. I will send out a patch for x86-64 too, once the i386 patch 
gets finalized. I wanted to have a shorted patch reviewed first :).

Thanks,
Venki
