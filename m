Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131075AbRCGNzX>; Wed, 7 Mar 2001 08:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131080AbRCGNzN>; Wed, 7 Mar 2001 08:55:13 -0500
Received: from zeus.kernel.org ([209.10.41.242]:47581 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131075AbRCGNy4>;
	Wed, 7 Mar 2001 08:54:56 -0500
Date: Wed, 7 Mar 2001 13:51:35 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: David Balazic <david.balazic@uni-mb.si>, torvalds@transmeta.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: scsi vs ide performance on fsync's
Message-ID: <20010307135135.B3715@redhat.com>
In-Reply-To: <3AA53DC0.C6E2F308@uni-mb.si> <20010306213720.U2803@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010306213720.U2803@suse.de>; from axboe@suse.de on Tue, Mar 06, 2001 at 09:37:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 06, 2001 at 09:37:20PM +0100, Jens Axboe wrote:
> 
> SCSI has ordered tag, which fit the model Alan described quite nicely.
> I've been meaning to implement this for some time, it would be handy
> for journalled fs to use such a barrier. Since ATA doesn't do queueing
> (at least not in current Linux), a synchronize cache is probably the
> only way to go there.

Note that you also have to preserve the position of the barrier in the
elevator queue, and you need to prevent LVM and soft raid from
violating the barrier if different commands end up being sent to
different disks.

--Stephen
