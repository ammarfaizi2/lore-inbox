Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316106AbSEZOQE>; Sun, 26 May 2002 10:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316111AbSEZOQD>; Sun, 26 May 2002 10:16:03 -0400
Received: from rkom.r-kom.de ([212.77.162.22]:36021 "EHLO urfass.r-kom.de")
	by vger.kernel.org with ESMTP id <S316106AbSEZOQB>;
	Sun, 26 May 2002 10:16:01 -0400
Date: Sun, 26 May 2002 16:16:01 +0200
From: "Stefan M. Brandl" <smb@smbnet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ioctl() still problem w/2.5.18
Message-ID: <20020526161601.B14961@urfass.r-kom.de>
In-Reply-To: <20020526160519.A23832@urfass.r-kom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-NCC-RegID: de.r-kom
X-URL: http://www.smbnet.de/
X-Organization: heavy overdose administration
X-Location: Regensburg, Bavaria, Germany
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         In 2.5.16, have any restrictions been placed on ioctl()? With 2.5.16,
> a non-root user is unable to use /dev/cdrom with an ide cd, to play audio cds.
> An strace of workbone shows this:
> 
> open("/dev/cdrom", O_RDONLY)            = 3
> ioctl(3, CDROMSUBCHNL, 0xbfffe814)      = -1 EACCES (Permission denied)  
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> rt_sigaction(SIGINT, {SIG_IGN}, {SIG_DFL}, 8) = 0
> ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0
> ioctl(0, SNDCTL_TMR_START, {B38400 opost isig -icanon -echo ...}) = 0
> ioctl(0, TCGETS, {B38400 opost isig -icanon -echo ...}) = 0
> write(1, "\n", 1
> )                       = 1
> ioctl(0, SNDCTL_TMR_START, {B38400 opost isig icanon echo ...}) = 0
> ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0
> rt_sigaction(SIGINT, {SIG_DFL}, {SIG_IGN}, 8) = 0
> munmap(0x40017000, 4096)                = 0
> _exit(0)                                = ?
> 
>         Workbone is supposed to access /dev/cdrom, and then wait for user 
> input from the number pad, to play the cd. the following strace from workbone 
> in 2.5.7 shows this working properly:
> 
> write(1, "\33[10m\n", 6
> ) = 55                                               
> open("/dev/cdrom", O_RDONLY)            = 3  "..., 55
> ioctl(3, CDROMSUBCHNL, 0xbfffe654)      = 0
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ioctl(3, CDROMREADTOCHDR, 0xbfffe626)   = 0
> ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
> ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
> ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
> ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
> ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
> ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
> ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
> ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
> ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
> ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
> ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
> rt_sigaction(SIGINT, {SIG_IGN}, {SIG_DFL}, 8) = 0
> ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0
> 
>         This worked as root, and with  a kernel <= 2.5.13. I didn't try this 
> with 2.5.14 or 2.5.15.
> 

Same problem here.
While kernels <= 2.5.15 don't show this error, 2.5.16, 17 and 18 do.
The bug? must have been introduced with 2.5.16.


Stefan
