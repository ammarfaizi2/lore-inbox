Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131094AbRCGONx>; Wed, 7 Mar 2001 09:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131097AbRCGONo>; Wed, 7 Mar 2001 09:13:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16395 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131094AbRCGON3>;
	Wed, 7 Mar 2001 09:13:29 -0500
Date: Wed, 7 Mar 2001 15:12:41 +0100
From: Jens Axboe <axboe@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: David Balazic <david.balazic@uni-mb.si>, torvalds@transmeta.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: scsi vs ide performance on fsync's
Message-ID: <20010307151241.E526@suse.de>
In-Reply-To: <3AA53DC0.C6E2F308@uni-mb.si> <20010306213720.U2803@suse.de> <20010307135135.B3715@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010307135135.B3715@redhat.com>; from sct@redhat.com on Wed, Mar 07, 2001 at 01:51:35PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07 2001, Stephen C. Tweedie wrote:
> > SCSI has ordered tag, which fit the model Alan described quite nicely.
> > I've been meaning to implement this for some time, it would be handy
> > for journalled fs to use such a barrier. Since ATA doesn't do queueing
> > (at least not in current Linux), a synchronize cache is probably the
> > only way to go there.
> 
> Note that you also have to preserve the position of the barrier in the
> elevator queue, and you need to prevent LVM and soft raid from
> violating the barrier if different commands end up being sent to
> different disks.

Yep, it's much harder than it seems. Especially because for the barrier
to be really useful, having inter-request dependencies becomes a
requirement. So you can say something like 'flush X and Y, but don't
flush Y before X is done'.

-- 
Jens Axboe

