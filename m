Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbUEOKOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUEOKOX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 06:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUEOKOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 06:14:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37813 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261505AbUEOKOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 06:14:21 -0400
Date: Sat, 15 May 2004 12:14:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniele Bernardini <db@sqbc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dma ripping
Message-ID: <20040515101415.GA24600@suse.de>
References: <1084548566.12022.57.camel@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084548566.12022.57.camel@linux.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14 2004, Daniele Bernardini wrote:
> Hi Folks, 
> 
> I am trying to get cd ripping to work on a freshly installed SuSE 9.1 on
> IBM thinkpad R50 with dvdram drive. 
> 
> It works for a while and then hangs. At this point nothing short of a
> reboot works. Ripping stop working when the message 
> 	cdrom: dropping to single frame dma
> comes up. The system feels slow for a couple of seconds and then is back
> to normal, but no ripping until next reboot
> 
> I am running the 2.6.4 compiled by SuSE.

Can you retest with this small debug patch applied.

--- drivers/cdrom/cdrom.c~	2004-05-15 12:12:24.770228291 +0200
+++ drivers/cdrom/cdrom.c	2004-05-15 12:13:25.101720866 +0200
@@ -1987,6 +1987,7 @@
 			struct request_sense *s = rq->sense;
 			ret = -EIO;
 			cdi->last_sense = s->sense_key;
+			printk("rip failed, sense %x/%x/%x\n", s->sense_key, s->asc, s->ascq);
 		}
 
 		if (blk_rq_unmap_user(rq, ubuf, bio, len))

-- 
Jens Axboe

