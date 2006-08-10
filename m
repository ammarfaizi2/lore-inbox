Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422645AbWHJRdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbWHJRdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422643AbWHJRdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:33:12 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:64959 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1422642AbWHJRdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:33:10 -0400
Subject: Re: [PATCH 1/1] scsi : megaraid_{mm, mbox} : irq data type fix
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Seokmann Ju <sju@lsil.com>
Cc: Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1155228887.6698.7.camel@dhcp-65-957.se.lsil.com>
References: <1155228887.6698.7.camel@dhcp-65-957.se.lsil.com>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 12:32:51 -0500
Message-Id: <1155231171.3670.32.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 12:54 -0400, Seokmann Ju wrote:
> This patch fixes incorrect irq data type in the driver which led driver initialization failure in some cases.
> The problem was reported by Eric @. Biederman <ebiederm@xmission.com>.
[...]
> 	uint32_t		unique_id;
> -	uint8_t			irq;
> +	unsigned int		irq;
>  	uint8_t			ito;

This doesn't look right ... you're altering the size of a packed field
within the ioctl body.  This will break the ioctl ABI (and thus all
tools which use it) unless you employ versioning or some other mechanism
to detect the breakage and compensate.  I really don't think you want to
do this.

James


