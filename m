Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273027AbRIIUTP>; Sun, 9 Sep 2001 16:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273028AbRIIUTD>; Sun, 9 Sep 2001 16:19:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34059 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273027AbRIIUSv>; Sun, 9 Sep 2001 16:18:51 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: linux-2.4.10-pre5
Date: 9 Sep 2001 13:18:57 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9ngirh$jsu$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33L.0109090909001.21049-100000@duckman.distro.conectiva> <Pine.LNX.4.33.0109091105380.14479-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0109091105380.14479-100000@penguin.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> I agree that coherency wrt fsck is something that theoretically would be a
> GoodThing(tm). And this is, in fact, why I believe that filesystem
> management _must_ have a good interface to the low-level filesystem.
> Because you cannot do it any other way.
> 
> This is not a fsck-only issue. I am a total non-believer in the "dump"
> program, for example. I always found it to be a totally ridiculous and
> idiotic way to make backups. It would be much better to have good
> (filesystem-independent) interfaces to do what "dump" wants to do (ie have
> ways of explicitly bypassing the accessed bits and get the full inode
> information etc).
> 
> Nobody does a "read()" on directories any more to parse the directory
> structure. Similarly, nobody should have done a "dump" on the raw device
> any more for the last 20 years or so. But some backwards places still do.
> 

The main reason people seems to still justify use dump/restore is --
believe it or not -- the inability to set atime.  One would think this
would be a trivial extension to the VFS, even if protected by a
capability (CAP_BACKUP?).

The ideal way to run backups I have found is on filesystems which
support atomic snapshots -- that way, your backup set becomes not only
safe (since it goes through the kernel etc. etc.) but totally
coherent, since it is guaranteed to be unchanging.  This is a major
win for filesystems which can do atomic snapshots, and I'd highly
encourage filesystem developers to consider this feature.

	-hpa



-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
