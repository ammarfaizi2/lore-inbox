Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSFXXZ5>; Mon, 24 Jun 2002 19:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSFXXZ4>; Mon, 24 Jun 2002 19:25:56 -0400
Received: from scl-ims.phoenix.com ([134.122.1.73]:38149 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP
	id <S315415AbSFXXZz>; Mon, 24 Jun 2002 19:25:55 -0400
Message-ID: <E940772158AFE243A3D8D0A741236D4B06FAFE@irv-exch2k.phoenix.com>
From: Dan Boals <Dan_Boals@Phoenix.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: frame buffer -- 1024x768 logo --  Kernel Panic
Date: Mon, 24 Jun 2002 16:25:47 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C21BD6.780B8BA8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C21BD6.780B8BA8
Content-Type: text/plain;
	charset="iso-8859-1"

Not exactly sure who to email this to so,  to whomever cares -

	hopefully this isn't old news, I tried a 1024x768 logo and got a
kernel panic.   

	I traced it down to one line of code in /drivers/video/fbcon.c

	Attached is a patch file that seems to fix the problem.  I am not
sure if this fix is absolutely correct.

	NOTE: The patch does NOT include changing the LOGO_W and LOGO_H
lines to 1024 and 768,  nor does it include a linux_logo.h file with a
1024x768 logo.


Daniel Boals
Principal Engineer
Phoenix Technologies, ltd.



------_=_NextPart_000_01C21BD6.780B8BA8
Content-Type: application/octet-stream;
	name="fbcon.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fbcon.patch"

--- RH73_KERNEL/drivers/video/fbcon.c	Mon Jun 24 16:00:12 2002=0A=
+++ RH73_KERNEL.bak/drivers/video/fbcon.c	Mon Jun 24 15:26:18 2002=0A=
@@ -688,21 +688,22 @@=0A=
     	    	scr_memcpyw(r + step, r, conp->vc_size_row);=0A=
     	    	r -=3D old_cols;=0A=
     	    }=0A=
     	    if (!save) {=0A=
 	    	conp->vc_y +=3D logo_lines;=0A=
     		conp->vc_pos +=3D logo_lines * conp->vc_size_row;=0A=
     	    }=0A=
     	}=0A=
     	scr_memsetw((unsigned short *)conp->vc_origin,=0A=
 		    conp->vc_video_erase_char, =0A=
-		    conp->vc_size_row * logo_lines);=0A=
+		    old_cols * logo_lines);=0A=
+	=0A=
     }=0A=
     =0A=
     /*=0A=
      *  ++guenther: console.c:vc_allocate() relies on initializing=0A=
      *  vc_{cols,rows}, but we must not set those if we are only=0A=
      *  resizing the console.=0A=
      */=0A=
     if (init) {=0A=
 	conp->vc_cols =3D nr_cols;=0A=
 	conp->vc_rows =3D nr_rows;=0A=

------_=_NextPart_000_01C21BD6.780B8BA8--
