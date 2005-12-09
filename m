Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbVLITu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVLITu5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 14:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbVLITu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 14:50:56 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:17904 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932404AbVLITu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 14:50:56 -0500
Date: Fri, 9 Dec 2005 19:50:52 +0000 (GMT)
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Lee Revell <rlrevell@joe-job.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
In-Reply-To: <1134154208.14363.8.camel@mindpipe>
Message-ID: <Pine.LNX.4.63.0512091930440.19998@deepthought.mydomain>
References: <1134154208.14363.8.camel@mindpipe>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-1381318133-1134157722=:19998"
Content-ID: <Pine.LNX.4.63.0512091949060.19998@deepthought.mydomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-1381318133-1134157722=:19998
Content-Type: TEXT/PLAIN; CHARSET=X-UNKNOWN; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.63.0512091949061.19998@deepthought.mydomain>

On Fri, 9 Dec 2005, Lee Revell wrote:

> I'm trying to build an x66-64 kernel on a 32 bit system (Ubuntu 5.10).
> I added -m64 to the CFLAGS as per the gcc docs.  But the build fails
> with:
>
> $ make ARCH=x86_64
>  [...]
>  CC      init/initramfs.o
>  CC      init/calibrate.o
>  LD      init/built-in.o
>  CHK     usr/initramfs_list
>  CC      arch/x86_64/kernel/process.o
>  CC      arch/x86_64/kernel/signal.o
>  AS      arch/x86_64/kernel/entry.o
> arch/x86_64/kernel/entry.S: Assembler messages:
> arch/x86_64/kernel/entry.S:204: Error: cannot represent relocation type BFD_RELOC_X86_64_32S

  Unless ubuntu provides a biarch toolchain (and the fact gcc accepts 
'-m64' means nothing - use 'file' on init/built-in.o), you have to build 
a cross toolchain, (just binutils and gcc), put that on your path, and 
use

make ARCH=x86_64 CROSS_COMPILE=x86_64-pc-linux-gnu-

  so that the build will use x86_64-pc-linux-gnu-as and friends.  You 
should not need to mess with the CFLAGS.

Ken
-- 
  das eine Mal als Tragödie, das andere Mal als Farce
---1463809536-1381318133-1134157722=:19998--
