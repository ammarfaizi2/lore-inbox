Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKQUlc>; Fri, 17 Nov 2000 15:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129147AbQKQUlW>; Fri, 17 Nov 2000 15:41:22 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:36109 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S129097AbQKQUlK>;
	Fri, 17 Nov 2000 15:41:10 -0500
Date: Fri, 17 Nov 2000 22:10:33 +0200 (EET)
From: <jani@virtualro.ic.ro>
To: jsimmons@acsu.buffalo.edu
cc: linux-kernel@vger.kernel.org
Subject: [patch] vgacon 
Message-ID: <Pine.LNX.4.10.10011172203550.4739-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi James,

here is a patch for vgacon.c could you please check it?

1) removes explicit 0 initialisation of statics

2) removes an apparently unnecesary line in vgacon_scroll:
	as I see it scr_end is computed anyway after the if statement so
no need to put it on the else branch.

Jani.

--- /usr/src/linux-2.4.0/drivers/video/vgacon.c	Thu Nov 16 20:04:52 2000
+++ vgacon.c	Fri Nov 17 10:42:29 2000
@@ -104,7 +104,7 @@
 static u16             vga_video_port_val;	/* Video register value port */
 static unsigned int    vga_video_num_columns;	/* Number of text columns */
 static unsigned int    vga_video_num_lines;	/* Number of text lines */
-static int	       vga_can_do_color = 0;	/* Do we support colors? */
+static int	       vga_can_do_color;	/* Do we support colors? */
 static unsigned int    vga_default_font_height;	/* Height of default screen font */
 static unsigned char   vga_video_type;		/* Card type */
 static unsigned char   vga_hardscroll_enabled;
@@ -112,7 +112,7 @@
 /*
  * SoftSDV doesn't have hardware assist VGA scrolling 
  */
-static unsigned char   vga_hardscroll_user_enable = 0;
+static unsigned char   vga_hardscroll_user_enable;
 #else
 static unsigned char   vga_hardscroll_user_enable = 1;
 #endif
@@ -122,7 +122,7 @@
 static int	       vga_is_gfx;
 static int	       vga_512_chars;
 static int	       vga_video_font_height;
-static unsigned int    vga_rolled_over = 0;
+static unsigned int    vga_rolled_over;
 
 
 static int __init no_scroll(char *str)
@@ -965,7 +965,7 @@
 
 static void vgacon_save_screen(struct vc_data *c)
 {
-	static int vga_bootup_console = 0;
+	static int vga_bootup_console;
 
 	if (!vga_bootup_console) {
 		/* This is a gross hack, but here is the only place we can
@@ -1015,7 +1015,6 @@
 			vga_rolled_over = 0;
 		} else
 			c->vc_origin -= delta;
-		c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
 		scr_memsetw((u16 *)(c->vc_origin), c->vc_video_erase_char, delta);
 	}
 	c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
