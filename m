Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317832AbSFMVBr>; Thu, 13 Jun 2002 17:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317830AbSFMVBq>; Thu, 13 Jun 2002 17:01:46 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:56306 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S317829AbSFMVBp>; Thu, 13 Jun 2002 17:01:45 -0400
Date: Thu, 13 Jun 2002 17:01:41 -0400
From: Doug Ledford <dledford@redhat.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: axboe@suse.de, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Proposed changes to generic blk tag for use in SCSI (1/3)
Message-ID: <20020613170141.B4609@redhat.com>
Mail-Followup-To: James Bottomley <James.Bottomley@steeleye.com>,
	axboe@suse.de, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <200206110246.g5B2kia06902@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 10:46:44PM -0400, James Bottomley wrote:
> 2) The SCSI queue will stall if it gets an untagged request in the stream, so 
> once tagged queueing is enabled, all commands (including SPECIALS) must be 
> tagged.  I altered the check in blk_queue_start_tag to permit this.

Hmmm...this seems broken to me.  Switching from tagged to untagged 
momentarily and then back is perfectly valid.  Can the bio layer 
handle this and not the scsi layer, or are both layers unable to handle 
this sort of tag manipulation? 

> There are several shortcomings of the prototype, most notably it doesn't have 
> tag starvation detection and processing.  However, I think I can re-introduce 
> this as part of the error handler functions.

If you are using the bio layer tag processing, then it should be 
doing this part I would think.  If it isn't, then it sounds like either 
it's design is missing some key elements required to be fully functional 
or the integration between the scsi layer and the bio layer needs some 
additional work.


-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  

