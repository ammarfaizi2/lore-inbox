Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTDVT4v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263473AbTDVT4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:56:51 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:13720 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263459AbTDVT4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:56:49 -0400
Date: Wed, 23 Apr 2003 00:08:15 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Cc: r.e.wolff@bitwizard.nl
Subject: Fix for memleak in Perle Specialix driver
Message-ID: <20030422200815.GA7671@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There is a memleak on error exit path in Perle Specialix driver.
   The problem is present in both 2.4 and 2.5, the patch is trivial and
   applies to both trees.
   Please consider applying.

Bye,
    Oleg

===== drivers/char/rio/rioboot.c 1.3 vs edited =====
--- 1.3/drivers/char/rio/rioboot.c	Tue Feb  5 10:42:04 2002
+++ edited/drivers/char/rio/rioboot.c	Tue Apr 22 23:50:56 2003
@@ -328,6 +328,7 @@
 
 			if ( copyin((int)rbp->DataP,DownCode,rbp->Count)==COPYFAIL ) {
 				rio_dprintk (RIO_DEBUG_BOOT, "Bad copyin of host data\n");
+				sysfree( DownCode, rbp->Count );
 				p->RIOError.Error = COPYIN_FAILED;
 				func_exit ();
 				return EFAULT;
