Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291484AbSBZRLv>; Tue, 26 Feb 2002 12:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291624AbSBZRLl>; Tue, 26 Feb 2002 12:11:41 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:64505
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S291484AbSBZRL1>; Tue, 26 Feb 2002 12:11:27 -0500
Date: Tue, 26 Feb 2002 09:12:09 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020226171209.GK4393@matchmail.com>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <fa.n4lfl6v.h4chor@ifi.uio.no> <20020226160544.GD4393@matchmail.com> <3C7BB86A.7090305@zytor.com> <20020226164036.GG4393@matchmail.com> <a5gell$432$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5gell$432$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 08:55:17AM -0800, H. Peter Anvin wrote:
> Followup to:  <20020226164036.GG4393@matchmail.com>
> By author:    Mike Fedyk <mfedyk@matchmail.com>
> In newsgroup: linux.dev.kernel
> > 
> > Uhh, no.
> > 
> > You have a configurable size for the undelete dirs and you delete a file.
> > Now, that file gets moved to $mountpoint/.undelete.  The daemon gets
> > notified through a socket, and it can check to see if it needs to delete any
> > older deleted files to make sure .undelete doesn't get bigger than
> > configured.  
> > 
> > We're only scanning the dirs upon daemon startup (reminds me of
> > quota... ;), and all other daemon actions are triggered by unlink() writing
> > to a socket.  The worst thing that can happen is not seeing your free space
> > immediately, but a few seconds later.
> > 
> 
> Hence race condition.  

But an acceptable one (it's a small delay), unless the daemon dies. :(

>Also, the solution to hard-reserve space seems
> to fundamentally defeat the purpose (IMO).
>

Do you really thing we should be moving files from kernel space?  Ok, glibc
could move the files, that'd be ok.

So, (I don't know) how is the kernel going to support undeletion on all
filesystems (ext2/3, reiserfs, vfat, jfs, xfs, and any other writable fs...)
in the exact same way (as seen from userspace...)? 

Mike
