Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbTDRWEC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 18:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTDRWEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 18:04:02 -0400
Received: from web41807.mail.yahoo.com ([66.218.93.141]:13440 "HELO
	web41807.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263274AbTDRWD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 18:03:59 -0400
Message-ID: <20030418221552.34708.qmail@web41807.mail.yahoo.com>
Date: Fri, 18 Apr 2003 15:15:52 -0700 (PDT)
From: Christian Staudenmayer <eggdropfan@yahoo.com>
Subject: Re: kernel panic with 2.5.67-ac1
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030418103031.A9260@beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

as i mentioned, the panic also appears in 2.5.67-ac2, just in a slightly different
variant. However, the fix from bk8 you mentioned _is_ in 2.5.67-ac2 (or at least
the snippit of code that you posted).
So this probably isn't the problem here, is it?

Thanks in advance,
Christian Staudenmayer

--- Patrick Mansfield <patmans@us.ibm.com> wrote:
> On Fri, Apr 18, 2003 at 10:18:06AM -0700, Christian Staudenmayer wrote:
> > Note: this does not happen with 2.4.20, 2.4.21-pre7, 2.4.21-pre7-ac1 or 2.5.67-bk8
> > It does, however happen with 2.5.67-ac2, but the error message is some lines longer
> > and some of the addresses have changed.
> > 
> > I'd be really grateful for any insight on this problem.
> 
> We were plugging a queue that was about to be freed during scsi scan.
> 
> This is fixed in bk8, here is a snippit of part of the patch to scsi_lib.c
> that fixed the problem, or look at the end of scsi_prep_fn, (plus the
> corresponding call to blk_plug_device was removed from scsi_request_fn):
> 
> + defer:
> +       /* If we defer, the elv_next_request() returns NULL, but the
> +        * queue must be restarted, so we plug here if no returning
> +        * command will automatically do that. */
> +       if (sdev->device_busy == 0)
> +               blk_plug_device(q);
> +       return BLKPREP_DEFER;
> +}
> 
> -- Patrick Mansfield


__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com
