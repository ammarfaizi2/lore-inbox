Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269112AbUIRDtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269112AbUIRDtr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 23:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269116AbUIRDsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 23:48:11 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:63113 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S269112AbUIRDri
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 23:47:38 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/5] fbdev: Add iomem annotations to i810fb
Date: Sat, 18 Sep 2004 11:48:04 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200409181139.55347.adaplas@hotpop.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add iomem annotations to i810fb.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 i810.h       |    4 +-
 i810_accel.c |   14 +++++-----
 i810_gtf.c   |    3 +-
 i810_main.c  |   81 +++++++++++++++++++++++++++++++++--------------------------
 4 files changed, 57 insertions(+), 45 deletions(-)

diff -uprN linux-2.6.9-rc2-mm1-orig/drivers/video/i810/i810_accel.c linux-2.6.9-rc2-mm1/drivers/video/i810/i810_accel.c
--- linux-2.6.9-rc2-mm1-orig/drivers/video/i810/i810_accel.c	2004-05-10 10:32:00.000000000 +0800
+++ linux-2.6.9-rc2-mm1/drivers/video/i810/i810_accel.c	2004-09-18 10:35:19.053730672 +0800
@@ -32,7 +32,7 @@ extern void flush_cache(void);
 /************************************************************/
 
 /* BLT Engine Routines */
