Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVCAIOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVCAIOQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 03:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVCAIOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 03:14:15 -0500
Received: from borg.st.net.au ([65.23.158.22]:59847 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S261380AbVCAINd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 03:13:33 -0500
Message-ID: <4224245E.6090503@torque.net>
Date: Tue, 01 Mar 2005 18:14:22 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] SCSI: possible cleanups
References: <20050228213159.GO4021@stusta.de>
In-Reply-To: <20050228213159.GO4021@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Before I'm getting flamed to death:

Adrian,
I have a few comments below.

> This patch contains possible cleanups. If parts of this patch conflict 
> with pending changes these parts of my patch have to be dropped.
> 
> This patch contains the following possible cleanups:
> - make needlessly global code static
> - remove or #if 0 the following unused functions:
>   - scsi.h: print_driverbyte
>   - scsi.h: print_hostbyte

The names of the above are too general so they should go
as soon as practical.

>   - constants.c: scsi_print_hostbyte
>   - constants.c: scsi_print_driverbyte

I'm a bit surprised nothing else is using the above two.

>   - scsi_scan.c: scsi_scan_single_target
> - remove the following unneeded EXPORT_SYMBOL's:
>   - constants.c: __scsi_print_sense
>   - hosts.c: scsi_host_lookup
>   - scsi.c: scsi_device_cancel
>   - scsi_error.c: scsi_normalize_sense

I introduced scsi_normalize_sense() recently, Christoph H.
proposed it should be static but Luben Tuikov (aic7xxx
maintainer) said he wished to use it in the future.
Hence it was left global.

>   - scsi_error.c: scsi_sense_desc_find

A pending patch on st from Kai M. will be using
scsi_sense_desc_find(). I presume others will be using
it in the future (e.g. SAT returns ATA status via
a sense data descriptor with no corresponding fixed
format representation).

>   - scsi_lib.c: scsi_device_resume
>   - scsi_scan.c: scsi_rescan_device
>   - scsi_scan.c: scsi_scan_single_target

Doug Gilbert

