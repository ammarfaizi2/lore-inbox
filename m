Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281748AbRLQRa0>; Mon, 17 Dec 2001 12:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281739AbRLQRaR>; Mon, 17 Dec 2001 12:30:17 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:3597 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281738AbRLQRaI>; Mon, 17 Dec 2001 12:30:08 -0500
Message-ID: <3C1E2B61.3F9A685E@zip.com.au>
Date: Mon, 17 Dec 2001 09:29:05 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: BURJAN Gabor <burjang@elte.hu>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17-rc1 kernel panic at boot
In-Reply-To: <20011217120831.GA31447@csoma.elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BURJAN Gabor wrote:
> 
> Hello,
> 
> I have a problem with booting 2.4.17-rc1 on a RS/6000 (43P-140), when
> Vortex support is compiled into the kernel.
> 
> ...
> 
> >>NIP; c0264050 <vortex_probe1+394/cbc>   <=====
> Trace; c0263f28 <vortex_probe1+26c/cbc>

That's a big function, unfortunately.   Could you please
do the following?

In the top-level makefile, add the line:

CFLAGS += -g

right at the end.    Then rebuild the kernel, recreate the
crash, then run:

gdb vmlinux
(gdb) l *0xc0264050

(Assuming that this is still the NIP address after you've rebuilt).

This should point us at the source code where the problem is
occurring.

Thanks.
