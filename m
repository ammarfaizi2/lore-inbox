Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTIZMTm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 08:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTIZMRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 08:17:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62162 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262056AbTIZMRE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 08:17:04 -0400
Date: Fri, 26 Sep 2003 13:17:03 +0100
From: Matthew Wilcox <willy@debian.org>
To: Steven Dake <sdake@mvista.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG using multipath on 2.6.0-test5
Message-ID: <20030926121703.GG24824@parcelfarce.linux.theplanet.co.uk>
References: <1064541435.4763.51.camel@persist.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064541435.4763.51.camel@persist.az.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 06:57:15PM -0700, Steven Dake wrote:
> kernel BUG at drivers/scsi/scsi_lib.c:544!

        BUG_ON(!cmd->use_sg);

>  [<c01f631d>] scsi_init_io+0x7a/0x13d

static int scsi_init_io(struct scsi_cmnd *cmd)
        struct request     *req = cmd->request;
        cmd->use_sg = req->nr_phys_segments;
        sgpnt = scsi_alloc_sgtable(cmd, GFP_ATOMIC);

>  [<c01f6455>] scsi_prep_fn+0x75/0x171

static int scsi_prep_fn(struct request_queue *q, struct request *req)
        struct scsi_cmnd *cmd;
        cmd->request = req;
        ret = scsi_init_io(cmd);

... this is getting outside my area of confidence.  Ask axboe why we might
get a zero nr_phys_segments request passed in.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
