Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262717AbVCJQfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbVCJQfe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVCJQcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:32:10 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:15891 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262192AbVCJQan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:30:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=uGqiSxuYdcojPFLtEGrO0oc7LuewafTwk32z0dKX/NDS5WEFCS4xiALVokdJYeHNWq/OxD9x26ZuR1YEiWBHVg0ydJwNcnNePo/6GWHVKNSBiIXL2wNp2SHSu0v+lsHZ3O6jNTnaOFDx55sqTDgrhhntT3K/v6zMOLKMJlFYzTE=
Message-ID: <58cb370e05031008307a0163c1@mail.gmail.com>
Date: Thu, 10 Mar 2005 17:30:35 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ide: hdio.txt update
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050303021638.GA24150@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050302235457.GA21352@htj.dyndns.org>
	 <20050303021638.GA24150@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 3 Mar 2005 11:16:38 +0900, Tejun Heo <htejun@gmail.com> wrote:

> +         [2] Both the input and output buffers are copied from the
> +         user and written back to the user, even when not used.  The
> +         out_flags and in_flags are written back to the user after
> +         the ioctl completes.  These are the same as the input
> +         values, unchanged.

This is incorrect, please refer to flagged_taskfile() and ide_taskfile_ioctl().
Unfortunately you've based your latest patch series on this assumption.

> +         Taskfile registers are read back from the drive into
> +         {io|hob}_ports[] after the command completes iff one of the
> +         following conditions is met; otherwise, the original values
> +         will be written back, unchanged.
> +
> +           1. The drive fails the command (EIO).
> +           2. More than one bit is set in tf_out_flags.

Isn't one bit enough?

The rest is of the update is fine, thanks for doing this.

Bartlomiej
