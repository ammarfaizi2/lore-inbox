Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289377AbSAVTrU>; Tue, 22 Jan 2002 14:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289378AbSAVTrL>; Tue, 22 Jan 2002 14:47:11 -0500
Received: from ligsg2.epfl.ch ([128.178.78.4]:13572 "HELO ligsg2.epfl.ch")
	by vger.kernel.org with SMTP id <S289377AbSAVTrB>;
	Tue, 22 Jan 2002 14:47:01 -0500
Message-Id: <m16T6sl-021O8uC@ligsg2.epfl.ch>
Content-Type: text/plain; charset=US-ASCII
From: Jan Ciger <jan.ciger@epfl.ch>
Reply-To: jan.ciger@epfl.ch
Organization: EPFL
To: Oliver.Neukum@lrz.uni-muenchen.de
Subject: Re: umounting
Date: Tue, 22 Jan 2002 20:46:11 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020122150703.B13509@pcmaftoul.esrf.fr> <m16T2IB-02103HC@ligsg2.epfl.ch> <16T6BH-1ZiPWiC@fwd07.sul.t-online.com>
In-Reply-To: <16T6BH-1ZiPWiC@fwd07.sul.t-online.com>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 January 2002 20:01, you wrote:
> > When a second user comes and unmounts a disk, then the data are flushed
> > (the old data) and he gets a fs corruption, because the data were not
> > from his disk.
>
> No. The sbp2 driver should report a disk change. If such a thing happens,
> there's a kernel bug. Pulling out a mounted disk may cause a corrupted
> filesystem on that disk but not on others.

Maybe there is a problem in the driver, that it does not report the media 
change, but anyway, you WILL get a corrupted filesystem, when you unmount 
such disk with another media in drive - it is exactly like that - the driver 
didn't report the change and the filesystem layer thinks, that it has still 
the same media in drive and happily flushes e.g. ext2 data to a VFAT disk ... 
Then you get the corruption of the second disk. 

But I am not familiar with the sbp2 driver, but this is a quite standard 
behavior for removable media. 

Jan
