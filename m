Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbUJ0JQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbUJ0JQj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 05:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbUJ0JQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 05:16:37 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:1231 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262331AbUJ0JPL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:15:11 -0400
Subject: [PATCH] fbcon: Remove spurious casts
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: jsimmons@infradead.org, geert@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Date: Wed, 27 Oct 2004 12:16:03 +0300
Message-Id: <1098868564.9299.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch removes unnecessary casts from drivers/video/console/fbcon.c.
Assignment from a void pointer does not require a cast and char type is
promoted to int automatically.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fbcon.c |   82 ++++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 41 insertions(+), 41 deletions(-)

Index: 2.6.10-rc1-bk1/drivers/video/console/fbcon.c
===================================================================
--- 2.6.10-rc1-bk1.orig/drivers/video/console/fbcon.c	2004-10-24 10:58:15.000000000 +0300
+++ 2.6.10-rc1-bk1/drivers/video/console/fbcon.c	2004-10-27 11:27:27.693508136 +0300
@@ -234,8 +234,8 @@
 
 static void fb_flashcursor(void *private)
 {
-	struct fb_info *info = (struct fb_info *) private;
-	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+	struct fb_info *info = private;
+	struct fbcon_ops *ops = info->fbcon_par;
 	struct display *p;
 	struct vc_data *vc = NULL;
 	int c;
@@ -247,7 +247,7 @@
 	if (info->state != FBINFO_STATE_RUNNING ||
 	    !vc || !CON_IS_VISIBLE(vc) || !info->cursor.flash ||
 	    vt_cons[vc->vc_num]->vc_mode != KD_TEXT ||
- 	    registered_fb[(int) con2fb_map[vc->vc_num]] != info)
+ 	    registered_fb[con2fb_map[vc->vc_num]] != info)
 		return;
 	p = &fb_display[vc->vc_num];
 	c = scr_readw((u16 *) vc->vc_pos);
