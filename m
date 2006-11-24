Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934214AbWKXXCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934214AbWKXXCW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 18:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757552AbWKXXCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 18:02:21 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:55707 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1757508AbWKXXCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 18:02:21 -0500
Subject: Re: [PATCH]: scsi: in2000 scsi_cmnd convertion
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Henne <henne@nachtwindheim.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <45659882.1060201@nachtwindheim.de>
References: <45659882.1060201@nachtwindheim.de>
Content-Type: text/plain
Date: Fri, 24 Nov 2006 17:01:43 -0600
Message-Id: <1164409303.2813.21.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 13:48 +0100, Henne wrote:
> -    volatile Scsi_Cmnd *input_Q;       /* commands waiting to be started */
> -    volatile Scsi_Cmnd *selecting;     /* trying to select this command */
> -    volatile Scsi_Cmnd *connected;     /* currently connected command */
> -    volatile Scsi_Cmnd *disconnected_Q;/* commands waiting for reconnect */
> +       volatile struct scsi_cmnd *input_Q;
> +                                       /* commands waiting to be started */
> +       volatile struct scsi_cmnd *selecting;
> +                                       /* trying to select this command */
> +       volatile struct scsi_cmnd *connected;
> +                                       /* currently connected command */
> +       volatile struct scsi_cmnd *disconnected_Q;

This doesn't preserve the indentation of the original.

Plus, I think if you lose the volatile then a lot of pointless casts
like this one:

> -       tmp = (Scsi_Cmnd *) hostdata->input_Q;
> +       tmp = (struct scsi_cmnd *) hostdata->input_Q;

Can be eliminated entirely (its sole job is to drop the volatile again).

James


