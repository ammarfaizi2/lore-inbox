Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129998AbQLMSZM>; Wed, 13 Dec 2000 13:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130154AbQLMSZD>; Wed, 13 Dec 2000 13:25:03 -0500
Received: from rmx194-mta.mail.com ([165.251.48.41]:29139 "EHLO
	rmx194-mta.mail.com") by vger.kernel.org with ESMTP
	id <S129998AbQLMSYt>; Wed, 13 Dec 2000 13:24:49 -0500
Message-ID: <385246622.976730040933.JavaMail.root@web628-mc>
Date: Wed, 13 Dec 2000 12:54:00 -0500 (EST)
From: Damien BENOIST <damien.benoist@mail.com>
To: linux-kernel@vger.kernel.org, mj@atrey.karlin.mff.cuni.cz,
        linux-video@atrey.karlin.mff.cuni.cz
Subject: kernel 2.2.17 vgaconsole patch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 193.56.46.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had already mailed to mj@atrey.karlin.mff.cuni.cz but got
no answer, so i remail as described in the
"How to Get Your Change Into the Linux Kernel or The Unofficial
Linus HOWTO"
Please give me some feed back (damien.benoist@epita.fr) thanks.

kernel: 2.2.17

pb: // 0 does not work with ega/vga adapter and mono display

how to duplicate the pb:
compile the kernel with the following options (module or not):
- vga console
- parallel port
use the following hardware:
- monochrome display
- ega/vga adapter
- a // port at 0x3bc

changes:
- region size for ega/vga adapter with mono display (12bytes
instead of 16).

--- drivers/video/vgacon.c	Fri Oct 13 21:05:36 2000
+++ drivers/video/vgacon.c.old	Thu Oct 12 16:12:17 2000
@@ -27,9 +27,6 @@
*	flashing on RHS of screen during heavy console scrolling .
*	Oct 1996, Paul Gortmaker.
*
- *	For monochrome display with ega adapter the requested port region was
- *	too large, going over the // port 0 region. //0 was then inaccessible.
- *	Oct 2000, <damien.benoist@epita.fr>
*
*  This file is subject to the terms and conditions of the GNU General
Public
*  License.  See the file COPYING in the main directory of this archive for
@@ -183,7 +180,7 @@
vga_video_type = VIDEO_TYPE_EGAM;
vga_vram_end = 0xb8000;
display_desc = "EGA+";
-			request_region(0x3b0,12,"ega");
+			request_region(0x3b0,16,"ega");
}
else
{


______________________________________________
FREE Personalized Email at Mail.com
Sign up at http://www.mail.com/?sr=signup
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
