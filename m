Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163163AbWLGSRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163163AbWLGSRD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 13:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163160AbWLGSRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 13:17:03 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:45143 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1162930AbWLGSRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 13:17:00 -0500
Subject: Re: Infinite retries reading the partition table
From: James Bottomley <James.Bottomley@SteelEye.com>
To: ltuikov@yahoo.com
Cc: Andrew Morton <akpm@osdl.org>, mdr@sgi.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <265807.57572.qm@web31813.mail.mud.yahoo.com>
References: <265807.57572.qm@web31813.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 12:16:17 -0600
Message-Id: <1165515378.4698.24.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-06 at 12:24 -0800, Luben Tuikov wrote:
> NEEDS_RETRY _does_ terminate, after it exhausts the retries.  But since
> by the ASC value we know that no amount of retries is going to work,
> this chunk of the patch resolves it quicker, i.e. eliminates the
> "NEEDS_RETRY" pointless retries (given the SK/ASC combination).

I agree that it's useful behaviour.  However, the change header should
be something like "scsi_error: don't retry for unrecoverable medium
errors" not "infinite retries .."

> > > -	if (scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
> > > +	if (good_bytes &&
> > > +	    scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
> > >  		return;
> > 
> > What exactly is this supposed to be doing?  its result is identical to
> > the code it's replacing (because of the way scsi_end_request() processes
> > its second argument), so it can't have any effect on the stated problem.
> 
> I suppose this is true, but I'd rather it not even go in
> scsi_end_request as (cmd, uptodate=1, good_bytes=0, retry=0) and complete
> at the bottom as (cmd, uptodate=0, total_xfer, retry=0).

But, logically, this isn't part of the change set ... the behaviour
you're altering is unrelated to the change set details, so this piece
shouldn't be in.

James


