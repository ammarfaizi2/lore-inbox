Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263238AbTJURz6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 13:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbTJURz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 13:55:58 -0400
Received: from poup.poupinou.org ([195.101.94.96]:1580 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id S263238AbTJURz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 13:55:56 -0400
Date: Tue, 21 Oct 2003 19:55:45 +0200
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-acpi <linux-acpi@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Dominik Brodowski <linux@brodo.de>
Subject: Re: [PATCH] 1/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Message-ID: <20031021175545.GK13989@poupinou.org>
References: <88056F38E9E48644A0F562A38C64FB6007791A@scsmsx403.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6007791A@scsmsx403.sc.intel.com>
User-Agent: Mutt/1.5.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 10:15:31AM -0700, Pallipadi, Venkatesh wrote:
> 
> > -----Original Message-----
> > From: Ducrot Bruno [mailto:ducrot@poupinou.org] 


...

> > Your do not handle correctly 
> > other processors
> > than Intel.  
> 
> I am sorry. I do not understand this comment. 
> - Major part of Patch 1 is adding SMP awareness, which has
> nothing specific to Intel at all.
> - A part of patch 1 adds MSR based transition capability. 
> This is based on ACPI spec.

Could you tell me where you find in ACPI spec. that FfixedHW means 
always MSR?  That not true for C-states definitions via _CST for
example (the first entry being always an FFixedHW, because it
is C1 and will be the single asm instruction: 'hlt').
Look 2.0b page 228.

> It will work any processor 
> that is ACPI compatible and again there are no specific 
> checks for Intel here.
> 

On a K7 with powernow for example, perf_ctrl and perf_data will be MSR 0
with your patch, that do not make sence.
Even if you know the correct MSRs, the values for 'control' and 'status'
in _PSS packages will be only bit-fields, and they can *not* be
written nor read directly to the (correct) MSRs (again for K7 powernow).

This is because the FfixedHW is only an indication that a CPU specific
'feature' (even though already somehow defined in ACPI like P-state,
C-state, etc.) have to be handled by the OS in a non-acpi driver, as
per ACPI spec, and that will be dependant of the CPU.


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
