Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268254AbTBWMZo>; Sun, 23 Feb 2003 07:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268292AbTBWMZo>; Sun, 23 Feb 2003 07:25:44 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:55472 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S268254AbTBWMZd>;
	Sun, 23 Feb 2003 07:25:33 -0500
Date: Sun, 23 Feb 2003 13:34:03 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Logo updates
Message-ID: <Pine.GSO.4.21.0302231333090.28532-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Logo updates, relative to James' latest fbdev.diff.gz.

  - CONFIG_FB_LOGO got renamed to CONFIG_LOGO
  - Drop CONFIG_ prefix for SGI_NEWPORT_CONSOLE in drivers/video/logo/Kconfig
  - Prefix standard logo help texts with `Standard'
  - Add drivers/video/logo/clut_vga16.ppm, to be used with ppmquant(1) when
    creating 16-color logos
  - Add comments to PNM logos
  - Add missing pnmtologo to scripts/Makefile
  - Add missing scripts/pnmtologo.c
  - Update pnmtologo:
      o Correct rounding rule when converting between different maxvals
      o Suggest using pnmnoraw(1) to make binary PNMs usable
      o Suggest using ppmquant(1) to reduce the number of colors, if needed

James, you also forgot to remove the old asm-*/linux_logo.h files. Please do:

    bk rm include/asm-alpha/linux_logo.h
    bk rm include/asm-arm/linux_logo.h
    bk rm include/asm-i386/linux_logo.h
    bk rm include/asm-ia64/linux_logo.h
    bk rm include/asm-m68k/linux_logo.h
    bk rm include/asm-m68knommu/linux_logo.h
    bk rm include/asm-mips/linux_logo.h
    bk rm include/asm-mips/linux_logo_dec.h
    bk rm include/asm-mips/linux_logo_sgi.h
    bk rm include/asm-mips64/linux_logo.h
    bk rm include/asm-parisc/linux_logo.h
    bk rm include/asm-ppc64/linux_logo.h
    bk rm include/asm-sh/linux_logo.h
    bk rm include/asm-sparc/linux_logo.h
    bk rm include/asm-sparc64/linux_logo.h
    bk rm include/asm-um/linux_logo.h
    bk rm include/asm-x86_64/linux_logo.h

--- linux-fbdev-2.5.62/drivers/video/fbmem.c	Sun Feb 23 13:11:34 2003
+++ linux-fbdev-geert-2.5.62/drivers/video/fbmem.c	Sun Feb 23 13:19:22 2003
@@ -368,7 +368,7 @@
 	return n < 0 ? d >> -n : d << n;
 }
 
-#ifdef CONFIG_FB_LOGO
+#ifdef CONFIG_LOGO
 #include <linux/linux_logo.h>
 
 static void __init fb_set_logocmap(struct fb_info *info,
@@ -661,7 +661,7 @@
 #else
 int fb_prepare_logo(struct fb_info *info) { return 0; }
 int fb_show_logo(struct fb_info *info) { return 0; }
-#endif /* CONFIG_FB_LOGO */
+#endif /* CONFIG_LOGO */
 
 static int fbmem_read_proc(char *buf, char **start, off_t offset,
 			   int len, int *eof, void *private)
--- linux-fbdev-2.5.62/drivers/video/logo/Kconfig	Sun Feb 23 13:11:34 2003
+++ linux-fbdev-geert-2.5.62/drivers/video/logo/Kconfig	Sun Feb 23 13:12:42 2003
@@ -6,20 +6,20 @@
 
 config LOGO
 	bool "Bootup logo"
-	depends on FB || CONFIG_SGI_NEWPORT_CONSOLE
+	depends on FB || SGI_NEWPORT_CONSOLE
 
 config LOGO_LINUX_MONO
-	bool "Black and white Linux logo"
+	bool "Standard black and white Linux logo"
 	depends on LOGO
 	default y
 
 config LOGO_LINUX_VGA16
-	bool "16-color Linux logo"
+	bool "Standard 16-color Linux logo"
 	depends on LOGO
 	default y
 
 config LOGO_LINUX_CLUT224
-	bool "224-color Linux logo"
+	bool "Standard 224-color Linux logo"
 	depends on LOGO
 	default y
 
--- linux-fbdev-2.5.62/drivers/video/logo/clut_vga16.ppm	Thu Jan  1 01:00:00 1970
+++ linux-fbdev-geert-2.5.62/drivers/video/logo/clut_vga16.ppm	Sun Feb 23 13:12:42 2003
@@ -0,0 +1,20 @@
+P3
+# Standard console colors
+16 1
+255
+  0   0   0
+  0   0 170
+  0 170   0
+  0 170 170
+170   0   0
+170   0 170
+170  85   0
+170 170 170
+ 85  85  85
+ 85  85 255
+ 85 255  85
+ 85 255 255
+255  85  85
+255  85 255
+255 255  85
+255 255 255
--- linux-fbdev-2.5.62/drivers/video/logo/logo_dec_clut224.ppm	Sun Feb 23 13:11:34 2003
+++ linux-fbdev-geert-2.5.62/drivers/video/logo/logo_dec_clut224.ppm	Sun Feb 23 13:12:42 2003
@@ -1,4 +1,5 @@
 P3
+# 224-color Digital Equipment Corporation Linux logo
 80 80
 255
   0   0   0   0   0   0   0   0   0   0   0   0
--- linux-fbdev-2.5.62/drivers/video/logo/logo_linux_clut224.ppm	Sun Feb 23 13:11:34 2003
+++ linux-fbdev-geert-2.5.62/drivers/video/logo/logo_linux_clut224.ppm	Sun Feb 23 13:12:42 2003
@@ -1,4 +1,5 @@
 P3
+# Standard 224-color Linux logo
 80 80
 255
   0   0   0   0   0   0   0   0   0   0   0   0
--- linux-fbdev-2.5.62/drivers/video/logo/logo_linux_mono.pbm	Sun Feb 23 13:11:34 2003
+++ linux-fbdev-geert-2.5.62/drivers/video/logo/logo_linux_mono.pbm	Sun Feb 23 13:12:42 2003
@@ -1,4 +1,5 @@
 P1
+# Standard black and white Linux logo
 80 80
 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
--- linux-fbdev-2.5.62/drivers/video/logo/logo_linux_vga16.ppm	Sun Feb 23 13:11:34 2003
+++ linux-fbdev-geert-2.5.62/drivers/video/logo/logo_linux_vga16.ppm	Sun Feb 23 13:12:42 2003
@@ -1,4 +1,5 @@
 P3
+# Standard 16-color Linux logo
 80 80
 255
   0   0   0   0   0   0   0   0   0   0   0   0
--- linux-fbdev-2.5.62/drivers/video/logo/logo_mac_clut224.ppm	Sun Feb 23 13:11:34 2003
+++ linux-fbdev-geert-2.5.62/drivers/video/logo/logo_mac_clut224.ppm	Sun Feb 23 13:12:42 2003
@@ -1,4 +1,5 @@
 P3
+# 224-color Macintosh Linux logo
 80 80
 255
   0   0   0   0   0   0   0   0   0   0   0   0
--- linux-fbdev-2.5.62/drivers/video/logo/logo_parisc_clut224.ppm	Sun Feb 23 13:11:34 2003
+++ linux-fbdev-geert-2.5.62/drivers/video/logo/logo_parisc_clut224.ppm	Sun Feb 23 13:12:42 2003
@@ -1,4 +1,5 @@
 P3
+# 224-color PA-RISC Linux logo
 80 80
 255
    2   2   2   2   2   2   2   2   2   2   2   2
--- linux-fbdev-2.5.62/drivers/video/logo/logo_sgi_clut224.ppm	Sun Feb 23 13:11:34 2003
+++ linux-fbdev-geert-2.5.62/drivers/video/logo/logo_sgi_clut224.ppm	Sun Feb 23 13:12:42 2003
@@ -1,4 +1,5 @@
 P3
+# 224-color SGI Linux logo
 80 80
 255
   0   0   0   0   0   0   0   0   0   0   0   0
--- linux-fbdev-2.5.62/drivers/video/logo/logo_sun_clut224.ppm	Sun Feb 23 13:11:34 2003
+++ linux-fbdev-geert-2.5.62/drivers/video/logo/logo_sun_clut224.ppm	Sun Feb 23 13:12:42 2003
@@ -1,4 +1,5 @@
 P3
+# 224-color Sun Linux logo
 80 80
 255
    0   0   0   0   0   0   0   0   0   0   0   0
--- linux-fbdev-2.5.62/drivers/video/logo/logo_superh_clut224.ppm	Sun Feb 23 13:11:34 2003
+++ linux-fbdev-geert-2.5.62/drivers/video/logo/logo_superh_clut224.ppm	Sun Feb 23 13:12:42 2003
@@ -1,4 +1,5 @@
 P3
+# 224-color SuperH Linux logo
 80 80
 255
   2   2   2   2   2   2   2   2   2   2   2   2
--- linux-fbdev-2.5.62/drivers/video/logo/logo_superh_mono.pbm	Sun Feb 23 13:11:34 2003
+++ linux-fbdev-geert-2.5.62/drivers/video/logo/logo_superh_mono.pbm	Sun Feb 23 13:12:42 2003
@@ -1,4 +1,5 @@
 P1
+# Black and white SuperH Linux logo
 80 80
 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
--- linux-fbdev-2.5.62/drivers/video/logo/logo_superh_vga16.ppm	Sun Feb 23 13:11:34 2003
+++ linux-fbdev-geert-2.5.62/drivers/video/logo/logo_superh_vga16.ppm	Sun Feb 23 13:12:42 2003
@@ -1,4 +1,5 @@
 P3
+# 16-color SuperH Linux logo
 80 80
 255
   0   0   0   0   0   0   0   0   0   0   0   0
--- linux-fbdev-2.5.62/scripts/Makefile	Tue Feb 18 10:08:46 2003
+++ linux-fbdev-geert-2.5.62/scripts/Makefile	Sun Feb 23 13:12:43 2003
@@ -9,7 +9,7 @@
 # conmakehash:	 Create arrays for initializing the kernel console tables
 
 host-progs    := fixdep split-include conmakehash docproc kallsyms modpost \
-		 mk_elfconfig
+		 mk_elfconfig pnmtologo
 build-targets := $(host-progs) empty.o
 
 modpost-objs  := modpost.o file2alias.o
--- linux-fbdev-2.5.62/scripts/pnmtologo.c	Thu Jan  1 01:00:00 1970
+++ linux-fbdev-geert-2.5.62/scripts/pnmtologo.c	Sun Feb 23 13:12:43 2003
@@ -0,0 +1,507 @@
+
+/*
+ *  Convert a logo in ASCII PNM format to C source suitable for inclusion in
+ *  the Linux kernel
+ *
+ *  (C) Copyright 2001-2003 by Geert Uytterhoeven <geert@linux-m68k.org>
+ *
+ *  --------------------------------------------------------------------------
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of the Linux
+ *  distribution for more details.
+ */
+
+#include <ctype.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+
+static const char *programname;
+static const char *filename;
+static const char *logoname = "linux_logo";
+static const char *outputname;
+static FILE *out;
+
+
+#define LINUX_LOGO_MONO		1	/* monochrome black/white */
+#define LINUX_LOGO_VGA16	2	/* 16 colors VGA text palette */
+#define LINUX_LOGO_CLUT224	3	/* 224 colors */
+#define LINUX_LOGO_GRAY256	4	/* 256 levels grayscale */
+
+static const char *logo_types[LINUX_LOGO_GRAY256+1] = {
+    [LINUX_LOGO_MONO] = "LINUX_LOGO_MONO",
+    [LINUX_LOGO_VGA16] = "LINUX_LOGO_VGA16",
+    [LINUX_LOGO_CLUT224] = "LINUX_LOGO_CLUT224",
+    [LINUX_LOGO_GRAY256] = "LINUX_LOGO_GRAY256"
+};
+
+#define MAX_LINUX_LOGO_COLORS	224
+
+struct color {
+    unsigned char red;
+    unsigned char green;
+    unsigned char blue;
+};
+
+static const struct color clut_vga16[16] = {
+    { 0x00, 0x00, 0x00 },
+    { 0x00, 0x00, 0xaa },
+    { 0x00, 0xaa, 0x00 },
+    { 0x00, 0xaa, 0xaa },
+    { 0xaa, 0x00, 0x00 },
+    { 0xaa, 0x00, 0xaa },
+    { 0xaa, 0x55, 0x00 },
+    { 0xaa, 0xaa, 0xaa },
+    { 0x55, 0x55, 0x55 },
+    { 0x55, 0x55, 0xff },
+    { 0x55, 0xff, 0x55 },
+    { 0x55, 0xff, 0xff },
+    { 0xff, 0x55, 0x55 },
+    { 0xff, 0x55, 0xff },
+    { 0xff, 0xff, 0x55 },
+    { 0xff, 0xff, 0xff },
+};
+
+
+static int logo_type = LINUX_LOGO_CLUT224;
+static unsigned int logo_width;
+static unsigned int logo_height;
+static struct color **logo_data;
+static struct color logo_clut[MAX_LINUX_LOGO_COLORS];
+static unsigned int logo_clutsize = 0;
+
+static void die(const char *fmt, ...)
+    __attribute__ ((noreturn)) __attribute ((format (printf, 1, 2)));
+static void usage(void) __attribute ((noreturn));
+
+
+static unsigned int get_number(FILE *fp)
+{
+    int c, val;
+
+    /* Skip leading whitespace */
+    do {
+	c = fgetc(fp);
+	if (c == EOF)
+	    die("%s: end of file\n", filename);
+	if (c == '#') {
+	    /* Ignore comments 'till end of line */
+	    do {
+		c = fgetc(fp);
+		if (c == EOF)
+		    die("%s: end of file\n", filename);
+	    } while (c != '\n');
+	}
+    } while (isspace(c));
+
+    /* Parse decimal number */
+    val = 0;
+    while (isdigit(c)) {
+	val = 10*val+c-'0';
+	c = fgetc(fp);
+	if (c == EOF)
+	    die("%s: end of file\n", filename);
+    }
+    return val;
+}
+
+static unsigned int get_number255(FILE *fp, unsigned int maxval)
+{
+    unsigned int val = get_number(fp);
+    return (255*val+maxval/2)/maxval;
+}
+
+static void read_image(void)
+{
+    FILE *fp;
+    int i, j, magic;
+    unsigned int maxval;
+
+    /* open image file */
+    fp = fopen(filename, "r");
+    if (!fp)
+	die("Cannot open file %s: %s\n", filename, strerror(errno));
+
+    /* check file type and read file header */
+    magic = fgetc(fp);
+    if (magic != 'P')
+	die("%s is not a PNM file\n", filename);
+    magic = fgetc(fp);
+    switch (magic) {
+	case '1':
+	case '2':
+	case '3':
+	    /* Plain PBM/PGM/PPM */
+	    break;
+
+	case '4':
+	case '5':
+	case '6':
+	    /* Binary PBM/PGM/PPM */
+	    die("%s: Binary PNM is not supported\n"
+		"Use pnmnoraw(1) to convert it to ASCII PNM\n", filename);
+
+	default:
+	    die("%s is not a PNM file\n", filename);
+    }
+    logo_width = get_number(fp);
+    logo_height = get_number(fp);
+
+    /* allocate image data */
+    logo_data = (struct color **)malloc(logo_height*sizeof(struct color *));
+    if (!logo_data)
+	die("%s\n", strerror(errno));
+    for (i = 0; i < logo_height; i++) {
+	logo_data[i] = malloc(logo_width*sizeof(struct color));
+	if (!logo_data[i])
+	    die("%s\n", strerror(errno));
+    }
+
+    /* read image data */
+    switch (magic) {
+	case '1':
+	    /* Plain PBM */
+	    for (i = 0; i < logo_height; i++)
+		for (j = 0; j < logo_width; j++)
+		    logo_data[i][j].red = logo_data[i][j].green =
+			logo_data[i][j].blue = 255*(1-get_number(fp));
+	    break;
+
+	case '2':
+	    /* Plain PGM */
+	    maxval = get_number(fp);
+	    for (i = 0; i < logo_height; i++)
+		for (j = 0; j < logo_width; j++)
+		    logo_data[i][j].red = logo_data[i][j].green =
+			logo_data[i][j].blue = get_number255(fp, maxval);
+	    break;
+
+	case '3':
+	    /* Plain PPM */
+	    maxval = get_number(fp);
+	    for (i = 0; i < logo_height; i++)
+		for (j = 0; j < logo_width; j++) {
+		    logo_data[i][j].red = get_number255(fp, maxval);
+		    logo_data[i][j].green = get_number255(fp, maxval);
+		    logo_data[i][j].blue = get_number255(fp, maxval);
+		}
+	    break;
+    }
+
+    /* close file */
+    fclose(fp);
+}
+
+static inline int is_black(struct color c)
+{
+    return c.red == 0 && c.green == 0 && c.blue == 0;
+}
+
+static inline int is_white(struct color c)
+{
+    return c.red == 255 && c.green == 255 && c.blue == 255;
+}
+
+static inline int is_gray(struct color c)
+{
+    return c.red == c.green && c.red == c.blue;
+}
+
+static inline int is_equal(struct color c1, struct color c2)
+{
+    return c1.red == c2.red && c1.green == c2.green && c1.blue == c2.blue;
+}
+
+static void write_header(void)
+{
+    /* open logo file */
+    if (outputname) {
+	out = fopen(outputname, "w");
+	if (!out)
+	    die("Cannot create file %s: %s\n", outputname, strerror(errno));
+    } else {
+	out = stdout;
+    }
+
+    fputs("/*\n", out);
+    fputs(" *  DO NOT EDIT THIS FILE!\n", out);
+    fputs(" *\n", out);
+    fprintf(out, " *  It was automatically generated from %s\n", filename);
+    fputs(" *\n", out);
+    fprintf(out, " *  Linux logo %s\n", logoname);
+    fputs(" */\n\n", out);
+    fputs("#include <linux/linux_logo.h>\n\n", out);
+    fprintf(out, "static const unsigned char %s_data[] __initdata = {\n",
+	    logoname);
+}
+
+static void write_footer(void)
+{
+    fputs("\n};\n\n", out);
+    fprintf(out, "const struct linux_logo %s __initdata = {\n", logoname);
+    fprintf(out, "    .type\t= %s,\n", logo_types[logo_type]);
+    fprintf(out, "    .width\t= %d,\n", logo_width);
+    fprintf(out, "    .height\t= %d,\n", logo_height);
+    if (logo_type == LINUX_LOGO_CLUT224) {
+	fprintf(out, "    .clutsize\t= %d,\n", logo_clutsize);
+	fprintf(out, "    .clut\t= %s_clut,\n", logoname);
+    }
+    fprintf(out, "    .data\t= %s_data\n", logoname);
+    fputs("};\n\n", out);
+
+    /* close logo file */
+    if (outputname)
+	fclose(out);
+}
+
+static int write_hex_cnt = 0;
+
+static void write_hex(unsigned char byte)
+{
+    if (write_hex_cnt % 12)
+	fprintf(out, ", 0x%02x", byte);
+    else if (write_hex_cnt)
+	fprintf(out, ",\n\t0x%02x", byte);
+    else
+	fprintf(out, "\t0x%02x", byte);
+    write_hex_cnt++;
+}
+
+static void write_logo_mono(void)
+{
+    int i, j;
+    unsigned char val, bit;
+
+    /* validate image */
+    for (i = 0; i < logo_height; i++)
+	for (j = 0; j < logo_width; j++)
+	    if (!is_black(logo_data[i][j]) && !is_white(logo_data[i][j]))
+		die("Image must be monochrome\n");
+
+    /* write file header */
+    write_header();
+
+    /* write logo data */
+    for (i = 0; i < logo_height; i++) {
+	for (j = 0; j < logo_width;) {
+	    for (val = 0, bit = 0x80; bit && j < logo_width; j++, bit >>= 1)
+		if (logo_data[i][j].red)
+		    val |= bit;
+	    write_hex(val);
+	}
+    }
+
+    /* write logo structure and file footer */
+    write_footer();
+}
+
+static void write_logo_vga16(void)
+{
+    int i, j, k;
+    unsigned char val;
+
+    /* validate image */
+    for (i = 0; i < logo_height; i++)
+	for (j = 0; j < logo_width; j++) {
+	    for (k = 0; k < 16; k++)
+		if (is_equal(logo_data[i][j], clut_vga16[k]))
+		    break;
+	    if (k == 16)
+		die("Image must use the 16 console colors only\n"
+		    "Use ppmquant(1) -map clut_vga16.ppm to reduce the number "
+		    "of colors\n");
+	}
+
+    /* write file header */
+    write_header();
+
+    /* write logo data */
+    for (i = 0; i < logo_height; i++)
+	for (j = 0; j < logo_width; j++) {
+	    for (k = 0; k < 16; k++)
+		if (is_equal(logo_data[i][j], clut_vga16[k]))
+		    break;
+	    val = k<<4;
+	    if (++j < logo_width) {
+		for (k = 0; k < 16; k++)
+		    if (is_equal(logo_data[i][j], clut_vga16[k]))
+			break;
+		val |= k;
+	    }
+	    write_hex(val);
+	}
+
+    /* write logo structure and file footer */
+    write_footer();
+}
+
+static void write_logo_clut224(void)
+{
+    int i, j, k;
+
+    /* validate image */
+    for (i = 0; i < logo_height; i++)
+	for (j = 0; j < logo_width; j++) {
+	    for (k = 0; k < logo_clutsize; k++)
+		if (is_equal(logo_data[i][j], logo_clut[k]))
+		    break;
+	    if (k == logo_clutsize) {
+		if (logo_clutsize == MAX_LINUX_LOGO_COLORS)
+		    die("Image has more than %d colors\n"
+			"Use ppmquant(1) to reduce the number of colors\n",
+			MAX_LINUX_LOGO_COLORS);
+		logo_clut[logo_clutsize++] = logo_data[i][j];
+	    }
+	}
+
+    /* write file header */
+    write_header();
+
+    /* write logo data */
+    for (i = 0; i < logo_height; i++)
+	for (j = 0; j < logo_width; j++) {
+	    for (k = 0; k < logo_clutsize; k++)
+		if (is_equal(logo_data[i][j], logo_clut[k]))
+		    break;
+	    write_hex(k+32);
+	}
+    fputs("\n};\n\n", out);
+
+    /* write logo clut */
+    fprintf(out, "static const unsigned char %s_clut[] __initdata = {\n",
+	    logoname);
+    write_hex_cnt = 0;
+    for (i = 0; i < logo_clutsize; i++) {
+	write_hex(logo_clut[i].red);
+	write_hex(logo_clut[i].green);
+	write_hex(logo_clut[i].blue);
+    }
+
+    /* write logo structure and file footer */
+    write_footer();
+}
+
+static void write_logo_gray256(void)
+{
+    int i, j;
+
+    /* validate image */
+    for (i = 0; i < logo_height; i++)
+	for (j = 0; j < logo_width; j++)
+	    if (!is_gray(logo_data[i][j]))
+		die("Image must be grayscale\n");
+
+    /* write file header */
+    write_header();
+
+    /* write logo data */
+    for (i = 0; i < logo_height; i++)
+	for (j = 0; j < logo_width; j++)
+	    write_hex(logo_data[i][j].red);
+
+    /* write logo structure and file footer */
+    write_footer();
+}
+
+static void die(const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    vfprintf(stderr, fmt, ap);
+    va_end(ap);
+
+    exit(1);
+}
+
+static void usage(void)
+{
+    die("\n"
+	"Usage: %s [options] <filename>\n"
+	"\n"
+	"Valid options:\n"
+	"    -h          : display this usage information\n"
+	"    -n <name>   : specify logo name (default: linux_logo)\n"
+	"    -o <output> : output to file <output> instead of stdout\n"
+	"    -t <type>   : specify logo type, one of\n"
+	"                      mono    : monochrome black/white\n"
+	"                      vga16   : 16 colors VGA text palette\n"
+	"                      clut224 : 224 colors (default)\n"
+	"                      gray256 : 256 levels grayscale\n"
+	"\n", programname);
+}
+
+int main(int argc, char *argv[])
+{
+    int opt;
+
+    programname = argv[0];
+
+    opterr = 0;
+    while (1) {
+	opt = getopt(argc, argv, "hn:o:t:");
+	if (opt == -1)
+	    break;
+
+	switch (opt) {
+	    case 'h':
+		usage();
+		break;
+
+	    case 'n':
+		logoname = optarg;
+		break;
+
+	    case 'o':
+		outputname = optarg;
+		break;
+
+	    case 't':
+		if (!strcmp(optarg, "mono"))
+		    logo_type = LINUX_LOGO_MONO;
+		else if (!strcmp(optarg, "vga16"))
+		    logo_type = LINUX_LOGO_VGA16;
+		else if (!strcmp(optarg, "clut224"))
+		    logo_type = LINUX_LOGO_CLUT224;
+		else if (!strcmp(optarg, "gray256"))
+		    logo_type = LINUX_LOGO_GRAY256;
+		else
+		    usage();
+		break;
+
+	    default:
+		usage();
+		break;
+	}
+    }
+    if (optind != argc-1)
+	usage();
+
+    filename = argv[optind];
+
+    read_image();
+    switch (logo_type) {
+	case LINUX_LOGO_MONO:
+	    write_logo_mono();
+	    break;
+
+	case LINUX_LOGO_VGA16:
+	    write_logo_vga16();
+	    break;
+
+	case LINUX_LOGO_CLUT224:
+	    write_logo_clut224();
+	    break;
+
+	case LINUX_LOGO_GRAY256:
+	    write_logo_gray256();
+	    break;
+    }
+    exit(0);
+}
+

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

