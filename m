Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937711AbWLFWMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937711AbWLFWMX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 17:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937713AbWLFWMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 17:12:23 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52956 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937711AbWLFWMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 17:12:22 -0500
Date: Wed, 6 Dec 2006 23:12:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: [PATCH] ARM: OMAP: omap1501->15xx conversions needed for sx1, non-core
Message-ID: <20061206221212.GA2028@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Ananiev <vovan888@gmail.com>

Convert 1501->15xx in drivers omap code, so that sx1 can work.

Signed-off-by: Pavel Machek <pavel@suse.cz>

index 9c02177..46ac407 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -227,7 +227,7 @@ #endif
 
 	omap_ohci_clock_power(1);
 
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		omap_1510_local_bus_power(1);
 		omap_1510_local_bus_init();
 	}
@@ -315,7 +315,7 @@ static int usb_hcd_omap_probe (const str
 	if (IS_ERR(usb_host_ck))
 		return PTR_ERR(usb_host_ck);
 
-	if (!cpu_is_omap1510())
+	if (!cpu_is_omap15xx())
 		usb_dc_ck = clk_get(0, "usb_dc_ck");
 	else
 		usb_dc_ck = clk_get(0, "lb_ck");
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index f658698..b2dce7b 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -459,7 +459,7 @@ static int set_fb_var(struct fb_info *fb
 		xres_max = panel->x_res;
 		yres_min = OMAPFB_PLANE_YRES_MIN;
 		yres_max = panel->y_res;
-		if (cpu_is_omap1510()) {
+		if (cpu_is_omap15xx()) {
 			var->xres = panel->x_res;
 			var->yres = panel->y_res;
 		}
@@ -470,7 +470,7 @@ static int set_fb_var(struct fb_info *fb
 		xres_max = panel->y_res;
 		yres_min = OMAPFB_PLANE_XRES_MIN;
 		yres_max = panel->x_res;
-		if (cpu_is_omap1510()) {
+		if (cpu_is_omap15xx()) {
 			var->xres = panel->y_res;
 			var->yres = panel->x_res;
 		}
@@ -552,7 +552,7 @@ static struct fb_var_screeninfo new_var;
 /* Set rotation (0, 90, 180, 270 degree), and switch to the new mode. */
 static void omapfb_rotate(struct fb_info *fbi, int rotate)
 {
-	if (cpu_is_omap1510() && rotate != fbi->var.rotate) {
+	if (cpu_is_omap15xx() && rotate != fbi->var.rotate) {
 		memcpy(&new_var, &fbi->var, sizeof(new_var));
 		new_var.rotate = rotate;
 		if (set_fb_var(fbi, &new_var) == 0 &&
@@ -594,7 +594,7 @@ static int omapfb_mirror(struct fb_info 
 	int r = 0;
 
 	mirror = mirror ? 1 : 0;
-	if (cpu_is_omap1510())
+	if (cpu_is_omap15xx())
 		r = -EINVAL;
 	else if (mirror != plane->info.mirror) {
 		plane->info.mirror = mirror;
diff --git a/sound/oss/omap-audio-dma-intfc.c b/sound/oss/omap-audio-dma-intfc.c
index 3974efc..146e288 100644
--- a/sound/oss/omap-audio-dma-intfc.c
+++ b/sound/oss/omap-audio-dma-intfc.c
@@ -312,7 +312,7 @@ omap_request_sound_dma(int device_id, co
 	}
 
 	/* Chain the channels together */
-	if (!cpu_is_omap1510())
+	if (!cpu_is_omap15xx())
 		omap_sound_dma_link_lch(data);
 
 	spin_unlock(&dma_list_lock);
@@ -362,7 +362,7 @@ int omap_free_sound_dma(void *data, int 
 	}
 	chan = (*channels);
 
-	if (!cpu_is_omap1510())
+	if (!cpu_is_omap15xx())
 		omap_sound_dma_unlink_lch(data);
 	for (i = 0; i < nr_linked_channels; i++) {
 		int cur_chan = chan[i];
@@ -555,7 +555,7 @@ int audio_sync(struct file *file)
 		 * to complete. So it's need to unlink dma channels
 		 * to avoid empty dma work.
 		 */
-		if (!cpu_is_omap1510() && AUDIO_QUEUE_EMPTY(s))
+		if (!cpu_is_omap15xx() && AUDIO_QUEUE_EMPTY(s))
 			omap_sound_dma_unlink_lch(s);
 
 		shiftval = s->fragsize - b->offset;
@@ -699,7 +699,7 @@ static int audio_set_dma_params_play(int
 
 	FN_IN;
 
-	if (cpu_is_omap1510() || cpu_is_omap16xx()) {
+	if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
 		dest_start = AUDIO_MCBSP_DATAWRITE;
 		dest_port = OMAP_DMA_PORT_MPUI;
 	}
@@ -729,7 +729,7 @@ static int audio_set_dma_params_capture(
 
 	FN_IN;
 
-	if (cpu_is_omap1510() || cpu_is_omap16xx()) {
+	if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
 		src_start = AUDIO_MCBSP_DATAREAD;
 		src_port = OMAP_DMA_PORT_MPUI;
 	}
@@ -871,7 +871,7 @@ #endif
 		ch_status, dma_status, data);
 
 	if (dma_status & (DCSR_ERROR)) {
-		if (cpu_is_omap1510() || cpu_is_omap16xx())
+		if (cpu_is_omap15xx() || cpu_is_omap16xx())
 			OMAP_DMA_CCR_REG(sound_curr_lch) &= ~DCCR_EN;
 		ERR("DCSR_ERROR!\n");
 		FN_OUT(-1);
@@ -952,7 +952,7 @@ dma_callback_t audio_get_dma_callback(vo
 
 static int __init audio_dma_init(void)
 {
-	if (!cpu_is_omap1510())
+	if (!cpu_is_omap15xx())
 		nr_linked_channels = 2;
 
 	return 0;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
