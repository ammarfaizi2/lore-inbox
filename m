Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261893AbTC0KTp>; Thu, 27 Mar 2003 05:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261896AbTC0KTp>; Thu, 27 Mar 2003 05:19:45 -0500
Received: from pluvier.ens-lyon.fr ([140.77.167.5]:17103 "EHLO
	mailhost.ens-lyon.fr") by vger.kernel.org with ESMTP
	id <S261893AbTC0KTo>; Thu, 27 Mar 2003 05:19:44 -0500
Date: Thu, 27 Mar 2003 11:30:53 +0100
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: linux-console@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dave@mielke.cc, shindere@ens-lyon.fr
Subject: Braille devices can't scrollback console
Message-ID: <20030327103053.GA974@bouh.residence.ens-lyon.fr>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

There is no way for a braille device driven by brltty (userland root-owned
daemon) to scrollback the virtual console, the only way is to use the pc
keyboard. A very simple TIOCLINUX ioctl meets this need (tested):

diff -urN linux/drivers/char/console.c linux-scrollioctl/drivers/char/console.c
--- linux/drivers/char/console.c	2003-03-27 10:55:43.000000000 +0100
+++ linux-scrollioctl/drivers/char/console.c	2003-03-27 11:04:31.000000000 +0100
@@ -2262,6 +2262,17 @@
 		case 12:	/* get fg_console */
 			ret = fg_console;
 			break;
+		case 13:	/* scroll console */
+			{
+				int lines;
+				if (get_user(lines, (char *)arg+1)) {
+					ret = -EFAULT;
+				} else {
+					scrollfront(lines);
+					ret = 0;
+				}
+			}
+			break;
 		default:
 			ret = -EINVAL;
 			break;

Regards,
Samuel Thibault
