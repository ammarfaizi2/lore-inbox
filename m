Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318174AbSG2WHG>; Mon, 29 Jul 2002 18:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318180AbSG2WHF>; Mon, 29 Jul 2002 18:07:05 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2747 "EHLO e1.ny.us.ibm.com.")
	by vger.kernel.org with ESMTP id <S318174AbSG2WGQ>;
	Mon, 29 Jul 2002 18:06:16 -0400
Subject: Re: [PATCH] vfs_read/vfs_write small bug fix (2.5.29)
From: Paul Larson <plars@austin.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0207291418280.1470-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0207291418280.1470-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 Jul 2002 17:06:18 -0500
Message-Id: <1027980379.11135.223.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 16:22, Linus Torvalds wrote:
> Does this work for you? If not, that implies that glibc may be missing a
> 
> 	if (pos < 0) {
> 		errno = EINVAL;
> 		return -1;
> 	}
> 
> in its implementation of the pread/pwrite shim layer.
> 
> (Or maybe glibc doesn't know that the kernel pread/pwrite system calls 
> were always 64-bit clean, and it just happened to work).
> 
> 		Linus
No, with just this patch it still fails on pread02 and pwrite02.

# ./pread02
pread02     1  PASS  :  pread() fails, file descriptor is a PIPE or
FIFO, errno:29
pread02     2  FAIL  :  pread() returned 0, expected -1, errno:22

# ./pwrite02
pwrite02    1  PASS  :  file descriptor is a PIPE or FIFO, errno:29
caught SIGXFSZ
pwrite02    2  FAIL  :  specified offset is -ve or invalid, unexpected
errno:27, expected:22
pwrite02    3  PASS  :  file descriptor is bad, errno:9

Paul Larson
Linux Test Project
http://ltp.sourceforge.net

