Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265028AbRF0UU5>; Wed, 27 Jun 2001 16:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265152AbRF0UUr>; Wed, 27 Jun 2001 16:20:47 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:7396 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265028AbRF0UU0>;
	Wed, 27 Jun 2001 16:20:26 -0400
Date: Wed, 27 Jun 2001 22:19:37 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200106272019.WAA29237@harpo.it.uu.se>
To: FrankZhu@viatech.com.cn
Subject: Re: PROBLEM:Illegal instruction when mount nfs file systems using cyr ixIII
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2001 17:42:01 +0800, Frank Zhu wrote:

>I use a PIII machine as the server and cyrixIII machine as the client.The
>kernel is 2.4.5.The distribute is red hat 7.1
>when i mount the nfs file system at the client it failed.The core file is
>created.using the gdb it report  :
>Program terminated with signal 4(SIGILL),Illegal instruction
>#0  0x40003e28 in ??()
>
>If i change the cpu (CyrixIII) to PIII all is ok.

You don't say exactly where the failure occurs, but I suspect
that you're feeding i686-class machine code to your VIA Cyrix III.

The problem is that VIA Cyrix III announces itself (via CPUID)
as a "family 6" processor, i.e. i686 compatible. This is not
completely accurate, since it doesn't implement the conditional
move instruction. [Yeah, I know there's a CPUID feature flag for
CMOV. I also know gcc doesn't check it, and I suspect glibc
doesn't either.]

To make the machine work you'll have to ensure that the kernel,
user-space libraries and programs, and NFS-imported programs
all are compiled for a lesser CPU than i686.

/Mikael
