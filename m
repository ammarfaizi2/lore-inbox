Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132713AbRC2LJN>; Thu, 29 Mar 2001 06:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132712AbRC2LIz>; Thu, 29 Mar 2001 06:08:55 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:37131 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S132710AbRC2LIe>; Thu, 29 Mar 2001 06:08:34 -0500
Date: Thu, 29 Mar 2001 15:07:17 +0400
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] framebuffer drivers: static zero initializers removal
Message-ID: <20010329150717.A18334@debian>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

IMHO subject is selfexplaining. Affected files: amifb.c, atafb.c, clgenfb.c,
cyberfb.c, tdfxfb.c, tgafb.c, vesafb.c, vfb.c, vga16fb.c, vgacon.c, virgefb=
.c
and most importantly skeletonfb.c :)

All patches are extremely simple, except patch for TGA framebuffer which
adds missing pci_enable_device() call.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename=patch-amifb
Content-Transfer-Encoding: quoted-printable

diff -ur -x .depend -x *.o -x *.flags /linux.vanilla/drivers/video/amifb.c =
/linux/drivers/video/amifb.c
--- /linux.vanilla/drivers/video/amifb.c	Tue Mar 27 20:32:55 2001
+++ /linux/drivers/video/amifb.c	Thu Mar 29 21:02:36 2001
@@ -661,7 +661,7 @@
 	copins *rebuild[2];
 } copdisplay;
=20
-static u_short currentcop =3D 0;
+static u_short currentcop;
=20
 	/*
 	 * Hardware Cursor
@@ -742,7 +742,7 @@
 	u_short fmode;		/* vmode */
 } currentpar;
=20
-static int currcon =3D 0;
+static int currcon;
=20
 static struct display disp;
=20
@@ -770,18 +770,18 @@
 	 * Latches for Display Changes during VBlank
 	 */
=20
-static u_short do_vmode_full =3D 0;	/* Change the Video Mode */
-static u_short do_vmode_pan =3D 0;	/* Update the Video Mode */
-static short do_blank =3D 0;		/* (Un)Blank the Screen (=B11) */
-static u_short do_cursor =3D 0;		/* Move the Cursor */
+static u_short do_vmode_full;		/* Change the Video Mode */
+static u_short do_vmode_pan;		/* Update the Video Mode */
+static short do_blank;			/* (Un)Blank the Screen (=B11) */
+static u_short do_cursor;		/* Move the Cursor */
=20
=20
 	/*
 	 * Various Flags
 	 */
=20
-static u_short is_blanked =3D 0;		/* Screen is Blanked */
-static u_short is_lace =3D 0;		/* Screen is laced */
+static u_short is_blanked;		/* Screen is Blanked */
+static u_short is_lace;			/* Screen is laced */
=20
 	/*
 	 * Frame Buffer Name
@@ -929,8 +929,8 @@
 #define DEFMODE_AGA	    19	/* "vga70" for AGA */
=20
=20
-static int amifb_ilbm =3D 0;	/* interleaved or normal bitplanes */
-static int amifb_inverse =3D 0;
+static int amifb_ilbm;		/* interleaved or normal bitplanes */
+static int amifb_inverse;
=20
=20
 	/*
@@ -1573,7 +1573,7 @@
 	 * Allocate, Clear and Align a Block of Chip Memory
 	 */
