Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbSKMP3U>; Wed, 13 Nov 2002 10:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbSKMP3U>; Wed, 13 Nov 2002 10:29:20 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:53263 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S261914AbSKMP3T>;
	Wed, 13 Nov 2002 10:29:19 -0500
Date: Wed, 13 Nov 2002 16:36:09 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VFAT mount (bug or feature?)
Message-ID: <20021113153609.GA442@win.tue.nl>
References: <20021113014704.780a3e4a.us15@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021113014704.780a3e4a.us15@os.inf.tu-dresden.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 01:47:04AM +0100, Udo A. Steinberg wrote:

> In my /etc/fstab I have the following entry:
> 
> /dev/hda1  /win   vfat   defaults,umask=022  1 1
> 
> Why does 2.5.47 have user/group restricted permissions on the mount
> point and all its subdirectories, despite the umask setting?

Yes. This is due to a somewhat buggy change in 2.5.43.

(In the good old days umask had a well-defined meaning;
today on recent 2.5 and with vfat, but not with ntfs,
it means something else.)

The correct change would have been to add both dmask and fmask,
just like ntfs did, and leave the meaning of umask alone.

(I made a patch a few days ago, but have not yet found
the time to submit it to Linus. Maybe tomorrow,
if nobody else does it first.)

Andries
