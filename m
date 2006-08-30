Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWH3TTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWH3TTx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWH3TTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:19:53 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:50484 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751358AbWH3TTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:19:52 -0400
Date: Wed, 30 Aug 2006 21:19:27 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [S390] cio: kernel stack overflow.
Message-ID: <20060830191927.GA8408@osiris.ibm.com>
References: <20060830124047.GA22276@skybase> <ed4nih$gb0$2@taverner.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed4nih$gb0$2@taverner.cs.berkeley.edu>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 07:05:54PM +0000, David Wagner wrote:
> Thanks for pointing out that in most cases there was immediately
> preceding code that zeroes out the whole struct using kzalloc() or
> memset(.., 0, ..).  Sorry that I overlooked that; my mistake.  That
> takes care of all but one of these.  But in the interests of caution,
> let me ask about the following one:
> 
> Martin Schwidefsky  wrote:
> >-		cdev->id = (struct ccw_device_id) {
> >-			.cu_type   = cdev->private->senseid.cu_type,
> >-			.cu_model  = cdev->private->senseid.cu_model,
> >-			.dev_type  = cdev->private->senseid.dev_type,
> >-			.dev_model = cdev->private->senseid.dev_model,
> >-		};
> >+		cdev->id.cu_type   = cdev->private->senseid.cu_type;
> >+		cdev->id.cu_model  = cdev->private->senseid.cu_model;
> >+		cdev->id.dev_type  = cdev->private->senseid.dev_type;
> >+		cdev->id.dev_model = cdev->private->senseid.dev_model;
> 
> I don't see any obvious place that zeroes out cdev->id.
> In particular, it looks like cdev->id.match_flags and .driver_info
> are never cleared (i.e., they retain whatever old garbage they had
> before).  More importantly, if anyone ever adds any more fields to
> struct ccw_device_id, then they will also be retain old garbage values,
> which is a maintenance pitfall.  Is this right, or did I miss something
> again?

You're right. Thanks for pointing this out! I will take care of it.
