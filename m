Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274591AbRITVRS>; Thu, 20 Sep 2001 17:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274656AbRITVRI>; Thu, 20 Sep 2001 17:17:08 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:34045 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274654AbRITVQ4>; Thu, 20 Sep 2001 17:16:56 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Thu, 20 Sep 2001 15:17:08 -0600
To: Peter Bornemann <eduard.epi@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: noexec-flag does not work in Linux 2.4.10-pre10
Message-ID: <20010920151708.F14526@turbolinux.com>
Mail-Followup-To: Peter Bornemann <eduard.epi@t-online.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109201957530.2448-100000@eduard.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109201957530.2448-100000@eduard.t-online.de>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 20, 2001  20:05 +0200, Peter Bornemann wrote:
> It seems that the noexec in fstab no longer works. Is this
> intentional?
> 
> In fstab I have the following line:
> 
> /dev/hda1       /dosc   vfat    codepage=850,umask=000,noexec 0 0
> 
> A ls -l in /dosc shows:
> 
> -rwxrwxrwx    1 root     root     267657216 Jun 28 22:34 win386.swp
> 
> The same case with iso9660:
> 
> -r-xr-xr-x    1 root     root            0 Jan 24  2000 s3cd1.dat
> 
> However umask=111 is still working. I don't know exactly when this
> happened, but it was hot there in earlier 2.4 kernels.

Are you sure this is actually a problem?  Can you really exec these
files, or is it just a matter of the flag?  Some changes were made
to mount flags by Al Viro.  If you really want the flags gone, you
should use a different umask (e.g. umask=111).  The noexec flag
means (for filesystems that actually have permissions) that _even if_
the "x" bit is set, it cannot be executed.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

