Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422769AbWBNTvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422769AbWBNTvt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422770AbWBNTvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:51:48 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:46859 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1422769AbWBNTvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:51:38 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: rio driver, boot code (1 of 3)
Date: Tue, 14 Feb 2006 19:38:12 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, apkm@osdl.org
References: <1139944938.11979.5.camel@localhost.localdomain>
In-Reply-To: <1139944938.11979.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602141938.12041.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 19:22, Alan Cox wrote:
> This patch expands the HOST_DISABLE macro in rioboot.c. This is good
> anyway to remove obfuscation but also neccessary so that indent will
> process the file correctly.
>
> Signed-off-by: Alan Cox <alan@redhat.com>
>
> --- linux.vanilla-2.6.16-rc3/drivers/char/rio/rioboot.c	2006-02-14
> 17:08:55.000000000 +0000 +++
> linux-2.6.16-rc3/drivers/char/rio/rioboot.c	2006-02-14 19:07:26.551366016
> +0000 @@ -493,14 +493,10 @@
>  		if ( RWORD(HostP->__ParmMapR) == OldParmMap ) {
>  			rio_dprintk (RIO_DEBUG_BOOT, "parmmap 0x%x\n",
> RWORD(HostP->__ParmMapR)); rio_dprintk (RIO_DEBUG_BOOT, "RIO Mesg Run
> Fail\n");
> -
> -#define	HOST_DISABLE \
> -		HostP->Flags &= ~RUN_STATE; \
> -		HostP->Flags |= RC_STUFFED; \
> -		RIOHostReset( HostP->Type, (struct DpRam *)HostP->CardP, HostP->Slot );\
> -		continue
> -
> -			HOST_DISABLE;
> +			HostP->Flags &= ~RUN_STATE; \
> +			HostP->Flags |= RC_STUFFED; \
> +			RIOHostReset( HostP->Type, (struct DpRam *)HostP->CardP, HostP->Slot);\ 
> +			continue

Missing semicolon, maybe lose the \ .

>  		}
>
>  		rio_dprintk (RIO_DEBUG_BOOT, "Running 0x%x\n",
> RWORD(HostP->__ParmMapR)); @@ -528,7 +524,10 @@
>  		if ( (RWORD(ParmMapP->links) & 0xFFFF) != 0xFFFF ) {
>  			rio_dprintk (RIO_DEBUG_BOOT, "RIO Mesg Run Fail %s\n", HostP->Name);
>  			rio_dprintk (RIO_DEBUG_BOOT, "Links = 0x%x\n",RWORD(ParmMapP->links));
> -			HOST_DISABLE;
> +			HostP->Flags &= ~RUN_STATE; \
> +			HostP->Flags |= RC_STUFFED; \
> +			RIOHostReset( HostP->Type, (struct DpRam *)HostP->CardP, HostP->Slot);\ 
> +			continue

Ditto.

>  		}
>
>  		WWORD(ParmMapP->links , RIO_LINK_ENABLE);
> @@ -550,7 +549,10 @@
>  							!RWORD(ParmMapP->init_done) ) {
>  			rio_dprintk (RIO_DEBUG_BOOT, "RIO Mesg Run Fail %s\n", HostP->Name);
>  			rio_dprintk (RIO_DEBUG_BOOT, "Timedout waiting for init_done\n");
> -			HOST_DISABLE;
> +			HostP->Flags &= ~RUN_STATE; \
> +			HostP->Flags |= RC_STUFFED; \
> +			RIOHostReset( HostP->Type, (struct DpRam *)HostP->CardP, HostP->Slot
> );\ +			continue

Aaand the same.. another reason why macros like these are evil.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
