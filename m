Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbUDEWxZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 18:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbUDEWxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 18:53:25 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:18528 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S262984AbUDEWw6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 18:52:58 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200404052253.i35Mr6k6011170@green.mif.pg.gda.pl>
Subject: PTS alocation problem with 2.6.4/2.6.5
To: linux-kernel@vger.kernel.org (kernel list)
Date: Tue, 6 Apr 2004 00:53:06 +0200 (CEST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I noticed serious problem with PTS alocation on kernels 2.6.4 and 2.6.5:
It seems that once alocated /dev/pts entries are never reused, leading to
pty alocation errors. The testing system is fully compiled with kernel 2.2.x
headers (including glibc), but informations from my coleagues using systems
compiled on 2.4/2.6 headers seems to behave similarily.
The testcase and used kernel configuration are shown below.
Kernel 2.6.3 does not have this problem.
Is it bug or feature (and I am doing sth wrong) ?

NOTE: I realize that my glibc does not support minors > 255, so no more pts-es
      is available, but problem is leakage of _free_ pts-es.

[ankry@green SPECS]$ for a in $(seq 4);do ssh -t remote tty;done
/dev/pts/253
Connection to remote closed.
/dev/pts/254
Connection to remote closed.
/dev/pts/255
Connection to remote closed.
not a tty
         Connection to remote closed.
[ankry@green SPECS]$ ssh remote cat /proc/sys/kernel/pty/{max,nr}
2048
1
$ ssh olimp ls /dev/pts
1

.config tested (selected entries)

CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=2048

or

CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set

(full .config available on request)

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
