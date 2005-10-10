Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbVJJRBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbVJJRBo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbVJJRBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:01:44 -0400
Received: from cantor2.suse.de ([195.135.220.15]:31383 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750948AbVJJRBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:01:43 -0400
Date: Mon, 10 Oct 2005 19:01:36 +0200
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-scsi@vger.kernel.org
Subject: Re: [SCSI] qla2xxx: fix remote port timeout with qla2xxx driver
Message-ID: <20051010170136.GA9736@suse.de>
References: <200510031643.j93GhgRY023585@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200510031643.j93GhgRY023585@hera.kernel.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Oct 03, Linux Kernel Mailing List wrote:

> tree e50f57f9c85bacf3fc07359b1a339432dea31a7a
> parent 6f3a20242db2597312c50abc11f1e747c5d2326a
> author Andrew Vasquez <andrew.vasquez@qlogic.com> Wed, 21 Sep 2005 03:32:11 -0700
> committer James Bottomley <jejb@mulgrave.(none)> Sun, 25 Sep 2005 22:11:35 -0500
> 
> [SCSI] qla2xxx: fix remote port timeout with qla2xxx driver
> diff --git a/drivers/scsi/qla2xxx/qla_rscn.c b/drivers/scsi/qla2xxx/qla_rscn.c
> --- a/drivers/scsi/qla2xxx/qla_rscn.c
> +++ b/drivers/scsi/qla2xxx/qla_rscn.c
> @@ -330,6 +330,8 @@ qla2x00_update_login_fcport(scsi_qla_hos
>  	fcport->flags &= ~FCF_FAILOVER_NEEDED;
>  	fcport->iodesc_idx_sent = IODESC_INVALID_INDEX;
>  	atomic_set(&fcport->state, FCS_ONLINE);
> +	if (fcport->rport)
> +		fc_remote_port_unblock(fcport->rport);


This patch lacks an #include, probably scsi/scsi_transport_fc.h:

drivers/scsi/qla2xxx/qla_rscn.c:334: error: implicit declaration of function 'fc_remote_port_unblock'


-- 
short story of a lazy sysadmin:
 alias appserv=wotan
