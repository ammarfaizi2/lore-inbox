Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131187AbRCGVBR>; Wed, 7 Mar 2001 16:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131186AbRCGVBI>; Wed, 7 Mar 2001 16:01:08 -0500
Received: from zeus.kernel.org ([209.10.41.242]:22499 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131185AbRCGVAx>;
	Wed, 7 Mar 2001 16:00:53 -0500
Date: Wed, 7 Mar 2001 20:56:59 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        David Balazic <david.balazic@uni-mb.si>, torvalds@transmeta.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: scsi vs ide performance on fsync's
Message-ID: <20010307205659.E9080@redhat.com>
In-Reply-To: <3AA53DC0.C6E2F308@uni-mb.si> <20010306213720.U2803@suse.de> <20010307135135.B3715@redhat.com> <20010307151241.E526@suse.de> <20010307150556.L7453@redhat.com> <20010307195152.C4653@suse.de> <20010307191044.M7453@redhat.com> <20010307211536.G4653@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010307211536.G4653@suse.de>; from axboe@suse.de on Wed, Mar 07, 2001 at 09:15:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 07, 2001 at 09:15:36PM +0100, Jens Axboe wrote:
> On Wed, Mar 07 2001, Stephen C. Tweedie wrote:
> > 
> > For most fs'es, that's not an issue.  The fs won't start writeback on
> > the primary disk at all until the journal commit has been acknowledged
> > as firm on disk.
> 
> But do you then force wait on that journal commit?

It doesn't matter too much --- it's only the writeback which is doing
this (ext3 uses a separate journal thread for it), so any sleep is
only there to wait for the moment when writeback can safely begin:
users of the filesystem won't see any stalls.

> A barrier operation is sufficient then. So you're saying don't
> over design, a simple barrier is all you need?

Pretty much so.  The simple barrier is the only thing which can be
effectively optimised at the hardware level with SCSI anyway.

Cheers,
 Stephen
