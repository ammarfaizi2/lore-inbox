Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131260AbRCHCqw>; Wed, 7 Mar 2001 21:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131261AbRCHCqm>; Wed, 7 Mar 2001 21:46:42 -0500
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:18161
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S131260AbRCHCqd>; Wed, 7 Mar 2001 21:46:33 -0500
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: "Tom Sightler" <ttsig@tuxyturvy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Questions about Enterprise Storage with Linux
Date: Wed, 7 Mar 2001 20:11:01 -0600
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <E14an7j-0001rZ-00@the-village.bc.nu> <20010307164052.B788@wirex.com> <006301c0a765$3ca118e0$1601a8c0@zeusinc.com>
In-Reply-To: <006301c0a765$3ca118e0$1601a8c0@zeusinc.com>
MIME-Version: 1.0
Message-Id: <01030720460701.06635@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Mar 2001, Tom Sightler wrote:
>Hi All,
>
>I'm seeking information in regards to a large Linux implementation we are
>planning.  We have been evaluating many storage options and I've come up
>with some questions that I have been unable to answer as far as Linux
>capabilities in regards to storage.
>
>We are looking at storage systems that provide approximately 1TB of capacity
>for now and can scale to 10+TB in the future.  We will almost certainly use
>a storage system that provides both fiber channel connectivity as well as
>NFS connectivity.
>
>The questions that have been asked are as follows (assume 2.4.x kernels):
>
>1.  What is the largest block device that linux currently supports?  i.e.
>Can I create a single 1TB volume on my storage device and expect linux to
>see it and be able to format it?

Checkout the GFS project for really large filesystems with a high capability
of "fail safe" configuration.

The block/file limits are more determined by the size of the hosts. Alpha/Sparc
based systems use 64 bit operations, Intel/AMD use 32 bit. It also depends
on usage of the sign bit in the drivers. Most 32bit systems are limited
to 1 TB (depending on the driver of course - some allow for 2 TB).

>2.  Does linux have any problems with large (500GB+) NFS exports, how about
>large files over NFS?

I can't really say - you might clarify by what you count as large ( just > 2G
should be fine for any current kernel), not sure if "large" means 25-100GB.

>3.  What filesystem would be best for such large volumes?  We currently use
>reirserfs on our internal system, but they generally have filesystems in the
>18-30GB ranges and we're talking about potentially 10-20x that.  Should we
>look at JFS/XFS or others?

The GFS project already has tested 2TB in fiber channel array(s) with full
multi-host connectivity (shared filesystems rather than NFS). See:

http://www.sistina.com/gfs/

for details. It is not currently included in Linux distribution. The
current GFS version is 4.0 and works in kernel 2.2.18 and higher.

The big advantage with GFS is that redundant servers can be available
by having two or more NFS servers attached to the same GFS filesystem.

>4.  We're seriously considering using LVM for volume management.  Does it
>have size limits per volume or other limitations that we should be aware of?

GFS may serve better. It is a full shared filesystem with RAID target disks
(these are smart controllers) and incudes journaling.

>I'm sure these answers are out there, but I haven't been able to find
>definitive answers (it seems everyone has a different answer to each
>question).  Any assistance in pointing me to the correct information would
>be greatly appreciated.

I haven't had direct expierence with GFS, but it looks very impressive in
the documentation.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
