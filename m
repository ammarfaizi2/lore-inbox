Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261553AbTCGMhe>; Fri, 7 Mar 2003 07:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbTCGMhe>; Fri, 7 Mar 2003 07:37:34 -0500
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:38285 "EHLO
	d06lmsgate-4.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S261553AbTCGMhd> convert rfc822-to-8bit; Fri, 7 Mar 2003 07:37:33 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390: update for 2.5.64.
Date: Fri, 7 Mar 2003 13:34:18 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200303071334.18873.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
another 2000 lines of patches for s390. They are against 2.5.64 + bk.

Short descriptions:
1) Basic bug fixes for s390.
2) Add support for system call numbers > 255. The svc instruction
  provides 8 bits for the svc number. The additional system calls for
  the posix timers pushed s390 over the edge of 256 system calls. To
  support more than 256 system calls a second interface is introduced.
  svc 0 is unused so far and will be used like the int 0x80 interface
  on i386. The register %r1 contains the real system call number.
  The new interface requires on additional instructions, e.g. getpid
  with the new interface is "lhi %r1,20; svc 0" compared to the old
  interface "svc 20". The old interface will be used for system call
  number < 256 and the new one for calls >= 256.
3) dasd driver update. A race condition in dasd_end_request and a
  compile fix for devfs.
4) shutdown/restart fixes for the lcs driver.
5) Fix some kmallocs with GFP_DMA but without GFP_KERNEL.
6) Make uni-processor kernels compile & work again.
7) Add code to wait for the root device. We had some trouble to
  ipl on an LPAR where dasd devices may take time to respond.

blue skies,
  Martin.

