Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262099AbREXPSR>; Thu, 24 May 2001 11:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262094AbREXPSH>; Thu, 24 May 2001 11:18:07 -0400
Received: from www.inreko.ee ([195.222.18.2]:952 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S262088AbREXPR6>;
	Thu, 24 May 2001 11:17:58 -0400
Date: Thu, 24 May 2001 17:20:27 +0200
From: Marko Kreen <marko@l-t.ee>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Edgar Toernig <froese@gmx.de>, Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: CHR/BLK needed?   was: Re: Why side-effects on open...
Message-ID: <20010524172026.A6731@l-t.ee>
In-Reply-To: <20010524094717.A23722@l-t.ee> <Pine.LNX.4.30.0105240937490.16271-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0105240937490.16271-100000@waste.org>; from oxymoron@waste.org on Thu, May 24, 2001 at 09:39:35AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001 at 09:39:35AM -0500, Oliver Xymoron wrote:
> On Thu, 24 May 2001, Marko Kreen wrote:
> > IMHO the CHR/BLK is not needed.  Think of /proc.  In the future,
> > the backup tools will be told to ignore /dev, that's all.
> 
> The /dev dir should not be special. At least not to the kernel. I have
> device files in places other than /dev, and you probably do too (hint:
> anonymous FTP).

So?  Do you allow downloading from/to /dev in your chrooted ftp?

Ofcourse this is not hard-wired or something.  You tell devfsd
to put dev's somewhere.  Next moment you edit backup config
and tell it to igrore that /somewhere.  As I said: like /proc
currently is.  Or should current /proc converted to CHR devices?

My idea is (well, 'devfs2' - I have the core almost working now)
that the 'devices' will be VFS only objects - they live
only in inode cache (on ramfs).  So the CHR/BLK flags are only
backwards compatibility for supporting major:minors for /dev on
eg ext2.  Currently I think exposing device inodes as ordinary
files (or dirs if needed), so they look like any file to
programs.  Will this break too much?  Another variant would be
to expose them as S_IFDEV - which probably breaks even more.


-- 
marko

