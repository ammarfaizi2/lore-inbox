Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278042AbRJKC5u>; Wed, 10 Oct 2001 22:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277991AbRJKC5l>; Wed, 10 Oct 2001 22:57:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28939 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277976AbRJKC52>; Wed, 10 Oct 2001 22:57:28 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Dump corrupts ext2?
Date: 10 Oct 2001 19:57:50 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9q31re$7hb$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110101558210.7049-100000@train.sweet-haven.com> <m3elob3xao.fsf@belphigor.mcnaught.org> <20011010173449.Q10443@turbolinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011010173449.Q10443@turbolinux.com>
By author:    Andreas Dilger <adilger@turbolabs.com>
In newsgroup: linux.dev.kernel
> > 
> > I'm pretty sure this is because dump reads the block device directly
> > (which is cached in the buffer cache), while the file data for cached
> > files lives in the page cache, and the two caches are no longer
> > coherent (as of 2.4).
> 
> In Linus kernels 2.4.11+ the block devices and filesystems all use the
> page cache, so no more coherency issues.
> 

How do you find a random block in the page cache?  Last my
understanding was that the page cache is organized by inode/offset,
which wouldn't lend itself to looking up a random hardware block.

(Not to mention the fact that the filesystem is perfectly allowed not
to present anything like a coherent state to the disk while mounted,
which means that even if you did a snapshot in time you're not
guaranteed to have anything functional.  I understand this can be done
by sending a "quiet point" command to the filesystems, followed by an
LVM snapshot, but I doubt may people do that!

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
