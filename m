Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266970AbTAULXk>; Tue, 21 Jan 2003 06:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266976AbTAULXk>; Tue, 21 Jan 2003 06:23:40 -0500
Received: from gold.muskoka.com ([216.123.107.5]:58632 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S266970AbTAULXj>;
	Tue, 21 Jan 2003 06:23:39 -0500
Message-ID: <3E2D2BEA.2AC873DE@yahoo.com>
Date: Tue, 21 Jan 2003 06:15:54 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.2.23 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-pre3-ac4 [PATCH]
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Your compiler must really like you, seeing as it would barf on any 
significant I/O here.  Somewhere along the line, somebody removed
the INIT_LIST_HEAD for current->local_pages from fork.c and didn't
put it back somewhere else (like INIT_TASK or whatever was in mind.)

I just put it back where it was for now, not knowing what the 
original intention was.  As long as it is put somewhere...  :-)

Paul.

--- kernel/fork.c~	Mon Jan  6 14:26:50 2003
+++ kernel/fork.c	Tue Jan 21 05:30:17 2003
@@ -688,6 +688,8 @@
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = jiffies;
 
+	INIT_LIST_HEAD(&p->local_pages);
+
 	retval = -ENOMEM;
 	/* copy all the process information */
 	if (copy_files(clone_flags, p))




