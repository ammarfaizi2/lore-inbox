Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265793AbRFXXTl>; Sun, 24 Jun 2001 19:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265791AbRFXXTb>; Sun, 24 Jun 2001 19:19:31 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:42506 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265794AbRFXXTQ>; Sun, 24 Jun 2001 19:19:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: FAT32 superiority over ext2 :-)
Date: Mon, 25 Jun 2001 01:22:17 +0200
X-Mailer: KMail [version 1.2]
Cc: viro@math.psu.edu, phillips@bonn-fries.net, chaffee@cs.berkeley.edu,
        storner@image.dk, mnalis-umsdos@voyager.hr
In-Reply-To: <200106242254.f5OMsxQ405511@saturn.cs.uml.edu>
In-Reply-To: <200106242254.f5OMsxQ405511@saturn.cs.uml.edu>
MIME-Version: 1.0
Message-Id: <0106250122170H.00430@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 June 2001 00:54, Albert D. Cahalan wrote:
> By dumb luck (?), FAT32 is compatible with the phase-tree algorithm
> as seen in Tux2. This means it offers full data integrity.
> Yep, it whips your typical journalling filesystem. Look at what
> we have in the superblock (boot sector):
>
>     __u32  fat32_length;  /* sectors/FAT */
>     __u16  flags;         /* bit 8: fat mirroring, low 4: active fat */
>     __u8   version[2];    /* major, minor filesystem version */
>     __u32  root_cluster;  /* first cluster in root directory */
>     __u16  info_sector;   /* filesystem info sector */
>
> All in one atomic write, one can...
>
> 1. change the active FAT
> 2. change the root directory
> 3. change the free space count
>
> That's enough to atomically move from one phase to the next.
> You create new directories in the free space, and make FAT
> changes to an inactive FAT copy. Then you write the superblock
> to atomically transition to the next phase.

Yes, FAT is what inspired me to go develop the algorithm.  However, two 
words: 'lost clusters'.  Now that may just be an implemenation detail ;-)

--
Daniel