=20
-static u_long unaligned_chipptr =3D 0;
+static u_long unaligned_chipptr;
=20
 static inline u_long __init chipalloc(u_long size)
 {
@@ -1923,7 +1923,7 @@
 static char __init *strtoke(char *s,const char *ct)
 {
 	char *sbegin, *send;
-	static char *ssave =3D NULL;
+	static char *ssave;
=20
 	sbegin  =3D s ? s : ssave;
 	if (!sbegin)

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-atafb
Content-Transfer-Encoding: quoted-printable

diff -ur -x .depend -x *.o -x *.flags /linux.vanilla/drivers/video/atafb.c =
/linux/drivers/video/atafb.c
--- /linux.vanilla/drivers/video/atafb.c	Tue Mar 27 20:32:55 2001
+++ /linux/drivers/video/atafb.c	Thu Mar 29 21:04:50 2001
@@ -89,9 +89,9 @@
 #define up(x, r) (((x) + (r) - 1) & ~((r)-1))
=20
=20
-static int default_par=3D0;	/* default resolution (0=3Dnone) */
+static int default_par;		/* default resolution (0=3Dnone) */
=20
-static unsigned long default_mem_req=3D0;
+static unsigned long default_mem_req;
=20
 static int hwscroll=3D-1;
=20
@@ -99,7 +99,7 @@
=20
 static int sttt_xres=3D640,st_yres=3D400,tt_yres=3D480;
 static int sttt_xres_virtual=3D640,sttt_yres_virtual=3D400;
-static int ovsc_offset=3D0, ovsc_addlen=3D0;
+static int ovsc_offset, ovsc_addlen;
=20
 static struct atafb_par {
 	void *screen_base;
@@ -139,7 +139,7 @@
 /* Don't calculate an own resolution, and thus don't change the one found =
when
  * booting (currently used for the Falcon to keep settings for internal vi=
deo
  * hardware extensions (e.g. ScreenBlaster)  */
-static int DontCalcRes =3D 0;=20
+static int DontCalcRes;=20
=20
 #ifdef ATAFB_FALCON
 #define HHT hw.falcon.hht
@@ -171,11 +171,11 @@
=20
 static int screen_len;
=20
-static int current_par_valid=3D0;=20
+static int current_par_valid;=20
=20
-static int currcon=3D0;
+static int currcon;
=20
-static int mono_moni=3D0;
+static int mono_moni;
=20
 static struct display disp;
=20
@@ -192,9 +192,9 @@
=20
 static unsigned			external_depth;
 static int				external_pmode;
-static void *external_addr =3D 0;
+static void *external_addr;
 static unsigned long	external_len;
-static unsigned long	external_vgaiobase =3D 0;
+static unsigned long	external_vgaiobase;
 static unsigned int		external_bitspercol =3D 6;
=20
 /*=20
@@ -242,7 +242,7 @@
 #endif /* ATAFB_EXT */
=20
=20
-static int inverse=3D0;
+static int inverse;
=20
 extern int fontheight_8x8;
 extern int fontwidth_8x8;
@@ -1469,9 +1469,9 @@
 }
=20
=20
-static int f_change_mode =3D 0;
+static int f_change_mode;
 static struct falcon_hw f_new_mode;
-static int f_pan_display =3D 0;
+static int f_pan_display;
=20
 static void falcon_get_par( struct atafb_par *par )
 {
@@ -2865,7 +2865,7 @@
 static char * strtoke(char * s,const char * ct)
 {
   char *sbegin, *send;
-  static char *ssave =3D NULL;
+  static char *ssave;
  =20
   sbegin  =3D s ? s : ssave;
   if (!sbegin) {

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-clgenfb
Content-Transfer-Encoding: quoted-printable

diff -ur -x .depend -x *.o -x *.flags /linux.vanilla/drivers/video/clgenfb.=
c /linux/drivers/video/clgenfb.c
--- /linux.vanilla/drivers/video/clgenfb.c	Tue Mar 27 20:32:55 2001
+++ /linux/drivers/video/clgenfb.c	Thu Mar 29 21:10:12 2001
@@ -98,7 +98,7 @@
 #ifndef CLGEN_NDEBUG
 #define assert(expr) \
         if(!(expr)) { \
-        printk( "Assertion failed! %s,%s,%s,line=3D%d\n",\
+        printk(KERN_DEBUG "Assertion failed! %s,%s,%s,line=3D%d\n",\
         #expr,__FILE__,__FUNCTION__,__LINE__); \
         }
 #else
@@ -407,7 +407,7 @@
=20
 static unsigned clgen_def_mode =3D 1;
=20
-static int release_io_ports =3D 0;
+static int release_io_ports;
=20
=20
=20
@@ -622,7 +622,7 @@
 /*************************************************************************=
****/
 /*** BEGIN Interface Used by the World ***********************************=
****/
=20
-static int opencount =3D 0;
+static int opencount;
=20
 /*--- Open /dev/fbx ------------------------------------------------------=
---*/
 static int clgenfb_open (struct fb_info *info, int user)
@@ -1816,7 +1816,7 @@
 	 *    blank_mode =3D=3D 4: powerdown
 	 */
 	unsigned char val;
-	static int current_mode =3D 0;
+	static int current_mode;
 	struct clgenfb_info *fb_info =3D (struct clgenfb_info *) info;
=20
 	DPRINTK ("ENTER, blank mode =3D %d\n", blank_mode);
@@ -2103,7 +2103,7 @@
 static void switch_monitor (struct clgenfb_info *fb_info, int on)
 {
 #ifdef CONFIG_ZORRO /* only works on Zorro boards */
-	static int IsOn =3D 0;	/* XXX not ok for multiple boards */
+	static int IsOn;	/* XXX not ok for multiple boards */
=20
 	DPRINTK ("ENTER\n");
=20

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-cyberfb
Content-Transfer-Encoding: quoted-printable

diff -ur -x .depend -x *.o -x *.flags /linux.vanilla/drivers/video/cyberfb.=
c /linux/drivers/video/cyberfb.c
--- /linux.vanilla/drivers/video/cyberfb.c	Fri Feb 23 20:34:01 2001
+++ /linux/drivers/video/cyberfb.c	Thu Mar 29 21:12:08 2001
@@ -122,8 +122,8 @@
=20
 static struct cyberfb_par current_par;
=20
-static int current_par_valid =3D 0;
-static int currcon =3D 0;
+static int current_par_valid;
+static int currcon;
=20
 static struct display disp;
 static struct fb_info fb_info;
@@ -221,7 +221,7 @@
=20
 #define NUM_TOTAL_MODES    ARRAY_SIZE(cyberfb_predefined)
=20
-static int Cyberfb_inverse =3D 0;
+static int Cyberfb_inverse;
=20
 /*
  *    Some default modes
@@ -1412,7 +1412,7 @@
 			     volatile unsigned char *base)
 {
 	volatile unsigned char *addr;
-	static unsigned char cvportbits =3D 0; /* Mirror port bits here */
+	static unsigned char cvportbits;	/* Mirror port bits here */
 	DPRINTK("ENTER\n");
=20
 	addr =3D base + 0x40001;

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-tdfxfb
Content-Transfer-Encoding: quoted-printable

diff -ur -x .depend -x *.o -x *.flags /linux.vanilla/drivers/video/tdfxfb.c=
 /linux//drivers/video/tdfxfb.c
--- /linux.vanilla/drivers/video/tdfxfb.c	Tue Mar 27 20:32:57 2001
+++ /linux//drivers/video/tdfxfb.c	Thu Mar 29 21:29:29 2001
@@ -458,7 +458,7 @@
 void tdfxfb_setup(char *options,=20
 		  int *ints);
=20
-static int currcon =3D 0;
+static int currcon;
=20
 static struct fb_ops tdfxfb_ops =3D {
 	owner:		THIS_MODULE,
@@ -491,14 +491,14 @@
=20
 static struct fb_info_tdfx fb_info;
=20
-static int  noaccel =3D 0;
-static int  nopan   =3D 0;
+static int  noaccel;
+static int  nopan;
 static int  nowrap  =3D 1;      // not implemented (yet)
-static int  inverse =3D 0;
+static int  inverse;
 #ifdef CONFIG_MTRR
-static int  nomtrr =3D 0;
+static int  nomtrr;
 #endif
-static int  nohwcursor =3D 0;
+static int  nohwcursor;
 static char __initdata fontname[40] =3D { 0 };
 static const char *mode_option __initdata =3D NULL;
=20

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-tgafb
Content-Transfer-Encoding: quoted-printable

diff -ur -x .depend -x *.o -x *.flags /linux.vanilla/drivers/video/tgafb.c =
/linux//drivers/video/tgafb.c
--- /linux.vanilla/drivers/video/tgafb.c	Tue Mar 27 20:32:57 2001
+++ /linux//drivers/video/tgafb.c	Thu Mar 29 22:01:09 2001
@@ -57,14 +57,14 @@
=20
 static struct tgafb_info fb_info;
 static struct tgafb_par current_par;
-static int current_par_valid =3D 0;
+static int current_par_valid;
 static struct display disp;
=20
 static char default_fontname[40] __initdata =3D { 0 };
 static struct fb_var_screeninfo default_var;
-static int default_var_valid =3D 0;
+static int default_var_valid;
=20
-static int currcon =3D 0;
+static int currcon;
=20
 static struct { u_char red, green, blue, pad; } palette[256];
 #ifdef FBCON_HAS_CFB32
@@ -778,7 +778,7 @@
=20
 static int tgafb_blank(int blank, struct fb_info_gen *info)
 {
-    static int tga_vesa_blanked =3D 0;
+    static int tga_vesa_blanked;
     u32 vhcr, vvcr, vvvr;
     unsigned long flags;
    =20
@@ -921,14 +921,20 @@
 int __init tgafb_init(void)
 {
     struct pci_dev *pdev;
+    int retval;
=20
     pdev =3D pci_find_device(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TGA, NUL=
L);
     if (!pdev)
 	return -ENXIO;
=20
+    if ((retval =3D pci_enable_device(pdev)))
+	return retval;
+
     /* divine board type */
=20
-    fb_info.tga_mem_base =3D (unsigned long)ioremap(pdev->resource[0].star=
t, 0);
+    fb_info.tga_mem_base =3D (unsigned long)ioremap(pci_resource_start(pde=
v, 0), 0);
+    if (!fb_info.tga_mem_base)
+	return -ENOMEM;
     fb_info.tga_type =3D (readl(fb_info.tga_mem_base) >> 12) & 0x0f;
     fb_info.tga_regs_base =3D fb_info.tga_mem_base + TGA_REGS_OFFSET;
     fb_info.tga_fb_base =3D (fb_info.tga_mem_base
@@ -979,11 +985,11 @@
     fbgen_do_set_var(&disp.var, 1, &fb_info.gen);
     fbgen_set_disp(-1, &fb_info.gen);
     fbgen_install_cmap(0, &fb_info.gen);
-    if (register_framebuffer(&fb_info.gen.info) < 0)
-	return -EINVAL;
+    if ((retval =3D register_framebuffer(&fb_info.gen.info)))
+	return retval;
     printk(KERN_INFO "fb%d: %s frame buffer device at 0x%lx\n",=20
 	    GET_FB_IDX(fb_info.gen.info.node), fb_info.gen.info.modename,=20
-	    pdev->resource[0].start);
+	    pci_resource_start(pdev, 0));
     return 0;
 }
=20
@@ -994,6 +1000,7 @@
=20
 void __exit tgafb_cleanup(void)
 {
+    iounmap((void *)fb_info.tga_mem_base);
     unregister_framebuffer(&fb_info.gen.info);
 }
=20

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-vesafb
Content-Transfer-Encoding: quoted-printable

diff -ur -x .depend -x *.o -x *.flags /linux.vanilla/drivers/video/vesafb.c=
 /linux//drivers/video/vesafb.c
--- /linux.vanilla/drivers/video/vesafb.c	Tue Mar 27 20:32:57 2001
+++ /linux//drivers/video/vesafb.c	Thu Mar 29 22:13:55 2001
@@ -59,22 +59,11 @@
 /* --------------------------------------------------------------------- */
=20
 static struct fb_var_screeninfo vesafb_defined =3D {
-	0,0,0,0,	/* W,H, W, H (virtual) load xres,xres_virtual*/
-	0,0,		/* virtual -> visible no offset */
-	8,		/* depth -> load bits_per_pixel */
-	0,		/* greyscale ? */
-	{0,0,0},	/* R */
-	{0,0,0},	/* G */
-	{0,0,0},	/* B */
-	{0,0,0},	/* transparency */
-	0,		/* standard pixel format */
-	FB_ACTIVATE_NOW,
-	-1,-1,
-	0,
-	0L,0L,0L,0L,0L,
-	0L,0L,0,	/* No sync info */
-	FB_VMODE_NONINTERLACED,
-	{0,0,0,0,0,0}
+	bits_per_pixel:	8,	/* depth -> load bits_per_pixel */
+	activate:	FB_ACTIVATE_NOW,
+	height:		-1,
+	width:		-1,
+	vmode:		FB_VMODE_NONINTERLACED,
 };
=20
 static struct display disp;
@@ -92,13 +81,13 @@
 #endif
 } fbcon_cmap;
=20
-static int             inverse   =3D 0;
-static int             mtrr      =3D 0;
-static int             currcon   =3D 0;
+static int             inverse;
+static int             mtrr;
+static int             currcon;
=20
-static int             pmi_setpal =3D 0;	/* pmi for palette changes ??? */
-static int             ypan       =3D 0;  /* 0..nothing, 1..ypan, 2..ywrap=
 */
-static unsigned short  *pmi_base  =3D 0;
+static int             pmi_setpal;	/* pmi for palette changes ??? */
+static int             ypan;		/* 0..nothing, 1..ypan, 2..ywrap */
+static unsigned short  *pmi_base;
 static void            (*pmi_start)(void);
 static void            (*pmi_pal)(void);
=20

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-vfb
Content-Transfer-Encoding: quoted-printable

diff -ur -x .depend -x *.o -x *.flags /linux.vanilla/drivers/video/vfb.c /l=
inux//drivers/video/vfb.c
--- /linux.vanilla/drivers/video/vfb.c	Fri Feb 23 20:34:02 2001
+++ /linux//drivers/video/vfb.c	Thu Mar 29 22:29:58 2001
@@ -43,7 +43,7 @@
=20
 static u_long videomemory, videomemorysize =3D VIDEOMEMSIZE;
 MODULE_PARM(videomemorysize, "l");
-static int currcon =3D 0;
+static int currcon;
 static struct display disp;
 static struct fb_info fb_info;
 static struct { u_char red, green, blue, pad; } palette[256];
@@ -68,7 +68,7 @@
     0, FB_VMODE_NONINTERLACED
 };
=20
-static int vfb_enable =3D 0;	/* disabled by default */
+static int vfb_enable;		/* disabled by default */
=20
=20
     /*

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-vga16fb
Content-Transfer-Encoding: quoted-printable

diff -ur -x .depend -x *.o -x *.flags /linux.vanilla/drivers/video/vga16fb.=
c /linux//drivers/video/vga16fb.c
--- /linux.vanilla/drivers/video/vga16fb.c	Tue Mar 27 20:32:57 2001
+++ /linux//drivers/video/vga16fb.c	Thu Mar 29 22:28:18 2001
@@ -102,7 +102,7 @@
 static struct display disp;
 static struct { u_short blue, green, red, pad; } palette[256];
=20
-static int             currcon   =3D 0;
+static int             currcon;
=20
 /* --------------------------------------------------------------------- */
=20

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-vgacon
Content-Transfer-Encoding: quoted-printable

diff -ur -x .depend -x *.o -x *.flags /linux.vanilla/drivers/video/vgacon.c=
 /linux//drivers/video/vgacon.c
--- /linux.vanilla/drivers/video/vgacon.c	Fri Feb 23 20:34:02 2001
+++ /linux//drivers/video/vgacon.c	Thu Mar 29 21:17:57 2001
@@ -104,7 +104,7 @@
 static u16             vga_video_port_val;	/* Video register value port */
 static unsigned int    vga_video_num_columns;	/* Number of text columns */
 static unsigned int    vga_video_num_lines;	/* Number of text lines */
-static int	       vga_can_do_color =3D 0;	/* Do we support colors? */
+static int	       vga_can_do_color;	/* Do we support colors? */
 static unsigned int    vga_default_font_height;	/* Height of default scree=
n font */
 static unsigned char   vga_video_type;		/* Card type */
 static unsigned char   vga_hardscroll_enabled;
@@ -112,7 +112,7 @@
 /*
  * SoftSDV doesn't have hardware assist VGA scrolling=20
  */
-static unsigned char   vga_hardscroll_user_enable =3D 0;
+static unsigned char   vga_hardscroll_user_enable;
 #else
 static unsigned char   vga_hardscroll_user_enable =3D 1;
 #endif
@@ -122,7 +122,7 @@
 static int	       vga_is_gfx;
 static int	       vga_512_chars;
 static int	       vga_video_font_height;
-static unsigned int    vga_rolled_over =3D 0;
+static unsigned int    vga_rolled_over;
=20
=20
 static int __init no_scroll(char *str)
@@ -965,7 +965,7 @@
=20
 static void vgacon_save_screen(struct vc_data *c)
 {
-	static int vga_bootup_console =3D 0;
+	static int vga_bootup_console;
=20
 	if (!vga_bootup_console) {
 		/* This is a gross hack, but here is the only place we can

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-virgefb
Content-Transfer-Encoding: quoted-printable

diff -ur -x .depend -x *.o -x *.flags /linux.vanilla/drivers/video/virgefb.=
c /linux//drivers/video/virgefb.c
--- /linux.vanilla/drivers/video/virgefb.c	Fri Feb 23 20:34:02 2001
+++ /linux//drivers/video/virgefb.c	Thu Mar 29 21:27:53 2001
@@ -107,8 +107,8 @@
=20
 static struct virgefb_par current_par;
=20
-static int current_par_valid =3D 0;
-static int currcon =3D 0;
+static int current_par_valid;
+static int currcon;
=20
 static struct display disp;
 static struct fb_info fb_info;
@@ -141,7 +141,7 @@
    void (*blank)(int blank);
 } *fbhw;
=20
-static int blit_maybe_busy =3D 0;
+static int blit_maybe_busy;
=20
 /*
  *    Frame Buffer Name
@@ -278,7 +278,7 @@
 #define NUM_TOTAL_MODES    ARRAY_SIZE(virgefb_predefined)
=20
=20
-static int Cyberfb_inverse =3D 0;
+static int Cyberfb_inverse;
=20
 /*
  *    Some default modes

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-skeletonfb
Content-Transfer-Encoding: quoted-printable

diff -ur -x .depend -x *.o -x *.flags /linux.vanilla/drivers/video/skeleton=
fb.c /linux//drivers/video/skeletonfb.c
--- /linux.vanilla/drivers/video/skeletonfb.c	Fri Feb 23 20:34:02 2001
+++ /linux//drivers/video/skeletonfb.c	Thu Mar 29 21:14:34 2001
@@ -65,13 +65,13 @@
=20
 static struct xxxfb_info fb_info;
 static struct xxxfb_par current_par;
-static int current_par_valid =3D 0;
+static int current_par_valid;
 static struct display disp;
=20
 static struct fb_var_screeninfo default_var;
=20
-static int currcon =3D 0;
-static int inverse =3D 0;
+static int currcon;
+static int inverse;
=20
 int xxxfb_init(void);
 int xxxfb_setup(char*);

--zhXaljGHf11kAtnf--

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6wxdlBm4rlNOo3YgRAjJmAKCD8MK3RWtDVHwx6CV71HkfWRS55ACfSrYx
loa2b8FZ/f8+KDPuihbMcnA=
=vS89
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
