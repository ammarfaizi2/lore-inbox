Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVFIV0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVFIV0n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 17:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbVFIV0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 17:26:43 -0400
Received: from fmr13.intel.com ([192.55.52.67]:26060 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S262474AbVFIV0M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 17:26:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] acpi_processor_set_power_policy
Date: Thu, 9 Jun 2005 14:26:25 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6004EF3DE3@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] acpi_processor_set_power_policy
Thread-Index: AcVsiW/lAF+7I9X2S/6zXMW1MPrBpQAr4QJg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Kenneth Parrish" <Kenneth.Parrish@family-bbs.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Jun 2005 21:25:48.0319 (UTC) FILETIME=[CDCC02F0:01C56D39]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Kenneth Parrish
>Sent: Wednesday, June 08, 2005 5:15 PM
>To: linux-kernel@vger.kernel.org
>Subject: Re: [ACPI] acpi_processor_set_power_policy
>
>-=> Kenneth Parrish wrote to All <=-
>
> KP> SEEN-BY: 8/1 2 2003
> KP> PATH: 8/2003 1 2
> KP> MSGID: 8:8/2003 122ea9cd
> KP> TZUTC: -0600
> KP> CHARSET: PC-8
> KP> From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
>
> KP> # readprofile -r ; sleep 1 ; readprofile -m /boot/System.map
> | sort -nr
>
> KP>     527 total                                      0.0003
> KP>     502 acpi_processor_set_power_policy            2.6989
> KP>       7 sort                                       0.0208
> KP>       7 release_task                               0.0208
> KP>       4 zone_watermark_ok                          0.0208
> KP>       3 do_page_fault                              0.0021
> KP>       1 unmap_page_range                           0.0057
> KP>       1 show_free_areas                            0.0013
> KP>       1 do_file_page                               0.0048
> KP>       1 buffered_rmqueue                           0.0020
>
> KP> Should acpi_processor_set_power_policy be called this often?
>
> KP> Kernel: 2.6.12-rc5-git9  # define HZ    500
> KP> <include/asm-i386/param.h> Computer: Cyrix MII and VIA MVP3,
> KP> e-machines '99 dmesg.. Kernel command line:
> KP> BOOT_IMAGE=2.6.12-rc5-git9 ro root=301 clock=tsc elevator=
> KP>  deadline lpj=376832 profile=2
> KP>  kernel profiling enabled (shift: 2)
>
> KP> More information and at request.
>
> KP> ...  A:  6-1/2" x 6-1/2" x 2"   Q: How big is the Mac Mini?
> KP> -+- MultiMail/Linux v0.46  [currently BlueWave packet type]
> KP> -
> KP> To unsubscribe from this list: send the line "unsubscribe
> KP> linux-kernel" in the body of a message to
> KP> majordomo@vger.kernel.org More majordomo info at
> KP> http://vger.kernel.org/majordomo-info.html Please read the
> KP> FAQ at http://www.tux.org/lkml/
>
> KP> --- BBBS/NT v4.01 Flag-5
> KP>  * Origin: FamilyNet Sponsored by
> KP> http://www.christian-wellness.net (8:8/2003)
>
>I noticed the subject function appears in drivers/acpi/processor_idle.c
>and tried a couple of things. Look OK? comments on the 
>[misguided?] patch?
>:-)


Are you sure that this patch is causing this difference with 
acpi_processor_set_power_policy() calls.

Looking at the code, set_power_policy() is only called at init time 
and _CST change interrupt. So, I am not sure how these changes are 
affecting it.

One guess.. System.map used in your original data may be wrong for 
that kernel, which might have caused it to point at set_power_policy() 
in place of acpi_procesor_idle()....

Thanks,
Venki

