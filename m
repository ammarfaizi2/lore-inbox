Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTFJKJL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 06:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTFJKHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 06:07:39 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:15323 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261798AbTFJKH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 06:07:28 -0400
Date: Tue, 10 Jun 2003 15:54:05 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Misc 2.5 Fixes: mem-leak-rio
Message-ID: <20030610102405.GN2194@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030610100905.GD2194@in.ibm.com> <20030610100950.GE2194@in.ibm.com> <20030610101035.GF2194@in.ibm.com> <20030610101121.GG2194@in.ibm.com> <20030610101318.GH2194@in.ibm.com> <20030610101503.GI2194@in.ibm.com> <20030610101801.GJ2194@in.ibm.com> <20030610102024.GK2194@in.ibm.com> <20030610102255.GL2194@in.ibm.com> <20030610102336.GM2194@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610102336.GM2194@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fix memory leak - free on copyin failure.


 drivers/char/rio/rioboot.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/char/rio/rioboot.c~mem-leak-rio drivers/char/rio/rioboot.c
--- linux-2.5.70-ds/drivers/char/rio/rioboot.c~mem-leak-rio	2003-06-08 21:21:50.000000000 +0530
+++ linux-2.5.70-ds-dipankar/drivers/char/rio/rioboot.c	2003-06-08 21:21:50.000000000 +0530
@@ -326,6 +326,7 @@ register struct DownLoad *rbp;
 
 			if ( copyin((int)rbp->DataP,DownCode,rbp->Count)==COPYFAIL ) {
 				rio_dprintk (RIO_DEBUG_BOOT, "Bad copyin of host data\n");
+				sysfree( DownCode, rbp->Count );
 				p->RIOError.Error = COPYIN_FAILED;
 				func_exit ();
 				return -EFAULT;

_
