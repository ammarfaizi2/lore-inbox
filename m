Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269324AbRGaPka>; Tue, 31 Jul 2001 11:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269325AbRGaPkU>; Tue, 31 Jul 2001 11:40:20 -0400
Received: from mail.zmailer.org ([194.252.70.162]:58372 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S269324AbRGaPkO>;
	Tue, 31 Jul 2001 11:40:14 -0400
Date: Tue, 31 Jul 2001 18:40:03 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Lawrence Greenfield <leg+@andrew.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010731184003.X2650@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.33L.0107302219340.5582-100000@duckman.distro.conectiva> <200107310525.f6V5P6HE002271@acap-dev.nas.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107310525.f6V5P6HE002271@acap-dev.nas.cmu.edu>; from leg+@andrew.cmu.edu on Tue, Jul 31, 2001 at 01:25:06AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

  The thing about filesystems, and how dimmly MTAs (should) consider
  some performance tweaks is something I have tried to describe at
  ZMailer's manual in part about its the queue:

      http://www.zmailer.org/zman/zadm-queues.html

On Tue, Jul 31, 2001 at 01:25:06AM -0400, Lawrence Greenfield wrote:
...
> It's not as good as fsync() just doing what it's suppose to do.
> You'll force applications that want to issue multiple link()s to issue
> multiple lsync()s, forcing the kernel to serialize all of the disk
> writes when the application just wants one file (and all of it's
> associated filenames) to disk.
> 
> Yes, I understand that implementing fsync() so that it syncs all names
> to reach the file is difficult.  But if you want the best performance,
> you don't want to make applications issue multiple calls each of which
> force their own synchronous writes.
> 
> Not to mention us whiny application writers won't be happy throwing
> lsync()s all over the place.
> 
> Larry

   I quite agree.

   Filesystems are not, unfortunately, rollbackfull logged and committable
   databases, even if we like to use them often in that way.

   An MTA with a fundamental design point of not using any privileged
   programs (no suid anything!) and least esoteric technology possible
   (for wide portability) can only use message submission means available
   to it everywhere -- implementing the queue inside a database system
   is definitely a possibility.   Possibly yielding higher performance
   than one using filesystem for it, but at what cost ??
   (I am thinking of SleepyCat DB multiaccess transaction supported
    version.)

/Matti Aarnio
