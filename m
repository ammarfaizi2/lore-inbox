Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267839AbUHPR7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267839AbUHPR7c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 13:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267841AbUHPR7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 13:59:31 -0400
Received: from 130.67-18-18.reverse.theplanet.com ([67.18.18.130]:16325 "EHLO
	server3.imagelinkusa.net") by vger.kernel.org with ESMTP
	id S267838AbUHPR7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 13:59:20 -0400
Subject: Re: growisofs stopped working with 2.6.8
From: "Tony A. Lambley" <tal@vextech.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
In-Reply-To: <1092672062.20838.29.camel@localhost.localdomain>
References: <1092674287.3021.19.camel@bony>
	 <1092672062.20838.29.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1092679156.2393.8.camel@bony>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 13:59:16 -0400
Content-Transfer-Encoding: 7bit
X-PopBeforeSMTPSenders: jo@vextech.net,vextech
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server3.imagelinkusa.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - vextech.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It still fails, but I get a different message with the patch:

$ growisofs -Z /dev/dvd=file.iso
Executing 'builtin_dd if=file.iso of=/dev/dvd obs=32k seek=0'
:-( unable to PREVENT MEDIA REMOVAL: Operation not permitted

K3B fails with the same message as above.

As you say, it does indeed burn fine as root.


On Mon, 2004-08-16 at 12:01, Alan Cox wrote:
> On Llu, 2004-08-16 at 17:38, Tony A. Lambley wrote:
> > Hi, burning a dvd iso now fails :(
> > 
> > $ growisofs -Z /dev/hdc=file.iso
> > :-( unable to GET CONFIGURATION: Operation not permitted
> > :-( non-MMC unit?
> 
> We fixed some security holes. In doing so we tightened up so a few apps
> that worked before no longer work except as root. Thanks for the error
> message. Thats helpful as it suggests the following patch.
> 
> (and does it help K3B ?)
> 
> 
> 
> 
> 
> 
> ______________________________________________________________________
> --- drivers/block/scsi_ioctl.c~	2004-08-16 18:01:36.627301624 +0100
> +++ drivers/block/scsi_ioctl.c	2004-08-16 18:01:36.627301624 +0100
> @@ -146,6 +146,7 @@
>  		safe_for_read(GPCMD_READ_TOC_PMA_ATIP),
>  		safe_for_read(GPCMD_REPORT_KEY),
>  		safe_for_read(GPCMD_SCAN),
> +		safe_for_read(GPCMD_GET_CONFIGURATION),
>  
>  		/* Basic writing commands */
>  		safe_for_write(WRITE_6),

