Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTDPTya (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 15:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbTDPTya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 15:54:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:6380 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264300AbTDPTy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 15:54:28 -0400
Date: Wed, 16 Apr 2003 13:07:26 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Gert Vervoort <gert.vervoort@hccnet.nl>
Cc: Patrick Mansfield <patmans@us.ibm.com>, tconnors@astro.swin.edu.au,
       Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
Message-ID: <20030416200726.GG3436@beaverton.ibm.com>
Mail-Followup-To: Gert Vervoort <gert.vervoort@hccnet.nl>,
	Patrick Mansfield <patmans@us.ibm.com>, tconnors@astro.swin.edu.au,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <1050172083.2291.459.camel@localhost> <3E993C54.40805@hccnet.nl> <1050255133.733.6.camel@localhost> <3E99A1E4.30904@hccnet.nl> <20030415120000.A30422@beaverton.ibm.com> <3E9C6F10.10001@hccnet.nl> <20030415144051.A31514@beaverton.ibm.com> <3E9D984F.20402@hccnet.nl> <20030416110529.A5782@beaverton.ibm.com> <3E9DB2D2.4070401@hccnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9DB2D2.4070401@hccnet.nl>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gert Vervoort [gert.vervoort@hccnet.nl] wrote:
> The following workaround is needed to make the patch compile  (otherwise 
> the linker complains about scsi_queue_next_request not being defined):
> 
> --- scsi_lib.c.1        2003-04-16 21:23:37.000000000 +0200
> +++ scsi_lib.c  2003-04-16 21:23:46.000000000 +0200
> @@ -351,7 +351,7 @@
>  *             permutations grows as 2**N, and if too many more special 
> cases
>  *             get added, we start to get screwed.
>  */
> -static void scsi_queue_next_request(request_queue_t *q, struct 
> scsi_cmnd *cmd)
> +/*static*/ void scsi_queue_next_request(request_queue_t *q, struct 
> scsi_cmnd *cmd)
> {
>        struct scsi_device *sdev, *sdev2;
>        struct Scsi_Host *shost;

The static removal is present already in bk current.

-andmike
--
Michael Anderson
andmike@us.ibm.com

