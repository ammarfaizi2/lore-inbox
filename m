Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263382AbTJVJR5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 05:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTJVJR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 05:17:57 -0400
Received: from poup.poupinou.org ([195.101.94.96]:32561 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S263382AbTJVJRz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 05:17:55 -0400
Date: Wed, 22 Oct 2003 11:17:47 +0200
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-acpi <linux-acpi@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Dominik Brodowski <linux@brodo.de>
Subject: Re: [PATCH] 1/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Message-ID: <20031022091747.GM13989@poupinou.org>
References: <88056F38E9E48644A0F562A38C64FB6007791F@scsmsx403.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6007791F@scsmsx403.sc.intel.com>
User-Agent: Mutt/1.5.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 11:57:58AM -0700, Pallipadi, Venkatesh wrote:
> 
> 
> > -----Original Message-----
> > From: Ducrot Bruno [mailto:ducrot@poupinou.org] 
> > Sent: Tuesday, October 21, 2003 10:56 AM
> > 
> > > It will work any processor 
> > > that is ACPI compatible and again there are no specific 
> > > checks for Intel here.
> > > 
> > 
> > On a K7 with powernow for example, perf_ctrl and perf_data 
> > will be MSR 0
> > with your patch, that do not make sence.
> > Even if you know the correct MSRs, the values for 'control' 
> > and 'status'
> > in _PSS packages will be only bit-fields, and they can *not* be
> > written nor read directly to the (correct) MSRs (again for K7 
> > powernow).
> > 
> > This is because the FfixedHW is only an indication that a CPU specific
> > 'feature' (even though already somehow defined in ACPI like P-state,
> > C-state, etc.) have to be handled by the OS in a non-acpi driver, as
> > per ACPI spec, and that will be dependant of the CPU.
> > 
> 
> Agree with most of your comments. 
> Current ACPI P-state driver ignored everything other than SYSTEM_IO.
> And we are trying to add support for FIXED_HW. I was unaware of
> any other CPU using ACPI PCT FIXED_HW to mean anything other than
> MSR. As you mentioned, if K7 indeed exports some ACPI-PCT information 
> to mean something else, then that is a real bug in my patch. I will 
> add CPU specific abstraction to handle FIXED_HW get/set functions in 
> the next revision of the patch. 

That is why Dominik seperated the acpi cpufreq driver in 2 files in his
cleanup patch.  Others cpufreq drivers may use acpi to retrieve infos
if needed.  Even though by now K7 do not support that, it can be changed
for (the doc. seems to be under NDA, but AMD seems willing to cooperate).

Looking around some other asl, it seems also that if you verify that
_PCT return FFixedHW, but length and address are both different to 0,
it may be possible that a generic driver via MSR could work, but there
is nothing in specs afaik (and specs can be changed if compatible..).

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