@@ -460,7 +460,7 @@
 static void set_blitting_type(struct vc_data *vc, struct fb_info *info,
 			      struct display *p)
 {
-	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+	struct fbcon_ops *ops = info->fbcon_par;
 
 	if ((info->flags & FBINFO_MISC_TILEBLITTING))
 		fbcon_set_tileops(vc, info, p, ops);
@@ -471,7 +471,7 @@
 static void set_blitting_type(struct vc_data *vc, struct fb_info *info,
 			      struct display *p)
 {
-	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+	struct fbcon_ops *ops = info->fbcon_par;
 
 	info->flags &= ~FBINFO_MISC_TILEBLITTING;
 	fbcon_set_bitops(ops);
@@ -594,7 +594,7 @@
 
 	if (fg_console == 0 && !user && logo_shown != -3) {
 		struct vc_data *vc = vc_cons[fg_console].d;
-		struct fb_info *fg_info = registered_fb[(int) con2fb_map[fg_console]];
+		struct fb_info *fg_info = registered_fb[con2fb_map[fg_console]];
 
 		fbcon_prepare_logo(vc, fg_info, vc->vc_cols, vc->vc_rows,
 				   vc->vc_cols, vc->vc_rows);
@@ -817,7 +817,7 @@
 
 static void fbcon_init(struct vc_data *vc, int init)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct vc_data **default_mode = vc->vc_display_fg;
 	struct vc_data *svc = *default_mode;
 	struct display *t, *p = &fb_display[vc->vc_num];
@@ -957,8 +957,8 @@
 static void fbcon_clear(struct vc_data *vc, int sy, int sx, int height,
 			int width)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fbcon_ops *ops = info->fbcon_par;
 
 	struct display *p = &fb_display[vc->vc_num];
 	u_int y_break;
@@ -986,9 +986,9 @@
 static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
 			int count, int ypos, int xpos)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
-	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+	struct fbcon_ops *ops = info->fbcon_par;
 
 	if (!info->fbops->fb_blank && console_blanked)
 		return;
@@ -1010,16 +1010,16 @@
 
 static void fbcon_clear_margins(struct vc_data *vc, int bottom_only)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fbcon_ops *ops = info->fbcon_par;
 
 	ops->clear_margins(vc, info, bottom_only);
 }
 
 static void fbcon_cursor(struct vc_data *vc, int mode)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fbcon_ops *ops = info->fbcon_par;
 	struct display *p = &fb_display[vc->vc_num];
 	int y = real_y(p, vc->vc_y);
  	int c = scr_readw((u16 *) vc->vc_pos);
@@ -1132,7 +1132,7 @@
 
 static __inline__ void ywrap_up(struct vc_data *vc, int count)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
 	
 	p->yscroll += count;
@@ -1150,7 +1150,7 @@
 
 static __inline__ void ywrap_down(struct vc_data *vc, int count)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
 	
 	p->yscroll -= count;
@@ -1168,9 +1168,9 @@
 
 static __inline__ void ypan_up(struct vc_data *vc, int count)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
-	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+	struct fbcon_ops *ops = info->fbcon_par;
 
 	p->yscroll += count;
 	if (p->yscroll > p->vrows - vc->vc_rows) {
@@ -1191,7 +1191,7 @@
 
 static __inline__ void ypan_up_redraw(struct vc_data *vc, int t, int count)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
 	int redraw = 0;
 
@@ -1216,9 +1216,9 @@
 
 static __inline__ void ypan_down(struct vc_data *vc, int count)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
-	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+	struct fbcon_ops *ops = info->fbcon_par;
 	
 	p->yscroll -= count;
 	if (p->yscroll < 0) {
@@ -1239,7 +1239,7 @@
 
 static __inline__ void ypan_down_redraw(struct vc_data *vc, int t, int count)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
 	int redraw = 0;
 
@@ -1471,9 +1471,9 @@
 static int fbcon_scroll(struct vc_data *vc, int t, int b, int dir,
 			int count)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
-	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+	struct fbcon_ops *ops = info->fbcon_par;
 	int scroll_partial = info->flags & FBINFO_PARTIAL_PAN_OK;
 
 	if (!info->fbops->fb_blank && console_blanked)
@@ -1666,7 +1666,7 @@
 static void fbcon_bmove(struct vc_data *vc, int sy, int sx, int dy, int dx,
 			int height, int width)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
 	
 	if (!info->fbops->fb_blank && console_blanked)
@@ -1689,8 +1689,8 @@
 static void fbcon_bmove_rec(struct vc_data *vc, struct display *p, int sy, int sx, 
 			    int dy, int dx, int height, int width, u_int y_break)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fbcon_ops *ops = info->fbcon_par;
 	u_int b;
 
 	if (sy < y_break && sy + height > y_break) {
@@ -1767,7 +1767,7 @@
 static int fbcon_resize(struct vc_data *vc, unsigned int width, 
 			unsigned int height)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
 	struct fb_var_screeninfo var = info->var;
 	int x_diff, y_diff;
@@ -1824,7 +1824,7 @@
 	struct fb_var_screeninfo var;
 	int i, prev_console, do_set_par = 0;
 
-	info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	info = registered_fb[con2fb_map[vc->vc_num]];
 	if (softback_top) {
 		int l = fbcon_softback_size / vc->vc_size_row;
 		if (softback_lines)
@@ -1877,7 +1877,7 @@
 	fb_set_var(info, &var);
 
 	if (prev_console != -1 &&
-	    registered_fb[(int) con2fb_map[prev_console]] != info)
+	    registered_fb[con2fb_map[prev_console]] != info)
 		do_set_par = 1;
 
 	if (do_set_par || info->flags & FBINFO_MISC_MODESWITCH) {
@@ -1931,7 +1931,7 @@
 static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
 {
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
 
 	if (mode_switch) {
@@ -2049,7 +2049,7 @@
 static int fbcon_do_set_font(struct vc_data *vc, int w, int h,
 			     u8 * data, int userfont)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
 	int resize;
 	int cnt;
@@ -2261,7 +2261,7 @@
 
 static int fbcon_set_def_font(struct vc_data *vc, struct console_font *font, char *name)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct font_desc *f;
 
 	if (!name)
@@ -2284,7 +2284,7 @@
 
 static int fbcon_set_palette(struct vc_data *vc, unsigned char *table)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	int i, j, k, depth;
 	u8 val;
 
@@ -2393,7 +2393,7 @@
 
 static int fbcon_scrolldelta(struct vc_data *vc, int lines)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[fg_console]];
+	struct fb_info *info = registered_fb[con2fb_map[fg_console]];
 	struct display *p = &fb_display[fg_console];
 	int offset, limit, scrollback_old;
 
@@ -2555,7 +2555,7 @@
 
 	/* before deletion, ensure that mode is not in use */
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
-		j = (int) con2fb_map[i];
+		j = con2fb_map[i];
 		if (j == -1)
 			continue;
 		fb_info = registered_fb[j];
@@ -2598,7 +2598,7 @@
 static int fbcon_event_notify(struct notifier_block *self, 
 			      unsigned long action, void *data)
 {
-	struct fb_event *event = (struct fb_event *) data;
+	struct fb_event *event = data;
 	struct fb_info *info = event->info;
 	struct fb_videomode *mode;
 	struct fb_con2fbmap *con2fb;
@@ -2615,19 +2615,19 @@
 		fbcon_modechanged(info);
 		break;
 	case FB_EVENT_MODE_DELETE:
-		mode = (struct fb_videomode *) event->data;
+		mode = event->data;
 		ret = fbcon_mode_deleted(info, mode);
 		break;
 	case FB_EVENT_FB_REGISTERED:
 		ret = fbcon_fb_registered(info->node);
 		break;
 	case FB_EVENT_SET_CONSOLE_MAP:
-		con2fb = (struct fb_con2fbmap *) event->data;
+		con2fb = event->data;
 		ret = set_con2fb_map(con2fb->console - 1,
 				     con2fb->framebuffer, 1);
 		break;
 	case FB_EVENT_GET_CONSOLE_MAP:
-		con2fb = (struct fb_con2fbmap *) event->data;
+		con2fb = event->data;
 		con2fb->framebuffer = con2fb_map[con2fb->console - 1];
 		break;
 	}


