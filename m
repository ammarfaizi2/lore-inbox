Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbSK0N0m>; Wed, 27 Nov 2002 08:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbSK0N0m>; Wed, 27 Nov 2002 08:26:42 -0500
Received: from thunk.org ([140.239.227.29]:41683 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262500AbSK0N0l>;
	Wed, 27 Nov 2002 08:26:41 -0500
Date: Wed, 27 Nov 2002 08:33:19 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: htree+NFS (NFS client bug?)
Message-ID: <20021127133318.GA8117@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Ext2 devel <ext2-devel@lists.sourceforge.net>,
	NFS maillist <nfs@lists.sourceforge.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1038354285.1302.144.camel@sherkaner.pao.digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2002 at 03:44:46PM -0800, Jeremy Fitzhardinge wrote:
> I'm having problems with exporting htree ext3 filesystems over NFS. 
> Quite often, if a program on the client side is reading a directory it
> will simply stop and consume a vast amount of memory.  It seems that the
> readdir never terminates, and endlessly returns the same dir entries
> again and again.
> 
> This seems to be happening entirely on the NFS client side; after the
> initial readdir and a couple of getattrs, there's no further network
> traffic.
> 
> It looks to me like some sort of problem managing the NFS readdir
> cookies, but it isn't clear to me whether this is the NFS server/ext3
> generating bad cookies, or the NFS client handling them wrongly.

Well, even if the NFS server is generating bad cookies (and that may
be possible), the NFS client should be more robust and not spin in a
loop forever.

Can you send me a directory list (from the server) of the directory in
question?  Also, can you send me the output of dumpe2fs -h on the
filesystem.  I'll need the later to get the seed for the htree hash,
so I can try replicating this on my end.

Also, have you tried running e2fsck on filesystem on the server?  It
would be very interesting to confirm whether or not the filesystem is
consistent.

							- Ted
