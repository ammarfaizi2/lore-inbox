Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268693AbTCCSRm>; Mon, 3 Mar 2003 13:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268753AbTCCSRm>; Mon, 3 Mar 2003 13:17:42 -0500
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:52122 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S268693AbTCCSRf> convert rfc822-to-8bit; Mon, 3 Mar 2003 13:17:35 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390: update for 2.5.63.
Date: Mon, 3 Mar 2003 19:26:35 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200303031919.08287.schwidefsky@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
some s390 stuff for 2.5.63.

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

blue skies,
  Martin.

