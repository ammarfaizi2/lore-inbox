Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289327AbSAVOxQ>; Tue, 22 Jan 2002 09:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289330AbSAVOxI>; Tue, 22 Jan 2002 09:53:08 -0500
Received: from ligsg2.epfl.ch ([128.178.78.4]:42357 "HELO ligsg2.epfl.ch")
	by vger.kernel.org with SMTP id <S289327AbSAVOw5>;
	Tue, 22 Jan 2002 09:52:57 -0500
Message-Id: <m16T2IB-02103HC@ligsg2.epfl.ch>
Content-Type: text/plain; charset=US-ASCII
From: Jan Ciger <jan.ciger@epfl.ch>
Reply-To: jan.ciger@epfl.ch
Organization: EPFL
To: Samuel Maftoul <maftoul@esrf.fr>
Subject: Re: umounting
Date: Tue, 22 Jan 2002 15:52:07 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020122150703.B13509@pcmaftoul.esrf.fr>
In-Reply-To: <20020122150703.B13509@pcmaftoul.esrf.fr>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 January 2002 15:07, Samuel Maftoul wrote:
> If user 1 had an ext2 disk, when user 2 umounts the filesystem with his
> disk plugged his filesystem got broken ( tested with ext2 and vfat).
> If user 1 had a vfat disk, then user 2 can cleanly umount the disk
> without breaking any filesystem.

In general, when you unmount a filesystem, the system caches and data 
relevant for that filesystem are flushed to the disk. So if the first one 
leaves withou unmounting his disk, he can even have a corrupted fs himself, 
because some data didn't make it to the drive yet, there are just in caches. 

When a second user comes and unmounts a disk, then the data are flushed (the 
old data) and he gets a fs corruption, because the data were not from his 
disk. 

It is just matter of luck and it depends a lot on the buffering approach 
chosen by the fs developers - ext2 tends to cache a lot of things to improve 
performance and the disk flushes are not that frequent. If you manage to plug 
your drive in a wrong moment, then you end up with a mess. You can easily 
test this problem with floppies.

So, the solution is - teach your users to unmount disks before leaving, or 
mount them in synchronous mode - but I am not sure, whether VFAT supports 
that and it is a performance hog too. 

Jan
