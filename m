Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265733AbTFXH1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 03:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265734AbTFXH1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 03:27:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:25481 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265733AbTFXH1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 03:27:44 -0400
From: Torsten Foertsch <torsten.foertsch@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable Trackpad while typing
Date: Tue, 24 Jun 2003 09:41:16 +0200
User-Agent: KMail/1.4.3
References: <200306201818.40805.torsten.foertsch@gmx.net> <200306221905.15686.torsten.foertsch@gmx.net>
In-Reply-To: <200306221905.15686.torsten.foertsch@gmx.net>
MIME-Version: 1.0
Message-Id: <200306240935.13845.torsten.foertsch@gmx.net>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_SO6ZHE36939NHPUWFWOY"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_SO6ZHE36939NHPUWFWOY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Ok, after some arguments about whether it is good behaviour to send a pat=
ch as=20
attachment to the list. Here it is again as attachment.

> > > > > > Here is now an improved version of the patch. It's against
> > > > > > 2.4.21.
> > > > >
> > > > > it is line-break-broken.
> > > >
> > > > Here it is as attachment
> > >
> > > Thank you. I didn't see lkml in the recipients, assume you post the
> > > patch there separately?
> >
> > Documentation/SubmittingPatches states:
> >
> > 6) No MIME, no links, no compression, no attachments.  Just plain tex=
t.
>
> it is more guidline than a rule.



--------------Boundary-00=_SO6ZHE36939NHPUWFWOY
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ps2-trackpad-2.4.21.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ps2-trackpad-2.4.21.patch"

diff -Naur -X dontdiff linux-2.4.21-orig/Documentation/Configure.help lin=
ux-2.4.21/Documentation/Configure.help
--- linux-2.4.21-orig/Documentation/Configure.help=092003-06-22 15:45:55.=
000000000 +0000
+++ linux-2.4.21/Documentation/Configure.help=092003-06-22 14:10:39.00000=
0000 +0000
@@ -17964,6 +17964,21 @@
   <ftp://gnu.systemy.it/pub/gpm/>) solves this problem, or you can get
   the "mconv2" utility from <ftp://ibiblio.org/pub/Linux/system/mouse/>.
=20
+Disable trackpad while typing
+CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+  For people with a notebook that have a build in trackpad.
+
+  It prevents unintended mouse moves and mouse taps while typing on
+  the notebook keyboard.
+
+  The majority of notebooks on the market have a PS/2 trackpad.=20
+  So you will probably say "Y" if you have a notebook with a trackpad.
+
+  Also note that you can control the behaviour of the trackpad via the=20
+  /proc/tty/ps2-trackpad file.
+
+  See Documentation/ps2-trackpad.txt for detailed information.
+
 C&T 82C710 mouse port support (as on TI Travelmate)
 CONFIG_82C710_MOUSE
   This is a certain kind of PS/2 mouse used on the TI Travelmate. If
