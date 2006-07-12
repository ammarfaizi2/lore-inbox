Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWGLMZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWGLMZp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 08:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWGLMZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 08:25:45 -0400
Received: from mail0.lsil.com ([147.145.40.20]:47263 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1750747AbWGLMZo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 08:25:44 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Help: strange messages from kernel on IA64 platform
Date: Wed, 12 Jul 2006 06:25:40 -0600
Message-ID: <890BF3111FB9484E9526987D912B261901BE6C@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Help: strange messages from kernel on IA64 platform
Thread-Index: Acali4fKCxFF2i4vSP6lyf8hVKnUzgAIh9Qg
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Sakurai Hiroomi" <sakurai_hiro@soft.fujitsu.com>,
       <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Jul 2006 12:25:41.0060 (UTC) FILETIME=[49F93840:01C6A5AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 12, 2006 4:20 AM, Sakurai Hiroomi wrote:
> When GAM(Global Array Manager) is started, The following 
> message output.
> kernel: kernel unaligned access to 0xe0000001fe1080d4, 
> ip=0xa000000200053371
This is a patch required to address  the issue.
Thank you for the patch.

Seokmann

> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org 
> [mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of Sakurai Hiroomi
> Sent: Wednesday, July 12, 2006 4:20 AM
> To: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: Help: strange messages from kernel on IA64 platform
> 
> Hi,
> 
> I saw same message.
> 
> When GAM(Global Array Manager) is started, The following 
> message output.
> kernel: kernel unaligned access to 0xe0000001fe1080d4, 
> ip=0xa000000200053371
> 
> The uioc structure used by ioctl is defined by packed,
> the allignment of each member are disturbed.
> In a 64 bit structure, the allignment of member doesn't fit 64 bit
> boundary. this causes this messages.
> In a 32 bit structure, we don't see the message because the allinment
> of member fit 32 bit boundary even if packed is specified. 
> 
> patch
> I Add 32 bit dummy member to fit 64 bit boundary. I tested.
> We confirmed this patch fix the problem by IA64 server.
> 
> **************************************************************
> ****************
> --- linux-2.6.9/drivers/scsi/megaraid/megaraid_ioctl.h.orig	
> 2006-04-03 17:13:03.000000000 +0900
> +++ linux-2.6.9/drivers/scsi/megaraid/megaraid_ioctl.h	
> 2006-04-03 17:14:09.000000000 +0900
> @@ -132,6 +132,10 @@
>  /* Driver Data: */
>          void __user *           user_data;
>          uint32_t                user_data_len;
> +
> +        /* 64bit alignment */
> +        uint32_t                pad_0xBC;
> +
>          mraid_passthru_t        __user *user_pthru;
>  
>          mraid_passthru_t        *pthru32;
> **************************************************************
> ****************
> 
> I'm not participated in the linux-scsi mailing list.
> Please reply to the following addresses. 
> 
>     E-Mail : sakurai_hiro@soft.fujitsu.com
> 
> 
> Best regards,
> Hiroomi Sakurai
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
