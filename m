Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263465AbTECXbq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 19:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263481AbTECXbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 19:31:45 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:48648 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S263465AbTECXbo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 19:31:44 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10520054422453@movementarian.org>
Subject: [PATCH 1/8] OProfile update
In-Reply-To: 
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb
Date: Sun, 4 May 2003 00:44:02 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Spam-Score: -4.8 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19C6fm-0009th-Ez*1IhsQELY7cw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The next 8 patches change the following files :

 arch/alpha/oprofile/Makefile      |    3 +
 arch/alpha/oprofile/common.c      |    2 -
 arch/i386/oprofile/Makefile       |    5 +-
 arch/i386/oprofile/init.c         |   11 ++----
 arch/i386/oprofile/nmi_int.c      |   14 +++----
 arch/i386/oprofile/timer_int.c    |   58
--------------------------------
 arch/parisc/oprofile/Makefile     |    5 +-
 arch/parisc/oprofile/init.c       |    3 -
 arch/parisc/oprofile/timer_int.c  |   58
--------------------------------
 arch/ppc64/oprofile/Makefile      |    5 +-
 arch/ppc64/oprofile/init.c        |    3 -
 arch/ppc64/oprofile/timer_int.c   |   59
---------------------------------
 arch/sparc64/oprofile/Makefile    |    5 +-
 arch/sparc64/oprofile/init.c      |    3 -
 arch/sparc64/oprofile/timer_int.c |   59
---------------------------------
 arch/x86_64/oprofile/Makefile     |    9 ++---
 drivers/oprofile/buffer_sync.c    |   67
+++++++++++++++++++++++++-------------
 drivers/oprofile/event_buffer.c   |    6 ++-
 drivers/oprofile/oprof.c          |   23 +++++++++----
 drivers/oprofile/oprofile_stats.c |    6 +--
 drivers/oprofile/oprofile_stats.h |    2 -
 drivers/oprofile/timer_int.c      |   56
+++++++++++++++++++++++++++++++
 22 files changed, 159 insertions(+), 303 deletions(-)


Convention is that error returns are negative.

diff -Naur -X dontdiff linux-cvs/arch/alpha/oprofile/common.c linux-me/arch/alpha/oprofile/common.c
--- linux-cvs/arch/alpha/oprofile/common.c	2003-04-05 18:44:20.000000000 +0100
+++ linux-me/arch/alpha/oprofile/common.c	2003-04-29 01:18:48.000000000 +0100
@@ -175,7 +175,7 @@
 	}
 
 	if (!lmodel)
-		return ENODEV;
+		return -ENODEV;
 	model = lmodel;
 
 	oprof_axp_ops.cpu_type = lmodel->cpu_type;

