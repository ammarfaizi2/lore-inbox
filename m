Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287880AbSA0JPi>; Sun, 27 Jan 2002 04:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287881AbSA0JP3>; Sun, 27 Jan 2002 04:15:29 -0500
Received: from natwar.webmailer.de ([192.67.198.70]:1957 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S287880AbSA0JPS>; Sun, 27 Jan 2002 04:15:18 -0500
Date: Sun, 27 Jan 2002 10:11:31 +0100
From: Kristian <kristian.peters@korseby.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: kevin@labsysgrp.com, linux-kernel@vger.kernel.org, gcoady@bendigo.net.au
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
Message-Id: <20020127101131.0f71e978.kristian.peters@korseby.net>
In-Reply-To: <3C53A116.81432588@zip.com.au>
In-Reply-To: <3C5119E0.6E5C45B6@zip.com.au>
	<000701c1a5d5$812ef580$6caaa8c0@kevin>
	<3C53711B.F8D89811@zip.com.au>
	<3C53A116.81432588@zip.com.au>
X-Mailer: Sylpheed version 0.7.0claws5 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> wrote:
> There's an updated patch at
> 
> 	http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre7/ide-akpm.patch
> 
> It now supports multi-frame transfers and should fix the problem
> which you observed.

Your first patch behaves much better as the second. It seems that my drives are running with PIO only again. I see no problems with your first patch.


cdparanoia with ide-akpm-1:

/dev/scd0: (CPU ~40%)
	real    1m10.194s
	user    0m6.560s
	sys     0m2.880s
/dev/scd1: (CPU ~40%)
	real    2m8.283s
	user    0m7.230s
	sys     0m3.890s


cdparanoia with ide-akpm-2:

/dev/scd0: (CPU ~80%)
	real    1m37.472s
	user    0m7.340s
	sys     0m3.290s
/dev/scd1: (CPU ~50%)
	real    2m40.879s
	user    0m7.650s
	sys     0m3.620s


dd if=/dev/scd0 of=test.iso:

And dd consumes about 5% CPU with your first patch and almost 90% with your second patch as I would disable dma on it (and the system gets really slow responding).


My specs:

hdc: LTN526S, ATAPI CD/DVD-ROM drive
hdd: Hewlett-Packard CD-Writer Plus 9100b, ATAPI CD/DVD-ROM drive

I'm using ide-scsi:
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITEON    Model: CD-ROM LTN526S    Rev: YS0A
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: HP        Model: CD-Writer+ 9100b  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02


I'm using 2.4.18-pre3-ac2. Maybe there're some collisions with Andre's IDE patches ?


*Kristian

  :... [snd.science] ...:
 ::
 :: http://www.korseby.net
 :: http://gsmp.sf.net
  :.........................:: ~/$ kristian@korseby.net :
