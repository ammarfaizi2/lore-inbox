Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280803AbRKOKES>; Thu, 15 Nov 2001 05:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280804AbRKOKEJ>; Thu, 15 Nov 2001 05:04:09 -0500
Received: from chamber.cco.caltech.edu ([131.215.48.55]:13236 "EHLO
	chamber.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S280803AbRKOKD6>; Thu, 15 Nov 2001 05:03:58 -0500
From: "Alex Adriaanse" <alex_a@caltech.edu>
To: <aj@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: LFS stopped working
Date: Thu, 15 Nov 2001 02:03:52 -0800
Message-ID: <JIEIIHMANOCFHDAAHBHOMEONCMAA.alex_a@caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <hoofm45q82.fsf@gee.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But ulimit shows that the file size is unlimited... would this be a bug?  If
that's the case, then how/why would it work before?

Thanks,

Alex

-----Original Message-----
From: aj@suse.de [mailto:aj@suse.de]
Sent: Thursday, November 15, 2001 1:38 AM
To: Alex Adriaanse
Cc: linux-kernel@vger.kernel.org
Subject: Re: LFS stopped working


"Alex Adriaanse" <alex_a@caltech.edu> writes:

> Hey,
>
> I've been running 2.4.14 for a few days now.  I needed LFS support, so I
> recompiled glibc 2.1.3 with the new 2.4 headers, and after that I could
> create large files (e.g. using dd if=/dev/zero of=test bs=1M count=0
> seek=3000) just fine.
>
> However, as of yesterday, I couldn't create files bigger than 2GB anymore.
> I did not change kernels, nor did I mess with libc or anything else (I did
> some Debian package upgrades/installations/recompiles, but I don't think
> they should affect this) - I'm not quite sure what happened.  Now commands
> such as the dd command I mentioned above will die with the message "File
> size limit exceeded", leaving a 2GB file behind.  Rebooting didn't solve
> anything.  My ulimits seem to be fine (file size = unlimited).
>
> The last few lines of the strace on the dd command above shows the
> following:
> open("/dev/zero", O_RDONLY|0x8000)      = 0
> close(1)                                = 0
> open("test", O_RDWR|O_CREAT|0x8000, 0666) = 1
> ftruncate64(0x1, 0xbb800000, 0, 0, 0x1) = 0
> --- SIGXFSZ (File size limit exceeded) ---
> +++ killed by SIGXFSZ +++

ulimit is hit.  I strongly advise to upgrade to glibc 2.2 when using
kernel 2.4,

Andreas
--
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj

