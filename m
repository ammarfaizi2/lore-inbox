Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263104AbUJ1Xm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbUJ1Xm6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263111AbUJ1Xkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:40:31 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30995 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263086AbUJ1XfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:35:10 -0400
Date: Fri, 29 Oct 2004 01:34:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] video drivers: remove unused functions
Message-ID: <20041028233438.GP3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes some unused function from drivers/video/


diffstat output:
 drivers/video/console/mdacon.c     |   11 -------
 drivers/video/i810/i810_accel.c    |   43 -----------------------------
 drivers/video/intelfb/intelfbdrv.c |   13 --------
 drivers/video/neofb.c              |    5 ---
 drivers/video/pm2fb.c              |    7 ----
 drivers/video/radeonfb.c           |   24 ----------------
 drivers/video/tdfxfb.c             |   35 -----------------------
 drivers/video/tridentfb.c          |    7 ----
 8 files changed, 145 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/drivers/video/console/mdacon.c.old	2004-10-28 23:35:23.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/video/console/mdacon.c	2004-10-28 23:57:57.000000000 +0200
@@ -64,7 +64,6 @@
 
 /* current hardware state */
 
- -static int	mda_origin_loc=-1;
 static int	mda_cursor_loc=-1;
 static int	mda_cursor_size_from=-1;
 static int	mda_cursor_size_to=-1;
@@ -148,16 +147,6 @@
 }
 #endif
 
- -static inline void mda_set_origin(unsigned int location)
- -{
- -	if (mda_origin_loc == location)
- -		return;
- -
- -	write_mda_w(location >> 1, 0x0c);
- -
- -	mda_origin_loc = location;
- -}
- -
 static inline void mda_set_cursor(unsigned int location) 
 {
 	if (mda_cursor_loc == location)
- --- linux-2.6.10-rc1-mm1-full/drivers/video/i810/i810_accel.c.old	2004-10-28 23:41:55.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/video/i810/i810_accel.c	2004-10-28 23:42:08.000000000 +0200
@@ -252,49 +252,6 @@
 	end_iring(par);
 }
 
- -/**
- - * mono_src_copy_blit - color expand from video memory to framebuffer
- - * @dwidth: width of destination
- - * @dheight: height of destination
- - * @dpitch: pixels per line of the buffer
- - * @qsize: size of bitmap in quad words
- - * @dest: address of first byte of pixel;
- - * @rop: raster operation
- - * @blit_bpp: pixelformat to use which can be different from the 
- - *            framebuffer's pixelformat
- - * @src: address of image data
- - * @bg: backgound color
- - * @fg: forground color
- - * @par: pointer to i810fb_par structure
- - *
- - * DESCRIPTION:
- - * A color expand operation where the  source data is in video memory. 
- - * Useful for drawing text. 
- - *
- - * REQUIREMENT:
- - * The end of a scanline must be padded to the next word.
- - */
- -static inline void mono_src_copy_blit(int dwidth, int dheight, int dpitch, 
- -				      int qsize, int blit_bpp, int rop, 
- -				      int dest, int src, int bg,
- -				      int fg, struct fb_info *info)
- -{
- -	struct i810fb_par *par = (struct i810fb_par *) info->par;
- -
- -	if (begin_iring(info, 32 + IRING_PAD)) return;
- -
- -	PUT_RING(BLIT | MONO_SOURCE_COPY_BLIT | 6);
- -	PUT_RING(DYN_COLOR_EN | blit_bpp | rop << 16 | dpitch | 1 << 27);
- -	PUT_RING(dheight << 16 | dwidth);
- -	PUT_RING(dest);
- -	PUT_RING(qsize - 1);
- -	PUT_RING(src);
- -	PUT_RING(bg);
- -	PUT_RING(fg);
- -
- -	end_iring(par);
- -}
- -
 static inline void load_front(int offset, struct fb_info *info)
 {
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
- --- linux-2.6.10-rc1-mm1-full/drivers/video/intelfb/intelfbdrv.c.old	2004-10-28 23:42:43.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/video/intelfb/intelfbdrv.c	2004-10-28 23:42:56.000000000 +0200
@@ -282,19 +282,6 @@
 	return 1;
 }
 
- -static __inline__ int
- -get_opt_int(const char *this_opt, const char *name, int *ret)
- -{
- -	if (!ret)
- -		return 0;
- -
- -	if (!OPT_EQUAL(this_opt, name))
- -		return 0;
- -
- -	*ret = OPT_INTVAL(this_opt, name);
- -	return 1;
- -}
- -
 int __init
 intelfb_setup(char *options)
 {
- --- linux-2.6.10-rc1-mm1-full/drivers/video/neofb.c.old	2004-10-28 23:37:42.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/video/neofb.c	2004-10-28 23:38:32.000000000 +0200
@@ -152,11 +152,6 @@
 };
 #endif
 
- -static inline u32 read_le32(int regindex, const struct neofb_par *par)
- -{
- -	return readl(par->neo2200 + par->cursorOff + regindex);
- -}
- -
 static inline void write_le32(int regindex, u32 val, const struct neofb_par *par)
 {
 	writel(val, par->neo2200 + par->cursorOff + regindex);
- --- linux-2.6.10-rc1-mm1-full/drivers/video/pm2fb.c.old	2004-10-28 23:36:19.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/video/pm2fb.c	2004-10-28 23:36:27.000000000 +0200
@@ -201,13 +201,6 @@
 	pm2_WR(p, index, v);
 }
 
- -inline static u32 pm2v_RDAC_RD(struct pm2fb_par* p, s32 idx)
- -{
- -	pm2_WR(p, PM2VR_RD_INDEX_LOW, idx & 0xff);
- -	mb();
- -	return pm2_RD(p, PM2VR_RD_INDEXED_DATA);
- -}
- -
 inline static void pm2v_RDAC_WR(struct pm2fb_par* p, s32 idx, u32 v)
 {
 	pm2_WR(p, PM2VR_RD_INDEX_LOW, idx & 0xff);
- --- linux-2.6.10-rc1-mm1-full/drivers/video/radeonfb.c.old	2004-10-28 23:36:56.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/video/radeonfb.c	2004-10-28 23:37:15.000000000 +0200
@@ -621,30 +621,6 @@
 #define radeon_engine_reset()		_radeon_engine_reset(rinfo)
 
 
- -static __inline__ u8 radeon_get_post_div_bitval(int post_div)
- -{
- -        switch (post_div) {
- -                case 1:
- -                        return 0x00;
- -                case 2: 
- -                        return 0x01;
- -                case 3: 
- -                        return 0x04;
- -                case 4:
- -                        return 0x02;
- -                case 6:
- -                        return 0x06;
- -                case 8:
- -                        return 0x03;
- -                case 12:
- -                        return 0x07;
- -                default:
- -                        return 0x02;
- -        }
- -}
- -
- -
- -
 static __inline__ int round_div(int num, int den)
 {
         return (num + (den / 2)) / den;
- --- linux-2.6.10-rc1-mm1-full/drivers/video/tdfxfb.c.old	2004-10-28 23:38:56.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/video/tdfxfb.c	2004-10-28 23:40:43.000000000 +0200
@@ -210,41 +210,21 @@
 
 #ifdef VGA_REG_IO 
 static inline  u8 vga_inb(struct tdfx_par *par, u32 reg) { return inb(reg); }
- -static inline u16 vga_inw(struct tdfx_par *par, u32 reg) { return inw(reg); }
- -static inline u16 vga_inl(struct tdfx_par *par, u32 reg) { return inl(reg); }
 
 static inline void vga_outb(struct tdfx_par *par, u32 reg,  u8 val) { outb(val, reg); }
- -static inline void vga_outw(struct tdfx_par *par, u32 reg, u16 val) { outw(val, reg); }
- -static inline void vga_outl(struct tdfx_par *par, u32 reg, u32 val) { outl(val, reg); }
 #else
 static inline  u8 vga_inb(struct tdfx_par *par, u32 reg) { 
 	return inb(par->iobase + reg - 0x300); 
 }
- -static inline u16 vga_inw(struct tdfx_par *par, u32 reg) { 
- -	return inw(par->iobase + reg - 0x300); 
- -}
- -static inline u16 vga_inl(struct tdfx_par *par, u32 reg) { 
- -	return inl(par->iobase + reg - 0x300); 
- -}
 static inline void vga_outb(struct tdfx_par *par, u32 reg,  u8 val) { 
 	outb(val, par->iobase + reg - 0x300); 
 }
- -static inline void vga_outw(struct tdfx_par *par, u32 reg, u16 val) { 
- -	outw(val, par->iobase + reg - 0x300); 
- -}
- -static inline void vga_outl(struct tdfx_par *par, u32 reg, u32 val) { 
- -	outl(val, par->iobase + reg - 0x300); 
- -}
 #endif
 
 static inline void gra_outb(struct tdfx_par *par, u32 idx, u8 val) {
 	vga_outb(par, GRA_I, idx); vga_outb(par, GRA_D, val);
 }
 
- -static inline u8 gra_inb(struct tdfx_par *par, u32 idx) {
- -	vga_outb(par, GRA_I, idx); return vga_inb(par, GRA_D);
- -}
- -
 static inline void seq_outb(struct tdfx_par *par, u32 idx, u8 val) {
 	vga_outb(par, SEQ_I, idx); vga_outb(par, SEQ_D, val);
 }
@@ -270,15 +250,6 @@
 	vga_outb(par, ATT_IW, val);
 }
 
- -static inline u8 att_inb(struct tdfx_par *par, u32 idx) 
- -{
- -	unsigned char tmp;
- -
- -	tmp = vga_inb(par, IS1_R);
- -	vga_outb(par, ATT_IW, idx);
- -	return vga_inb(par, ATT_IW);
- -}
- -
 static inline void vga_disable_video(struct tdfx_par *par)
 {
 	unsigned char s;
@@ -299,12 +270,6 @@
 	seq_outb(par, 0x00, 0x03);
 }
 
- -static inline void vga_disable_palette(struct tdfx_par *par)
- -{
- -	vga_inb(par, IS1_R);
- -	vga_outb(par, ATT_IW, 0x00);
- -}
- -
 static inline void vga_enable_palette(struct tdfx_par *par)
 {
 	vga_inb(par, IS1_R);
- --- linux-2.6.10-rc1-mm1-full/drivers/video/tridentfb.c.old	2004-10-28 23:41:13.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/video/tridentfb.c	2004-10-28 23:41:26.000000000 +0200
@@ -523,13 +523,6 @@
 	t_outb(val, 0x3C0);
 }
 
- -static inline unsigned char readAttr(int reg)
- -{
- -	readb(((struct tridentfb_par *)fb_info.par)->io_virt + CRT + 0x0A);	//flip-flop to index
- -	t_outb(reg, 0x3C0);
- -	return t_inb(0x3C1);
- -}
- -
 static inline void write3CE(int reg, unsigned char val)
 {
 	t_outb(reg, 0x3CE);

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgYIOmfzqmE8StAARAp8UAKC+w2vy4O1QIWWuHMvPzadAiyEu1QCghr0t
LHwWP43hhWMKH9pM8/MOKBc=
=oNss
-----END PGP SIGNATURE-----
