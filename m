Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270865AbTHKCLl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 22:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270862AbTHKCLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 22:11:41 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:44454 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S270856AbTHKCLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 22:11:03 -0400
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: vojtech@suse.cz
Date: Mon, 11 Aug 2003 12:10:45 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16182.64293.480520.346101@wombat.disy.cse.unsw.edu.au>
CC: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Kill warning in drivers/input/misc/uinput.c on IA64 (2.6.0)
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Vojtech,
   Attached patch kills a warning when compiling on a 64-bit
architecture (ssize_t is long, not int)

===== drivers/input/misc/uinput.c 1.11 vs edited =====
--- 1.11/drivers/input/misc/uinput.c	Sat Jun 21 21:42:40 2003
+++ edited/drivers/input/misc/uinput.c	Thu Aug  7 11:56:12 2003
@@ -226,7 +226,7 @@
 	return retval;
 }
 
-static int uinput_write(struct file *file, const char *buffer, size_t count, loff_t *ppos)
+static ssize_t uinput_write(struct file *file, const char *buffer, size_t count, loff_t *ppos)
 {
 	struct uinput_device	*udev = file->private_data;
 	

--
Dr Peter Chubb     http://www.gelato.unsw.edu.au  peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.

