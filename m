Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130253AbRCGUQn>; Wed, 7 Mar 2001 15:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131172AbRCGUQd>; Wed, 7 Mar 2001 15:16:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42253 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130253AbRCGUQP>;
	Wed, 7 Mar 2001 15:16:15 -0500
Date: Wed, 7 Mar 2001 21:15:36 +0100
From: Jens Axboe <axboe@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: David Balazic <david.balazic@uni-mb.si>, torvalds@transmeta.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: scsi vs ide performance on fsync's
Message-ID: <20010307211536.G4653@suse.de>
In-Reply-To: <3AA53DC0.C6E2F308@uni-mb.si> <20010306213720.U2803@suse.de> <20010307135135.B3715@redhat.com> <20010307151241.E526@suse.de> <20010307150556.L7453@redhat.com> <20010307195152.C4653@suse.de> <20010307191044.M7453@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010307191044.M7453@redhat.com>; from sct@redhat.com on Wed, Mar 07, 2001 at 07:10:44PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07 2001, Stephen C. Tweedie wrote:
> On Wed, Mar 07, 2001 at 07:51:52PM +0100, Jens Axboe wrote:
> > On Wed, Mar 07 2001, Stephen C. Tweedie wrote:
> > 
> > My bigger concern is when the journalled fs has a log on a different
> > queue.
> 
> For most fs'es, that's not an issue.  The fs won't start writeback on
> the primary disk at all until the journal commit has been acknowledged
> as firm on disk.

But do you then force wait on that journal commit?

> Certainly for ext3, synchronisation between the log and the primary
> disk is no big thing.  What really hurts is writing to the log, where
> we have to wait for the log writes to complete before submitting the
> commit write (which is sequentially allocated just after the rest of
> the log blocks).  Specifying a barrier on the commit block would allow
> us to keep the log device streaming, and the fs can deal with
> synchronising the primary disk quite happily by itself.

A barrier operation is sufficient then. So you're saying don't
over design, a simple barrier is all you need?

-- 
Jens Axboe

