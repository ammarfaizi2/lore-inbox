Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422927AbWJFU32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422927AbWJFU32 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422932AbWJFU32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:29:28 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:9153 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S1422927AbWJFU31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:29:27 -0400
Date: Fri, 6 Oct 2006 22:29:13 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Henne <henne@nachtwindheim.de>
Cc: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: Scsi_Cmnd convertion in aic7xxx_old.c
Message-ID: <20061006202913.GA7835@aepfle.de>
References: <452363DB.60107@nachtwindheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <452363DB.60107@nachtwindheim.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, Henne wrote:

> -static void
> -aic7xxx_done_cmds_complete(struct aic7xxx_host *p)
> +static void aic7xxx_done_cmds_complete(struct aic7xxx_host *p)
>  {
> -  Scsi_Cmnd *cmd;
> -  
> -  while (p->completeq.head != NULL)
> -  {
> -    cmd = p->completeq.head;
> -    p->completeq.head = (Scsi_Cmnd *)cmd->host_scribble;
> -    cmd->host_scribble = NULL;
> -    cmd->scsi_done(cmd);
> -  }
> +	
> +	struct scsi_cmnd *cmd;
> +	
> +	while (p->completeq.head != NULL) {
> +		cmd = p->completeq.head;
> +		p->completeq.head = (struct scsi_Cmnd *) cmd->host_scribble;

This one should be struct scsi_cmnd * as well?
