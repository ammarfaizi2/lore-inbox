Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261327AbTCJP3I>; Mon, 10 Mar 2003 10:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261329AbTCJP3I>; Mon, 10 Mar 2003 10:29:08 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:45840 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S261327AbTCJP3G>; Mon, 10 Mar 2003 10:29:06 -0500
Date: Mon, 10 Mar 2003 08:39:39 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: mzyngier@freesurf.fr
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EISA aic7770 broken
Message-ID: <600340000.1047310779@aslan.scsiguy.com>
In-Reply-To: <wrpptozbqsr.fsf@hina.wild-wind.fr.eu.org>
References: <wrp65qscwxx.fsf@hina.wild-wind.fr.eu.org>	<229560000.1047229710@aslan.scsiguy.com>
 	<wrp1y1gcv96.fsf@hina.wild-wind.fr.eu.org>	<301080000.1047244547@aslan.scsiguy.com> <wrpptozbqsr.fsf@hina.wild-wind.fr.eu.org>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>> "Justin" == Justin T Gibbs <gibbs@scsiguy.com> writes:
> 
> Justin> Define crashes badly.  Driver messages or kernel panic strings
> Justin> typically help.
> 
> Here it is :
> 
> <quote>
> [...]
> (scsi1:A:5): 10.000MB/s transfers (10.000MHz, offset 15)
>   Vendor: NEC       Model: CD-ROM DRIVE:464  Rev: 1.05
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
>         <Adaptec 274X SCSI adapter>
>         aic7770: Twin Channel, A SCSI Id=7, B SCSI Id=7, primary A, 4/253 SCBs
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> c01f8cec
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0060:[<c01f8cec>]    Not tainted
> EFLAGS: 00010046
> EIP is at ahc_runq_tasklet+0x54/0x140

This is so close to the beginning of the function, that it only makes
sense that "ahc" is NULL.  Can you instrument both ahc_runq_tasklet()
and ahc_platform_alloc() to see if it is indeed the case that "ahc"
is NULL, and to verify that "ahc" was valid when we registered the
tasklet?

--
Justin

