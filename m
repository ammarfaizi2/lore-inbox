Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267580AbUHPM2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267580AbUHPM2p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 08:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267599AbUHPM2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 08:28:44 -0400
Received: from imap.gmx.net ([213.165.64.20]:9901 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267580AbUHPM1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 08:27:37 -0400
X-Authenticated: #1725425
Date: Mon, 16 Aug 2004 14:38:17 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: John Wendel <jwendel10@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
Message-Id: <20040816143817.0de30197.Ballarin.Marc@gmx.de>
In-Reply-To: <411FD919.9030702@comcast.net>
References: <411FD919.9030702@comcast.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004 14:43:53 -0700
John Wendel <jwendel10@comcast.net> wrote:

> K3B detects my Lite-on LTR-52327S CDRW as a CDROM when run with 2.6.8.1.
> 
> Booting back into 2.6.7 corrects the problem. I've attached the (totally
> 
> uninteresting parts of) dmesg.  Any clues  appreciated.
> ...

Due to the newly added command filtering, you now need to run cdrecord as
root. Since cdrecord will drop root privileges before accessing the drive,
setuid root won't help.

This means you will have to run cdrecord *and* k3b as root!

IMHO it is more secure to simply disable filtering, and run the software as non-root.

This patch restores the behaviour of previous kernels, security issues included:

--- linux-2.6.8/drivers/block/scsi_ioctl.c~	2004-08-16 14:16:57.000000000 +0200
+++ linux-2.6.8/drivers/block/scsi_ioctl.c	2004-08-16 14:36:22.562908552 +0200
@@ -196 +196 @@
-	if (verify_command(file, cmd))
+/*	if (verify_command(file, cmd))
@@ -198 +198 @@
-
+*/
