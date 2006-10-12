Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWJLRbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWJLRbo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWJLRbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:31:43 -0400
Received: from pat.qlogic.com ([198.70.193.2]:53124 "EHLO avexch1.qlogic.com")
	by vger.kernel.org with ESMTP id S1750806AbWJLRbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:31:42 -0400
Date: Thu, 12 Oct 2006 10:31:38 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-scsi@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SCSI/qla2xxx: handle sysfs errors
Message-ID: <20061012173138.GC4296@andrew-vasquezs-computer.local>
References: <20061012014538.GA12894@havoc.gtf.org> <20061012165734.GG3638@andrew-vasquezs-computer.local> <452E7966.7030206@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452E7966.7030206@garzik.org>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.12-2006-07-14
X-OriginalArrivalTime: 12 Oct 2006 17:31:40.0088 (UTC) FILETIME=[46CF9380:01C6EE24]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006, Jeff Garzik wrote:

> Andrew Vasquez wrote:
> >NACK, please don't do this.  SYSFS entries, albiet important, aren't
> >necessarilly critical to a functioning driver.  I'd rather the driver
> >not error out.
> 
> As discussed before, the only errors thrown are either ENOMEM or EFAULT, 
> both of which are quite serious.

Absolutely.  But, given the relatively late-stage initialization of
these attributes (it's the last thing that gets done before probe()
completes)-- the driver has already allocated (successfully) memory,
intialized hardware and (possibly) presented storage, the complete
unwinding, seems over-kill.

> >Here's what I had stewing to address the must_check directives and
> >qla2xxx:
> 
> If you're gonna change it that much, might as well use attribute groups.

sysfs_create_group() and friends don't appear to support
binary attributes.
