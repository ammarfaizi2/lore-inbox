Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUHHQps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUHHQps (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 12:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265893AbUHHQps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 12:45:48 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:27288 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265887AbUHHQpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 12:45:46 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200408061330.i76DU2Tm005937@burner.fokus.fraunhofer.de>
References: <200408061330.i76DU2Tm005937@burner.fokus.fraunhofer.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Aug 2004 11:45:27 -0500
Message-Id: <1091983528.10960.7.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-06 at 08:30, Joerg Schilling wrote:
> I don't see any arrogance in my mails but in former discussions on LKML,
> there have been other people who did believe that they could replace missing
> knowledge by arrogance. Fortunately, they did not join this thread ;-)
> 
> Let me lead you to the right place to look for:
> 
> 	The CAM interface (which is from the SCSI standards group)
> 	usually is implemeted in a way that applications open /dev/cam and
> 	later supply bus, target and lun in order to get connected
> 	to any device on the system that talks SCSI.
> 
> Let me repeat: If you believe that this is a bad idea, give very good reasons.

Although I have always thought CAM to be a bad idea, I can give you the
best of reasons why we won't be using it:  The old standard applies to
SCSI-2 and has been superceded. The committee charged with creating the
new CAM standard was disbanded in disarray, so there is no current CAM
standard.

I know all the arguments about politics and personality clashes that
have been alleged to be behind the collapse of the new standard. 
However, in my view, it was a bad standard and the evidence of its
unworkability is simply that the committee couldn't agree on it.

For us to look at CAM again, someone will have to at least make it a
current standard.

The model which looks to me to be very workable is SAM (or at least
SAM-3).  To that end, we're already moving the linux scsi layer (which
was actually pretty transport abstracted and thus SAM conformant anyway)
further in that direction with the creation of transport classes.

James


