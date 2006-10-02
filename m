Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWJBPh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWJBPh7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 11:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWJBPh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 11:37:58 -0400
Received: from emulex.emulex.com ([138.239.112.1]:12419 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S964806AbWJBPh5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 11:37:57 -0400
Message-ID: <4521324C.8060601@emulex.com>
Date: Mon, 02 Oct 2006 11:37:48 -0400
From: James Smart <James.Smart@Emulex.Com>
Reply-To: James.Smart@Emulex.Com
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Eric Sesterhenn <snakebyte@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Dereference in drivers/scsi/lpfc/lpfc_ct.c
References: <1159734706.11887.6.camel@alice>
In-Reply-To: <1159734706.11887.6.camel@alice>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Oct 2006 15:37:48.0559 (UTC) FILETIME=[B6C579F0:01C6E638]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACK - good fix.

-- james s

Eric Sesterhenn wrote:
> hi,
> 
> if we fail to allocate mp->virt during the first while
> loop iteration, mlist is still uninitialized, therefore
> we should check if before dereferencing.
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> 
> --- linux-2.6.18-git16/drivers/scsi/lpfc/lpfc_ct.c.orig	2006-10-01 22:28:37.000000000 +0200
> +++ linux-2.6.18-git16/drivers/scsi/lpfc/lpfc_ct.c	2006-10-01 22:29:10.000000000 +0200
> @@ -188,7 +188,8 @@ lpfc_alloc_ct_rsp(struct lpfc_hba * phba
>  
>  		if (!mp->virt) {
>  			kfree(mp);
> -			lpfc_free_ct_rsp(phba, mlist);
> +			if (mlist)
> +				lpfc_free_ct_rsp(phba, mlist);
>  			return NULL;
>  		}
>  
> 
> 
> 
