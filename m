Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbTI3RUW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 13:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbTI3RUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 13:20:22 -0400
Received: from havoc.gtf.org ([63.247.75.124]:19650 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261621AbTI3RUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 13:20:17 -0400
Date: Tue, 30 Sep 2003 13:16:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linas@austin.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: [2.4 PATCH:] Lengthen SCSI timeouts to deal with broken hardware
Message-ID: <20030930171619.GA22314@gtf.org>
References: <20030930120944.A31772@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930120944.A31772@forte.austin.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 12:09:44PM -0500, linas@austin.ibm.com wrote:
> 
> 
> --- drivers/scsi/scsi_obsolete.c.orig	2003-09-29 17:47:26.000000000 -0500
> +++ drivers/scsi/scsi_obsolete.c	2003-09-29 17:51:40.000000000 -0500
> @@ -118,10 +118,19 @@ static void scsi_dump_status(void);
>  #define ABORT_TIMEOUT SCSI_TIMEOUT
>  #define RESET_TIMEOUT SCSI_TIMEOUT
>  #else
> +#if defined(__powerpc64__)
> +/* Some Achip ARC765-based DVD-ROM's can take 15 seconds or more to reset.
> + * All commands (sense, abort) will not get a response until the reset 
> + * completes.  Lengthen timeouts to make up for this. */
> +#define SENSE_TIMEOUT (20*HZ)
> +#define RESET_TIMEOUT (2*HZ)
> +#define ABORT_TIMEOUT (25*HZ)

This should be device-dependent, not platform-dependent.

	Jeff



