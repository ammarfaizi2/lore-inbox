Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262733AbREVTH2>; Tue, 22 May 2001 15:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262732AbREVTHS>; Tue, 22 May 2001 15:07:18 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:13575 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262728AbREVTHH>; Tue, 22 May 2001 15:07:07 -0400
Date: Tue, 22 May 2001 12:06:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Alexander Viro <viro@math.psu.edu>, Edgar Toernig <froese@gmx.de>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <200105221841.f4MIf1NC011363@webber.adilger.int>
Message-ID: <Pine.LNX.4.21.0105221204590.3906-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 May 2001, Andreas Dilger wrote:
> 
> Actually, the LVM snapshot interface has (optional) hooks into the filesystem
> to ensure that it is consistent at the time the snapshot is created.

Note that this is still fundamentally a broken interface: the filesystem
may not _have_ a block device underneath it, yet you might very well like
to do defragmentation and backup none-the-less.

Also, lvm snapshots are fundamentally limited to read-only data, which
means that the LVM interfaces cannot be used for defragmentation and lazy
fsck etc anyway. You _have_ to do those at a filesystem level.

disk snapshots are useful, but they are not the answer.

		Linus