diff -Naur -X dontdiff linux-2.4.21-orig/Documentation/ps2-trackpad.txt l=
inux-2.4.21/Documentation/ps2-trackpad.txt
--- linux-2.4.21-orig/Documentation/ps2-trackpad.txt=091970-01-01 00:00:0=
0.000000000 +0000
+++ linux-2.4.21/Documentation/ps2-trackpad.txt=092003-06-22 15:13:45.000=
000000 +0000
@@ -0,0 +1,50 @@
+For people with a notebook that have a build in trackpad.
+
+The "Disable trackpad while typing" feature prevents unintended mouse
+moves and mouse taps while typing on the notebook keyboard.
+
+The majority of notebooks on the market have a PS/2 trackpad.=20
+So you will probably say "Y" if you have a notebook with a trackpad.
+
+Also note that you can control the behaviour of the trackpad via the=20
+/proc/tty/ps2-trackpad file, e.g.
+
+Set the delay time to 2 Secs (default is 10 =3D=3D> 1 Sec)
+
+=09echo "delay 20" > /proc/tty/ps2-trackpad
+
+
+Completely disable the trackpad (default 0). Useful if you plug in an
+external mouse.
+
+=09echo "disable 1" > /proc/tty/ps2-trackpad
+
+To completely disable this feature use
+
+=09echo "delay 0" > /proc/tty/ps2-trackpad
+
+
+Escape the keyboard keycode for the key. After these keycodes mouse
+events are passed without a delay. (defaults are the keycodes for
+CTRL, SHIFT, ALT and MS-Windows (both left and right) and Menu
+(Windows Taskbar) keys).=20
+
+This is useful for some applications ( like xterm ) which are using
+keydown-click events.
+
+You can use showkey -k to find out the keycodes of your own keys.=20
+Apply "escape ???" twice to unescape a keycode.
+
+Example: define an escape for HOME-KeyPress=20
+
+=09echo "escape 102" > /proc/tty/ps2-trackpad
+
+If you want to escape KeyRelease events add 0x100 (256) to the actual
+keycode value.
+
+=09echo "escape 358" > /proc/tty/ps2-trackpad
+
+enables mouse events immediately after releasing HOME key.
+
+I can't imagine a situation where mouse events are needed immediately
+after key release events but it's implemented for completeness.
diff -Naur -X dontdiff linux-2.4.21-orig/drivers/char/Config.in linux-2.4=
=2E21/drivers/char/Config.in
--- linux-2.4.21-orig/drivers/char/Config.in=092003-06-22 15:45:58.000000=
000 +0000
+++ linux-2.4.21/drivers/char/Config.in=092003-06-22 08:50:04.000000000 +=
0000
@@ -179,6 +179,13 @@
 tristate 'Mouse Support (not serial and bus mice)' CONFIG_MOUSE
 if [ "$CONFIG_MOUSE" !=3D "n" ]; then
    bool '  PS/2 mouse (aka "auxiliary device") support' CONFIG_PSMOUSE
+
+   if [ "$CONFIG_PSMOUSE" =3D "y" ]
+   then
+     bool '    Disable Trackpad while typing on Notebooks' CONFIG_DISABL=
E_TRACKPAD_WHILE_TYPING
+   fi
+
+
    tristate '  C&T 82C710 mouse port support (as on TI Travelmate)' CONF=
IG_82C710_MOUSE
    tristate '  PC110 digitizer pad support' CONFIG_PC110_PAD
    tristate '  MK712 touch screen support' CONFIG_MK712_MOUSE
diff -Naur -X dontdiff linux-2.4.21-orig/drivers/char/pc_keyb.c linux-2.4=
=2E21/drivers/char/pc_keyb.c
--- linux-2.4.21-orig/drivers/char/pc_keyb.c=092002-11-28 23:53:12.000000=
000 +0000
+++ linux-2.4.21/drivers/char/pc_keyb.c=092003-06-22 15:39:21.000000000 +=
0000
@@ -13,6 +13,14 @@
  * Code fixes to handle mouse ACKs properly.
  * C. Scott Ananian <cananian@alumni.princeton.edu> 1999-01-29.
  *
+ * Implemented the "disable trackpad while typing" feature. This prevent=
s
+ * unintended mouse moves and mouse taps while typing on the keyboard on
+ * notebooks with a PS/2 trackpad.
+ * Hans-Georg Thien <1682-600@onlinehome.de> 2003-04-30.
+ *
+ * Improvements to the "disable trackpad while typing" feature.
+ * Torsten F=F6rtsch <torsten.foertsch@gmx.net> 2003-06-20.
+ *
  */
=20
 #include <linux/config.h>
@@ -35,7 +43,7 @@
 #include <linux/smp_lock.h>
 #include <linux/kd.h>
 #include <linux/pm.h>
-
+#include <linux/proc_fs.h>
 #include <asm/keyboard.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
@@ -102,6 +110,133 @@
 #define MAX_RETRIES=0960=09=09/* some aux operations take long time*/
 #endif /* CONFIG_PSMOUSE */
