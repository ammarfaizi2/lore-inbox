Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269856AbUJMVXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269856AbUJMVXg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 17:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269863AbUJMVVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 17:21:47 -0400
Received: from havoc.gtf.org ([69.28.190.101]:26788 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S269858AbUJMVVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 17:21:09 -0400
Date: Wed, 13 Oct 2004 17:21:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: mikem@beardog.cca.cpqcorp.net
Cc: akpm@osdl.org, axboe@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: cciss update [1/2] updates our SCSI support to not use deprecated headers
Message-ID: <20041013212105.GA4438@havoc.gtf.org>
References: <20041013211302.GA9866@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041013211302.GA9866@beardog.cca.cpqcorp.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 04:13:02PM -0500, mike.miller@hjp.com wrote:
> @@ -552,11 +547,12 @@ cciss_scsi_setup(int cntl_num)
>  static void
>  complete_scsi_command( CommandList_struct *cp, int timeout, __u32 tag)
>  {
> -	Scsi_Cmnd *cmd;
> +	struct scsi_cmnd *cmd;
>  	ctlr_info_t *ctlr;
>  	u64bit addr64;
>  	ErrorInfo_struct *ei;
>  
> +	cmd = kmalloc(sizeof(struct scsi_cmnd), GFP_KERNEL);
>  	ei = cp->err_info;
>  

This can get called from the interrupt handler, so GFP_KERNEL won't
work.  GFP_ATOMIC works, but you need to check kmalloc() return for
NULL.

	Jeff



