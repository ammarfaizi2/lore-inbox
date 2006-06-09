Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965276AbWFIO2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965276AbWFIO2a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 10:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965274AbWFIO2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 10:28:30 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:52699 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965262AbWFIO23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 10:28:29 -0400
Subject: Re: [PATCH 2/3] SCSI core and sd: early detection of medium not
	present
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       SCSI development list <linux-scsi@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0606091007370.16847-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0606091007370.16847-100000@netrider.rowland.org>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 09:28:10 -0500
Message-Id: <1149863290.3480.10.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 10:13 -0400, Alan Stern wrote:
> I did it that way in the patch because it was the only simple choice.  The 
> scsi_test_unit_ready() routine is part of the SCSI core and can be called 
> for devices that aren't disks.  Hence any flag it sets cannot be part of 
> the scsi_disk structure.

The slightly more complex choice that would be to extend
scsi_test_unit_ready() to allow the sending of a sense header pointer.
Then any user could use the sense return data for setting local
flags ... and thus, they could be kept local.

> In principle the information could be conveyed in the return value from 
> scsi_test_unit_ready() rather than in a static flag.  But the routine has 
> several callers and I didn't want to change all of them to recognize a 
> -ENOMEDIUM return code.  Now in the long run, perhaps that would be a good 
> thing to do.  Or perhaps moving the flag to scsi_device would be better, I 
> don't know...
> 
> Ultimately this boils down to how you want to represent "No medium 
> present" in the SCSI core.  What do you think is the bets way?

Well ... that's where I think we follow the CD people, since they're the
ones who have this occurring the most often.

James