=20
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+
+static int trackpad_skipped_events =3D 0;
+static int last_kbd_event =3D 0;     /* timestamp of last kbd event */
+static int last_kbd_scancode =3D 0;=20
+static int last_kbd_scancode_state =3D 0;=20
+static int trackpad_disable =3D 0;
+static int trackpad_delay =3D HZ;    /* default delay is 1Sec */
+
+static unsigned char trackpad_escape[0x200/8]; /* 2*256-Bit vector of ke=
yboard scancodes to ignore */
+
+
+static int trackpad_write_proc(struct file *file,
+                               const char *buf,
+                               unsigned long len,
+                               void *data)
+{
+
+/*
+ * handle write requests to /proc/tty/ps2-trackpad
+ */
+        char lbuf[32];
+        int tmp;
+        int success =3D 0;
+=20
+        if (len > sizeof(lbuf)-1) return -EINVAL;
+
+        if (copy_from_user(lbuf, buf, len)) return -EFAULT;
+
+        lbuf[len] =3D '\0';
+
+        if (sscanf(lbuf, "delay %d", &tmp)) {
+                trackpad_delay =3D (tmp * HZ) / 10; /* convert 1/10Sec t=
o jiffies */
+                success=3D1;=20
+        }
+
+        if (sscanf(lbuf, "disable %d", &tmp)) {
+                trackpad_disable =3D tmp ? 1 : 0;
+                success=3D1;=20
+        }
+
+        if (sscanf(lbuf, "escape %i", &tmp)) {
+                if ((tmp < 0) || (tmp >=3D0x200)) return -EINVAL;
+                change_bit(tmp, trackpad_escape);
+                success=3D1;=20
+        }
+
+        if (!success) return -EINVAL;
+
+        return len;
+}
+
+static int trackpad_read_proc(char *buf, char **start, off_t ofs,
+                              int count, int *eof, void *data)
+{ =20
+
+/*=20
+ * handle read requests to /proc/tty/ps2-trackpad=20
+ */
+
+        int len  =3D 0;
+        int i;
+
+        len +=3D sprintf(buf+len, "delay %d\n",=20
+                                (trackpad_delay * 10) / HZ); /* convert =
jiffies to 1/10Sec */
+        len +=3D sprintf(buf+len, "disable %d\n", trackpad_disable);
+
+        for (i =3D 0; i < sizeof(trackpad_escape) * 8; i++) {
+                if (test_bit(i, trackpad_escape)) {
+                        len +=3D sprintf(buf+len, "escape %d\n", i);
+                }
+        }
+
+        *eof =3D 1;
+        buf[len+1] =3D '\0';
+        return len;
+}
+
+static int trackpad_config_setup(void)
+{ =20
+
+/*=20
+ * create read-write entries in /proc/tty/ps2-trackpad and setup some=20
+ * defaults for the trackpad handling
+ */
+
+        struct proc_dir_entry *trackpad_proc_entry;
+
+        trackpad_proc_entry=3Dcreate_proc_entry("tty/ps2-trackpad", 0, N=
ULL);
+
+        if (trackpad_proc_entry =3D=3D NULL) return -1;
+
+        trackpad_proc_entry->mode |=3D  S_IWUGO;
+        trackpad_proc_entry->read_proc =3D trackpad_read_proc;
+        trackpad_proc_entry->write_proc =3D trackpad_write_proc;
+
+       =20
+        /* set keyboard scancodes to ignore */
+        memset(trackpad_escape, 0, sizeof(trackpad_escape));
+        set_bit(0x1d, trackpad_escape);  /* CTRL-L keydown */
+        set_bit(0x2a, trackpad_escape);  /* SHIFT-L keydown */
+        set_bit(0x38, trackpad_escape);  /* ALT-L keydown */
+
+        set_bit(0x61, trackpad_escape);  /* CTRL-R keydown */
+        set_bit(0x36, trackpad_escape);  /* SHIFT-R keydown */
+        set_bit(0x64, trackpad_escape);  /* ALT-R keydown */
+
+        set_bit(0x7d, trackpad_escape);  /* MS left WINDOWS keydown */
+        set_bit(0x7e, trackpad_escape);  /* MS right WINDOWS keydown */
+        set_bit(0x7f, trackpad_escape);  /* MS right MENU keydown */
+#if 0
+        set_bit(0x01, trackpad_escape);  /* ESC keydown */
+        set_bit(0x66, trackpad_escape);  /* HOME keydown */
+        set_bit(0x67, trackpad_escape);  /* CURSORUP keydown */
+        set_bit(0x68, trackpad_escape);  /* PAGEUP keydown */
+        set_bit(0x69, trackpad_escape);  /* CURSOR-L keydown */
+        set_bit(0x6a, trackpad_escape);  /* CURSOR-R keydown */
+        set_bit(0x6b, trackpad_escape);  /* END keydown */
+        set_bit(0x6c, trackpad_escape);  /* CURSORDOWN keydown */
+        set_bit(0x6d, trackpad_escape);  /* PAGEDOWN keydown */
+#endif
+
+        return 0;
+}
+
+#endif /* CONFIG_DISABLE_TRACKPAD_WHILE_TYPING */
+
 /*
  * Wait for keyboard controller input buffer to drain.
  *
@@ -449,6 +584,24 @@
 =09=09return;
 =09}
=20
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+        if (trackpad_disable) return;
+
+        if (!test_bit(last_kbd_scancode, trackpad_escape)) {
+=09  /* do nothing if time since last kbd event is less then trackpad_de=
lay */
+=09  if (abs(jiffies - last_kbd_event) < trackpad_delay) {
+=09    trackpad_skipped_events++;
+=09    return;
+=09  }
+        }
+=09
+=09if (trackpad_skipped_events%12) {
+=09  trackpad_skipped_events++;
+=09  return;
+=09}
+=09trackpad_skipped_events=3D0;
+#endif
+
 =09prev_code =3D scancode;
 =09add_mouse_randomness(scancode);
 =09if (aux_count) {
@@ -469,6 +622,45 @@
=20
 static inline void handle_keyboard_event(unsigned char scancode)
 {
+
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+  /* this more or less resembles the pckbd_translate() algorithm */
+  if( scancode=3D=3D0xe0 && last_kbd_scancode_state=3D=3D0 ) { /* escape=
 1b */
+    last_kbd_scancode_state =3D 0x100;
+  } else if( scancode=3D=3D0xe1 && last_kbd_scancode_state=3D=3D0 ) { /*=
 escape 2b */
+    last_kbd_scancode_state =3D 0x200;
+  } else if(last_kbd_scancode_state=3D=3D0x100) {
+    /* E0 table lookup */
+    if( last_kbd_scancode =3D e0_keys[scancode&0x7f] ) {
+      if( scancode & 0x80 ) last_kbd_scancode|=3D0x100;
+      last_kbd_event =3D jiffies;
+    }
+    last_kbd_scancode_state=3D0;
+  } else if(last_kbd_scancode_state=3D=3D0x200) {
+    if( (scancode&0x7f)=3D=3D0x1d ) {
+      last_kbd_scancode_state++;
+    } else {
+      last_kbd_scancode_state=3D0; /* unknown e1 sequence */
+    }
+  } else if(last_kbd_scancode_state=3D=3D0x201) {
+    if( (scancode&0x7f)=3D=3D0x45 ) { /* PAUSE key */
+      last_kbd_scancode =3D E1_PAUSE;
+      if( scancode & 0x80 ) last_kbd_scancode|=3D0x100;
+      last_kbd_event =3D jiffies;
+    }
+    last_kbd_scancode_state=3D0;
+  } else {
+    last_kbd_scancode =3D (scancode&0x7f);
+    if( last_kbd_scancode >=3D SC_LIM )
+      last_kbd_scancode=3Dhigh_keys[last_kbd_scancode - SC_LIM];
+    if( last_kbd_scancode ) {
+      if( scancode & 0x80 ) last_kbd_scancode|=3D0x100;
+      last_kbd_event =3D jiffies;
+    }
+    last_kbd_scancode_state=3D0;
+  }
+#endif
+
 #ifdef CONFIG_VT
 =09kbd_exists =3D 1;
 =09if (do_acknowledge(scancode))
@@ -1219,6 +1411,10 @@
 =09kbd_write_command(KBD_CCMD_MOUSE_DISABLE); /* Disable aux device. */
 =09kbd_write_cmd(AUX_INTS_OFF); /* Disable controller ints. */
=20
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+        trackpad_config_setup();
+#endif
+
 =09return 0;
 }
=20

--------------Boundary-00=_SO6ZHE36939NHPUWFWOY--
