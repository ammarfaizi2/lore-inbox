Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751694AbWEKNSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWEKNSK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 09:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbWEKNSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 09:18:09 -0400
Received: from mail0.lsil.com ([147.145.40.20]:47814 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751694AbWEKNSI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 09:18:08 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH -mm] updated megaraid gcc 4.1 warning fix
Date: Thu, 11 May 2006 07:17:53 -0600
Message-ID: <890BF3111FB9484E9526987D912B261901BD64@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH -mm] updated megaraid gcc 4.1 warning fix
Thread-Index: AcZ0Vu/Ttg7NPubgR8aAm3+cg45mbAApeFYw
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Daniel Walker" <dwalker@mvista.com>, <akpm@osdl.org>
Cc: <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 May 2006 13:17:53.0723 (UTC) FILETIME=[4F9328B0:01C674FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Wednesday, May 10, 2006 1:27 PM, Daniel Walker wrote:
> drivers/scsi/megaraid.c: In function âEUR~megadev_ioctlâEUR(tm):
> drivers/scsi/megaraid.c:3665: warning: ignoring return value 
> of âEUR~copy_to_userâEUR(tm), declared with attribute warn_unused_result
Thank you for the patch. 
I accept the patch.

> -----Original Message-----
> From: Daniel Walker [mailto:dwalker@mvista.com] 
> Sent: Wednesday, May 10, 2006 1:27 PM
> To: akpm@osdl.org
> Cc: Ju, Seokmann; alan@lxorguk.ukuu.org.uk; 
> linux-kernel@vger.kernel.org
> Subject: [PATCH -mm] updated megaraid gcc 4.1 warning fix
> 
> Hows that Alan?
> 
> Fixes the following warning,
> 
> drivers/scsi/megaraid.c: In function âEUR~megadev_ioctlâEUR(tm):
> drivers/scsi/megaraid.c:3665: warning: ignoring return value 
> of âEUR~copy_to_userâEUR(tm), declared with attribute warn_unused_result
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.16/drivers/scsi/megaraid.c
> ===================================================================
> --- linux-2.6.16.orig/drivers/scsi/megaraid.c
> +++ linux-2.6.16/drivers/scsi/megaraid.c
> @@ -3662,8 +3662,9 @@ megadev_ioctl(struct inode *inode, struc
>  			 * Send the request sense data also, 
> irrespective of
>  			 * whether the user has asked for it or not.
>  			 */
> -			copy_to_user(upthru->reqsensearea,
> -					pthru->reqsensearea, 14);
> +			if (copy_to_user(upthru->reqsensearea,
> +					pthru->reqsensearea, 14))
> +				rval = (-EFAULT);
>  
>  freemem_and_return:
>  			if( pthru->dataxferlen ) {
> 
