Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265633AbSJaXNl>; Thu, 31 Oct 2002 18:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265733AbSJaXNj>; Thu, 31 Oct 2002 18:13:39 -0500
Received: from mario.gams.at ([194.42.96.10]:23156 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S265633AbSJaXLq>;
	Thu, 31 Oct 2002 18:11:46 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.3
From: Bernd Petrovitsch <bernd@gams.at>
To: mec@shout.net
cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_254541320"
Date: Fri, 01 Nov 2002 00:17:49 +0100
Message-ID: <26576.1036106269@frodo.gams.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_254541320
Content-Type: text/plain; charset=us-ascii

Hi all !

I added mouse wheel support to the `xconfig` program.
It is the straight forward solution : just assign the existing 
actions to the wheel buttons.
It applies cleanly to 2.5.4[45] and 2.4.1[789] (and therefore 
probably to a lot more).

	Bernd

--==_Exmh_254541320
Content-Type: application/x-patch ; name="2.5.45-wheel.patch"
Content-Description: 2.5.45-wheel.patch
Content-Disposition: attachment; filename="2.5.45-wheel.patch"

--- linux-2.5.45/scripts/tkgen.c-orig	Sun Jan 13 15:55:11 2002
+++ linux-2.5.45/scripts/tkgen.c	Sun Jan 13 16:02:34 2002
@@ -197,6 +197,7 @@
          *  previous options
          */
         printf( "\tbind all <Alt-n> \"puts \\\"no more menus\\\" \"\n");
+        printf( "\tbind $w <Alt-Button-5> \"puts \\\"no more menus\\\" \"\n");
     }
     else
     {
@@ -204,6 +205,7 @@
          * I should be binding to $w not all - but if I do nehat I get the error "unknown path"
          */
         printf( "\tbind all <Alt-n> $nextscript\n");
+        printf( "\tbind $w <Alt-Button-5> $nextscript\n");
     }
     printf( "\tbutton $w.f.prev -text \"Prev\" -underline 0\\\n" );
     printf( "\t\t-width 15 -command \"catch {focus $oldFocus}; destroy $w; unregister_active %d; menu%d .menu%d \\\"$title\\\"\"\n",
@@ -215,6 +217,8 @@
     {
         printf( "\tbind $w <Alt-p> \"catch {focus $oldFocus}; destroy $w; unregister_active %d; menu%d .menu%d \\\"$title\\\";break\"\n",
             menu_num, menu_num-1, menu_num-1 );
+        printf( "\tbind $w <Alt-Button-4> \"catch {focus $oldFocus}; destroy $w; unregister_active %d; menu%d .menu%d \\\"$title\\\";break\"\n",
+            menu_num, menu_num-1, menu_num-1 );
     }  
     printf( "\tpack $w.f.back $w.f.next $w.f.prev -side left -expand on\n" );
     printf( "\tpack $w.f -pady 10 -side bottom -anchor w -fill x\n" );
@@ -243,11 +247,17 @@
     printf( "\t\t-width [expr [winfo screenwidth .] * 1 / 2] \n" );
     printf( "\tframe $w.config.f\n" );
     printf( "\tbind $w <Key-Down> \"$w.config.canvas yview scroll  1 unit;break;\"\n");
+    printf( "\tbind $w <Shift-Button-5> \"$w.config.canvas yview scroll  1 unit;break;\"\n");
+    printf( "\tbind $w <Button-5> \"$w.config.canvas yview scroll  5 unit;break;\"\n");
     printf( "\tbind $w <Key-Up> \"$w.config.canvas yview scroll  -1 unit;break;\"\n");
+    printf( "\tbind $w <Shift-Button-4> \"$w.config.canvas yview scroll  -1 unit;break;\"\n");
+    printf( "\tbind $w <Button-4> \"$w.config.canvas yview scroll  -5 unit;break;\"\n");
     printf( "\tbind $w <Key-Next> \"$w.config.canvas yview scroll  1 page;break;\"\n");
     printf( "\tbind $w <Key-Prior> \"$w.config.canvas yview scroll  -1 page;break;\"\n");
     printf( "\tbind $w <Key-Home> \"$w.config.canvas yview moveto 0;break;\"\n");
+    printf( "\tbind $w <Control-Button-4> \"$w.config.canvas yview moveto 0;break;\"\n");
     printf( "\tbind $w <Key-End> \"$w.config.canvas yview moveto 1 ;break;\"\n");
+    printf( "\tbind $w <Control-Button-5> \"$w.config.canvas yview moveto 1 ;break;\"\n");
     printf( "\tpack $w.config.canvas -side right -fill y\n" );
     printf("\n\n");
 }

--==_Exmh_254541320
Content-Type: text/plain; charset=iso-8859-1

Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at

--==_Exmh_254541320--