-static inline void i810_report_error(u8 *mmio)
+static inline void i810_report_error(u8 __iomem *mmio)
 {
 	printk("IIR     : 0x%04x\n"
 	       "EIR     : 0x%04x\n"
@@ -59,7 +59,7 @@ static inline int wait_for_space(struct 
 {
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
 	u32 head, count = WAIT_COUNT, tail;
-	u8 *mmio = par->mmio_start_virtual;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	tail = par->cur_tail;
 	while (count--) {
@@ -89,7 +89,7 @@ static inline int wait_for_space(struct 
 static inline int wait_for_engine_idle(struct fb_info *info)
 {
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
-	u8 *mmio = par->mmio_start_virtual;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 	int count = WAIT_COUNT;
 
 	if (wait_for_space(info, par->iring.size)) /* flush */
@@ -133,7 +133,7 @@ static inline u32 begin_iring(struct fb_
  */
 static inline void end_iring(struct i810fb_par *par)
 {
-	u8 *mmio = par->mmio_start_virtual;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	i810_writel(IRING, mmio, par->cur_tail);
 }
@@ -326,7 +326,7 @@ static inline void load_front(int offset
 static inline void i810fb_iring_enable(struct i810fb_par *par, u32 mode)
 {
 	u32 tmp;
-	u8 *mmio = par->mmio_start_virtual;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	tmp = i810_readl(IRING + 12, mmio);
 	if (mode == OFF) 
@@ -451,7 +451,7 @@ int i810fb_sync(struct fb_info *info)
 void i810fb_load_front(u32 offset, struct fb_info *info)
 {
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
-	u8 *mmio = par->mmio_start_virtual;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	if (!info->var.accel_flags || par->dev_flags & LOCKUP)
 		i810_writel(DPLYBASE, mmio, par->fb.physical + offset);
@@ -472,7 +472,7 @@ void i810fb_init_ringbuffer(struct fb_in
 {
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
 	u32 tmp1, tmp2;
-	u8 *mmio = par->mmio_start_virtual;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 	
 	wait_for_engine_idle(info);
 	i810fb_iring_enable(par, OFF);
diff -uprN linux-2.6.9-rc2-mm1-orig/drivers/video/i810/i810_gtf.c linux-2.6.9-rc2-mm1/drivers/video/i810/i810_gtf.c
--- linux-2.6.9-rc2-mm1-orig/drivers/video/i810/i810_gtf.c	2004-09-15 10:57:06.000000000 +0800
+++ linux-2.6.9-rc2-mm1/drivers/video/i810/i810_gtf.c	2004-09-18 10:35:27.897386232 +0800
@@ -124,7 +124,8 @@ void i810fb_encode_registers(const struc
 			     struct i810fb_par *par, u32 xres, u32 yres)
 {
 	int n, blank_s, blank_e;
-	u8 *mmio = par->mmio_start_virtual, msr = 0;
+	u8 __iomem *mmio = par->mmio_start_virtual;
+	u8 msr = 0;
 
 	/* Horizontal */
 	/* htotal */
diff -uprN linux-2.6.9-rc2-mm1-orig/drivers/video/i810/i810.h linux-2.6.9-rc2-mm1/drivers/video/i810/i810.h
--- linux-2.6.9-rc2-mm1-orig/drivers/video/i810/i810.h	2004-05-10 10:33:19.000000000 +0800
+++ linux-2.6.9-rc2-mm1/drivers/video/i810/i810.h	2004-09-18 10:35:12.094788592 +0800
@@ -222,7 +222,7 @@ struct mode_registers {
 
 struct heap_data {
         unsigned long physical;
-	__u8 *virtual;
+	__u8 __iomem *virtual;
 	u32 offset;
 	u32 size;
 };	
@@ -256,7 +256,7 @@ struct i810fb_par {
 	u32 pseudo_palette[17];
 	u32 pci_state[16];
 	unsigned long mmio_start_phys;
-	u8 *mmio_start_virtual;
+	u8 __iomem *mmio_start_virtual;
 	u32 pitch;
 	u32 pixconf;
 	u32 watermark;
diff -uprN linux-2.6.9-rc2-mm1-orig/drivers/video/i810/i810_main.c linux-2.6.9-rc2-mm1/drivers/video/i810/i810_main.c
--- linux-2.6.9-rc2-mm1-orig/drivers/video/i810/i810_main.c	2004-09-16 19:40:05.000000000 +0800
+++ linux-2.6.9-rc2-mm1/drivers/video/i810/i810_main.c	2004-09-18 10:35:34.669356736 +0800
@@ -121,7 +121,7 @@ static int dcolor     __initdata = 0;
  * DESCRIPTION:
  * Blanks/unblanks the display
  */
-static void i810_screen_off(u8 *mmio, u8 mode)
+static void i810_screen_off(u8 __iomem *mmio, u8 mode)
 {
 	u32 count = WAIT_COUNT;
 	u8 val;
@@ -145,7 +145,7 @@ static void i810_screen_off(u8 *mmio, u8
  * Turns off DRAM refresh.  Must be off for only 2 vsyncs
  * before data becomes corrupt
  */
-static void i810_dram_off(u8 *mmio, u8 mode)
+static void i810_dram_off(u8 __iomem *mmio, u8 mode)
 {
 	u8 val;
 
@@ -164,7 +164,7 @@ static void i810_dram_off(u8 *mmio, u8 m
  * The IBM VGA standard allows protection of certain VGA registers.  
  * This will  protect or unprotect them. 
  */
-static void i810_protect_regs(u8 *mmio, int mode)
+static void i810_protect_regs(u8 __iomem *mmio, int mode)
 {
 	u8 reg;
 
@@ -187,7 +187,7 @@ static void i810_protect_regs(u8 *mmio, 
 static void i810_load_pll(struct i810fb_par *par)
 {
 	u32 tmp1, tmp2;
-	u8 *mmio = par->mmio_start_virtual;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 	
 	tmp1 = par->regs.M | par->regs.N << 16;
 	tmp2 = i810_readl(DCLK_2D, mmio);
@@ -212,7 +212,7 @@ static void i810_load_pll(struct i810fb_
  */
 static void i810_load_vga(struct i810fb_par *par)
 {	
-	u8 *mmio = par->mmio_start_virtual;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	/* interlace */
 	i810_writeb(CR_INDEX_CGA, mmio, CR70);
@@ -255,7 +255,7 @@ static void i810_load_vga(struct i810fb_
  */
 static void i810_load_vgax(struct i810fb_par *par)
 {
-	u8 *mmio = par->mmio_start_virtual;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	i810_writeb(CR_INDEX_CGA, mmio, CR30);
 	i810_writeb(CR_DATA_CGA, mmio, par->regs.cr30);
@@ -281,7 +281,8 @@ static void i810_load_vgax(struct i810fb
 static void i810_load_2d(struct i810fb_par *par)
 {
 	u32 tmp;
-	u8 tmp8, *mmio = par->mmio_start_virtual;
+	u8 tmp8;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 
   	i810_writel(FW_BLC, mmio, par->watermark); 
 	tmp = i810_readl(PIXCONF, mmio);
@@ -301,7 +302,7 @@ static void i810_load_2d(struct i810fb_p
  * i810_hires - enables high resolution mode
  * @mmio: address of register space
  */
-static void i810_hires(u8 *mmio)
+static void i810_hires(u8 __iomem *mmio)
 {
 	u8 val;
 	
@@ -321,7 +322,8 @@ static void i810_hires(u8 *mmio)
 static void i810_load_pitch(struct i810fb_par *par)
 {
 	u32 tmp, pitch;
-	u8 val, *mmio = par->mmio_start_virtual;
+	u8 val;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 			
 	pitch = par->pitch >> 3;
 	i810_writeb(SR_INDEX, mmio, SR01);
@@ -351,9 +353,10 @@ static void i810_load_pitch(struct i810f
  */
 static void i810_load_color(struct i810fb_par *par)
 {
-	u8 *mmio = par->mmio_start_virtual;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 	u32 reg1;
 	u16 reg2;
+
 	reg1 = i810_readl(PIXCONF, mmio) & ~(0xF0000 | 1 << 27);
 	reg2 = i810_readw(BLTCNTL, mmio) & ~0x30;
 
@@ -372,7 +375,7 @@ static void i810_load_color(struct i810f
  */
 static void i810_load_regs(struct i810fb_par *par)
 {
-	u8 *mmio = par->mmio_start_virtual;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	i810_screen_off(mmio, OFF);
 	i810_protect_regs(mmio, OFF);
@@ -390,7 +393,7 @@ static void i810_load_regs(struct i810fb
 }
 
 static void i810_write_dac(u8 regno, u8 red, u8 green, u8 blue,
-			  u8 *mmio)
+			  u8 __iomem *mmio)
 {
 	i810_writeb(CLUT_INDEX_WRITE, mmio, regno);
 	i810_writeb(CLUT_DATA, mmio, red);
@@ -399,7 +402,7 @@ static void i810_write_dac(u8 regno, u8 
 }
 
 static void i810_read_dac(u8 regno, u8 *red, u8 *green, u8 *blue,
-			  u8 *mmio)
+			  u8 __iomem *mmio)
 {
 	i810_writeb(CLUT_INDEX_READ, mmio, regno);
 	*red = i810_readb(CLUT_DATA, mmio);
@@ -413,7 +416,7 @@ static void i810_read_dac(u8 regno, u8 *
 static void i810_restore_pll(struct i810fb_par *par)
 {
 	u32 tmp1, tmp2;
-	u8 *mmio = par->mmio_start_virtual;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 	
 	tmp1 = par->hw_state.dclk_2d;
 	tmp2 = i810_readl(DCLK_2D, mmio);
@@ -433,7 +436,7 @@ static void i810_restore_pll(struct i810
 static void i810_restore_dac(struct i810fb_par *par)
 {
 	u32 tmp1, tmp2;
-	u8 *mmio = par->mmio_start_virtual;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	tmp1 = par->hw_state.pixconf;
 	tmp2 = i810_readl(PIXCONF, mmio);
@@ -444,7 +447,8 @@ static void i810_restore_dac(struct i810
 
 static void i810_restore_vgax(struct i810fb_par *par)
 {
-	u8 i, j, *mmio = par->mmio_start_virtual;
+	u8 i, j;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 	
 	for (i = 0; i < 4; i++) {
 		i810_writeb(CR_INDEX_CGA, mmio, CR30+i);
@@ -477,7 +481,8 @@ static void i810_restore_vgax(struct i81
 
 static void i810_restore_vga(struct i810fb_par *par)
 {
-	u8 i, *mmio = par->mmio_start_virtual;
+	u8 i;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 	
 	for (i = 0; i < 10; i++) {
 		i810_writeb(CR_INDEX_CGA, mmio, CR00 + i);
@@ -491,7 +496,8 @@ static void i810_restore_vga(struct i810
 
 static void i810_restore_addr_map(struct i810fb_par *par)
 {
-	u8 tmp, *mmio = par->mmio_start_virtual;
+	u8 tmp;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	i810_writeb(GR_INDEX, mmio, GR10);
 	tmp = i810_readb(GR_DATA, mmio);
@@ -505,7 +511,7 @@ static void i810_restore_2d(struct i810f
 {
 	u32 tmp_long;
 	u16 tmp_word;
-	u8 *mmio = par->mmio_start_virtual;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	tmp_word = i810_readw(BLTCNTL, mmio);
 	tmp_word &= ~(3 << 4); 
@@ -534,7 +540,7 @@ static void i810_restore_2d(struct i810f
 
 static void i810_restore_vga_state(struct i810fb_par *par)
 {
-	u8 *mmio = par->mmio_start_virtual;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	i810_screen_off(mmio, OFF);
 	i810_protect_regs(mmio, OFF);
@@ -556,7 +562,8 @@ static void i810_restore_vga_state(struc
 
 static void i810_save_vgax(struct i810fb_par *par)
 {
-	u8 i, *mmio = par->mmio_start_virtual;
+	u8 i;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	for (i = 0; i < 4; i++) {
 		i810_writeb(CR_INDEX_CGA, mmio, CR30 + i);
@@ -579,7 +586,8 @@ static void i810_save_vgax(struct i810fb
 
 static void i810_save_vga(struct i810fb_par *par)
 {
-	u8 i, *mmio = par->mmio_start_virtual;
+	u8 i;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	for (i = 0; i < 10; i++) {
 		i810_writeb(CR_INDEX_CGA, mmio, CR00 + i);
@@ -593,7 +601,7 @@ static void i810_save_vga(struct i810fb_
 
 static void i810_save_2d(struct i810fb_par *par)
 {
-	u8 *mmio = par->mmio_start_virtual;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	par->hw_state.dclk_2d = i810_readl(DCLK_2D, mmio);
 	par->hw_state.dclk_1d = i810_readl(DCLK_1D, mmio);
@@ -716,7 +724,7 @@ static void i810_calc_dclk(u32 freq, u32
  * Description:
  * Shows or hides the hardware cursor
  */
-void i810_enable_cursor(u8 *mmio, int mode)
+void i810_enable_cursor(u8 __iomem *mmio, int mode)
 {
 	u32 temp;
 	
@@ -729,7 +737,7 @@ void i810_enable_cursor(u8 *mmio, int mo
 
 static void i810_reset_cursor_image(struct i810fb_par *par)
 {
-	u8 *addr = par->cursor_heap.virtual;
+	u8 __iomem *addr = par->cursor_heap.virtual;
 	int i, j;
 
 	for (i = 64; i--; ) {
@@ -744,7 +752,7 @@ static void i810_reset_cursor_image(stru
 static void i810_load_cursor_image(int width, int height, u8 *data,
 				   struct i810fb_par *par)
 {
-	u8 *addr = par->cursor_heap.virtual;
+	u8 __iomem *addr = par->cursor_heap.virtual;
 	int i, j, w = width/8;
 	int mod = width % 8, t_mask, d_mask;
 	
@@ -766,8 +774,8 @@ static void i810_load_cursor_image(int w
 static void i810_load_cursor_colors(int fg, int bg, struct fb_info *info)
 {
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
-	u8 *mmio = par->mmio_start_virtual, temp;
-	u8 red, green, blue, trans;
+	u8 __iomem *mmio = par->mmio_start_virtual;
+	u8 red, green, blue, trans, temp;
 
 	i810fb_getcolreg(bg, &red, &green, &blue, &trans, info);
 
@@ -796,7 +804,7 @@ static void i810_load_cursor_colors(int 
  */
 static void i810_init_cursor(struct i810fb_par *par)
 {
-	u8 *mmio = par->mmio_start_virtual;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	i810_enable_cursor(mmio, OFF);
 	i810_writel(CURBASE, mmio, par->cursor_heap.physical);
@@ -1124,7 +1132,8 @@ static int i810fb_getcolreg(u8 regno, u8
 			    u8 *transp, struct fb_info *info)
 {
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
-	u8 *mmio = par->mmio_start_virtual, temp;
+	u8 __iomem *mmio = par->mmio_start_virtual;
+	u8 temp;
 
 	if (info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
 		if ((info->var.green.length == 5 && regno > 31) ||
@@ -1167,7 +1176,7 @@ static int i810fb_open(struct fb_info *i
 	if (count == 0) {
 		memset(&par->state, 0, sizeof(struct vgastate));
 		par->state.flags = VGA_SAVE_CMAP;
-		par->state.vgabase = (caddr_t) par->mmio_start_virtual;
+		par->state.vgabase = par->mmio_start_virtual;
 		save_vga(&par->state);
 
 		i810_save_vga_state(par);
@@ -1203,7 +1212,8 @@ static int i810fb_setcolreg(unsigned reg
 			    struct fb_info *info)
 {
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
-	u8 *mmio = par->mmio_start_virtual, temp;
+	u8 __iomem *mmio = par->mmio_start_virtual;
+	u8 temp;
 	int i;
 
  	if (regno > 255) return 1;
@@ -1308,7 +1318,7 @@ static int i810fb_pan_display(struct fb_
 static int i810fb_blank (int blank_mode, struct fb_info *info)
 {
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
-	u8 *mmio = par->mmio_start_virtual;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 	int mode = 0, pwr, scr_off = 0;
 	
 	pwr = i810_readl(PWR_CLKC, mmio);
@@ -1391,7 +1401,7 @@ static int i810fb_check_var(struct fb_va
 static int i810fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct i810fb_par *par = (struct i810fb_par *)info->par;
-	u8 *mmio = par->mmio_start_virtual;	
+	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	if (!info->var.accel_flags || par->dev_flags & LOCKUP) 
 		return soft_cursor(info, cursor);
@@ -1724,7 +1734,8 @@ static void __devinit i810_init_defaults
  */
 static void __devinit i810_init_device(struct i810fb_par *par)
 {
-	u8 reg, *mmio = par->mmio_start_virtual;
+	u8 reg;
+	u8 __iomem *mmio = par->mmio_start_virtual;
 
 	if (mtrr) set_mtrr(par);
 


