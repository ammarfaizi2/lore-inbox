Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263187AbUKTVUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbUKTVUi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 16:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUKTVTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 16:19:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30984 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261718AbUKTVSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 16:18:24 -0500
Date: Sat, 20 Nov 2004 22:18:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small ftape cleanups (fwd)
Message-ID: <20041120211821.GE2829@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm2.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sat, 6 Nov 2004 23:24:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small ftape cleanups

The patch below does cleanups under drivers/char/rio/ including the 
following:
- remove some completely unused code
- make some needlessly global code static


diffstat output:
 drivers/char/ftape/compressor/zftape-compress.c |    4 
 drivers/char/ftape/lowlevel/fc-10.c             |    4 
 drivers/char/ftape/lowlevel/fdc-io.c            |   67 ++--------------
 drivers/char/ftape/lowlevel/fdc-io.h            |    5 -
 drivers/char/ftape/lowlevel/ftape-bsm.c         |    8 +
 drivers/char/ftape/lowlevel/ftape-bsm.h         |    1 
 drivers/char/ftape/lowlevel/ftape-ctl.c         |   15 +--
 drivers/char/ftape/lowlevel/ftape-ctl.h         |    1 
 drivers/char/ftape/lowlevel/ftape-init.c        |    6 -
 drivers/char/ftape/lowlevel/ftape-io.c          |   24 -----
 drivers/char/ftape/lowlevel/ftape-io.h          |    4 
 drivers/char/ftape/lowlevel/ftape-proc.c        |    4 
 drivers/char/ftape/lowlevel/ftape-rw.c          |    2 
 drivers/char/ftape/lowlevel/ftape-rw.h          |    1 
 drivers/char/ftape/zftape/zftape-buffers.c      |    7 -
 drivers/char/ftape/zftape/zftape-buffers.h      |    1 
 drivers/char/ftape/zftape/zftape-init.c         |   13 ---
 drivers/char/ftape/zftape/zftape-init.h         |    1 
 drivers/char/ftape/zftape/zftape-rw.c           |    1 
 drivers/char/ftape/zftape/zftape-rw.h           |    1 
 drivers/char/ftape/zftape/zftape-vtbl.c         |    4 
 drivers/char/ftape/zftape/zftape-vtbl.h         |    1 
 drivers/char/ftape/zftape/zftape_syms.c         |    1 
 23 files changed, 31 insertions(+), 145 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/compressor/zftape-compress.c.old	2004-11-06 21:35:54.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/compressor/zftape-compress.c	2004-11-06 21:36:04.000000000 +0100
@@ -27,10 +27,6 @@
  *     changed * appropriately. See below.
  */
 
- char zftc_src[] ="$Source: /homes/cvs/ftape-stacked/ftape/compressor/zftape-compress.c,v $";
- char zftc_rev[] = "$Revision: 1.1.6.1 $";
- char zftc_dat[] = "$Date: 1997/11/16 15:15:56 $";
-
 #include <linux/version.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/fc-10.c.old	2004-11-06 21:36:15.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/fc-10.c	2004-11-06 21:36:30.000000000 +0100
@@ -56,13 +56,13 @@
 #include "../lowlevel/fdc-io.h"
 #include "../lowlevel/fc-10.h"
 
-__u16 inbs_magic[] = {
+static __u16 inbs_magic[] = {
 	0x3, 0x3, 0x0, 0x4, 0x7, 0x2, 0x5, 0x3, 0x1, 0x4,
 	0x3, 0x5, 0x2, 0x0, 0x3, 0x7, 0x4, 0x2,
 	0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7
 };
 
-__u16 fc10_ports[] = {
+static __u16 fc10_ports[] = {
 	0x180, 0x210, 0x2A0, 0x300, 0x330, 0x340, 0x370
 };
 
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/fdc-io.h.old	2004-11-06 21:39:01.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/fdc-io.h	2004-11-06 21:42:09.000000000 +0100
@@ -210,7 +210,6 @@
 extern volatile fdc_mode_enum fdc_mode;
 extern int fdc_setup_error;	/* outdated ??? */
 extern wait_queue_head_t ftape_wait_intr;
-extern int ftape_motor;		/* fdc motor line state */
 extern volatile int ftape_current_cylinder; /* track nr FDC thinks we're on */
 extern volatile __u8 fdc_head;	/* FDC head */
 extern volatile __u8 fdc_cyl;	/* FDC track */
@@ -231,15 +230,11 @@
 extern int fdc_ready_wait(unsigned int timeout);
 extern int fdc_command(const __u8 * cmd_data, int cmd_len);
 extern int fdc_result(__u8 * res_data, int res_len);
-extern int fdc_issue_command(const __u8 * out_data, int out_count,
-			     __u8 * in_data, int in_count);
 extern int fdc_interrupt_wait(unsigned int time);
-extern int fdc_set_seek_rate(int seek_rate);
 extern int fdc_seek(int track);
 extern int fdc_sense_drive_status(int *st3);
 extern void fdc_motor(int motor);
 extern void fdc_reset(void);
-extern int fdc_recalibrate(void);
 extern void fdc_disable(void);
 extern int fdc_fifo_threshold(__u8 threshold,
 			      int *fifo_state, int *lock_state, int *fifo_thr);
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/fdc-io.c.old	2004-11-06 21:42:21.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/fdc-io.c	2004-11-06 22:02:43.000000000 +0100
@@ -50,7 +50,7 @@
 
 /*      Global vars.
  */
-int ftape_motor;
+static int ftape_motor;
 volatile int ftape_current_cylinder = -1;
 volatile fdc_mode_enum fdc_mode = fdc_idle;
 fdc_config_info fdc;
@@ -86,6 +86,8 @@
 
 static char ftape_id[] = "ftape";  /* used by request irq and free irq */
 
+static int fdc_set_seek_rate(int seek_rate);
+
 void fdc_catch_stray_interrupts(int count)
 {
 	unsigned long flags;
@@ -103,7 +105,7 @@
  *  If usecs == 0 then just test status, else wait at least for usecs.
  *  Returns -ETIME on timeout. Function must be calibrated first !
  */
-int fdc_wait(unsigned int usecs, __u8 mask, __u8 state)
+static int fdc_wait(unsigned int usecs, __u8 mask, __u8 state)
 {
 	int count_1 = (fdc_calibr_count * usecs +
                        fdc_calibr_count - 1) / fdc_calibr_time;
@@ -129,18 +131,12 @@
 	fdc_wait(usecs, 0, 1);	/* will always timeout ! */
 }
 
-int fdc_ready_out_wait(unsigned int usecs)
+static int fdc_ready_out_wait(unsigned int usecs)
 {
 	fdc_usec_wait(FT_RQM_DELAY);	/* wait for valid RQM status */
 	return fdc_wait(usecs, FDC_DATA_OUT_READY, FDC_DATA_OUT_READY);
 }
 
-int fdc_ready_in_wait(unsigned int usecs)
-{
-	fdc_usec_wait(FT_RQM_DELAY);	/* wait for valid RQM status */
-	return fdc_wait(usecs, FDC_DATA_OUT_READY, FDC_DATA_IN_READY);
-}
-
 void fdc_wait_calibrate(void)
 {
 	ftape_calibrate("fdc_wait",
@@ -341,7 +337,7 @@
 /*      Handle command and result phases for
  *      commands without data phase.
  */
-int fdc_issue_command(const __u8 * out_data, int out_count,
+static int fdc_issue_command(const __u8 * out_data, int out_count,
 		      __u8 * in_data, int in_count)
 {
 	TRACE_FUN(ft_t_any);
@@ -497,7 +493,7 @@
 
 /*  Reprogram the 82078 registers to use Data Rate Table 1 on all drives.
  */
-void fdc_set_drive_specs(void)
+static void fdc_set_drive_specs(void)
 {
 	__u8 cmd[] = { FDC_DRIVE_SPEC, 0x00, 0x00, 0x00, 0x00, 0xc0};
 	int result;
@@ -705,7 +701,7 @@
 
 /*      Specify FDC seek-rate (milliseconds)
  */
-int fdc_set_seek_rate(int seek_rate)
+static int fdc_set_seek_rate(int seek_rate)
 {
 	/* set step rate, dma mode, and minimal head load and unload times
 	 */
@@ -803,49 +799,6 @@
 	TRACE_EXIT 0;
 }
 
-/*      Recalibrate and wait until home.
- */
-int fdc_recalibrate(void)
-{
-	__u8 out[2];
-	int st0;
-	int pcn;
-	int retry;
-	int old_seek_rate = fdc_seek_rate;
-	TRACE_FUN(ft_t_any);
-
-	TRACE_CATCH(fdc_set_seek_rate(6),);
-	out[0] = FDC_RECAL;
-	out[1] = ft_drive_sel;
-	ft_seek_completed = 0;
-	TRACE_CATCH(fdc_command(out, 2),);
-	/*    Handle interrupts until ft_seek_completed or timeout.
-	 */
-	for (retry = 0;; ++retry) {
-		TRACE_CATCH(fdc_interrupt_wait(2 * FT_SECOND),);
-		if (ft_seek_completed) {
-			TRACE_CATCH(fdc_sense_interrupt_status(&st0, &pcn),);
-			if ((st0 & ST0_SEEK_END) == 0) {
-				if (retry < 1) {
-					continue; /* some drives/fdc's
-						   * give an extra interrupt
-						   */
-				} else {
-					TRACE_ABORT(-EIO, ft_t_err,
-				    "no seek-end after seek completion !??");
-				}
-			}
-			break;
-		}
-	}
-	ftape_current_cylinder = pcn;
-	if (pcn != 0) {
-		TRACE(ft_t_err, "failed: resulting track = %d", pcn);
-	}
-	TRACE_CATCH(fdc_set_seek_rate(old_seek_rate),);
-	TRACE_EXIT 0;
-}
-
 static int perpend_mode; /* set if fdc is in perpendicular mode */
 
 static int perpend_off(void)
@@ -1079,7 +1032,7 @@
  */
 static __u8 fdc_save_state[2];
 
-int fdc_probe(void)
+static int fdc_probe(void)
 {
 	__u8 cmd[1];
 	__u8 stat[16]; /* must be able to hold dumpregs & save results */
@@ -1308,7 +1261,7 @@
 	TRACE_EXIT IRQ_RETVAL(handled);
 }
 
-int fdc_grab_irq_and_dma(void)
+static int fdc_grab_irq_and_dma(void)
 {
 	TRACE_FUN(ft_t_any);
 
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-bsm.h.old	2004-11-06 21:44:51.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-bsm.h	2004-11-06 21:44:58.000000000 +0100
@@ -60,7 +60,6 @@
 extern void update_bad_sector_map(__u8 * buffer);
 extern void ftape_extract_bad_sector_map(__u8 * buffer);
 extern SectorMap ftape_get_bad_sector_entry(int segment_id);
-extern void      ftape_put_bad_sector_entry(int segment_id, SectorMap mask);
 extern __u8 *ftape_find_end_of_bsm_list(__u8 * address);
 extern void ftape_init_bsm(void);
 
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-bsm.c.old	2004-11-06 21:45:16.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-bsm.c	2004-11-06 22:01:52.000000000 +0100
@@ -47,6 +47,10 @@
 } mode_type;
 
 #if 0
+static void ftape_put_bad_sector_entry(int segment_id, SectorMap new_map);
+#endif
+
+#if 0
 /*  fix_tape converts a normal QIC-80 tape into a 'wide' tape.
  *  For testing purposes only !
  */
@@ -375,7 +379,8 @@
 	}
 }
 
-void ftape_put_bad_sector_entry(int segment_id, SectorMap new_map)
+#if 0
+static void ftape_put_bad_sector_entry(int segment_id, SectorMap new_map)
 {
 	SectorCount *ptr = (SectorCount *)bad_sector_map;
 	int count;
@@ -438,6 +443,7 @@
 	}
 	TRACE_EXIT;
 }
+#endif  /*  0  */
 
 SectorMap ftape_get_bad_sector_entry(int segment_id)
 {
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-ctl.h.old	2004-11-06 21:47:35.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-ctl.h	2004-11-06 21:48:11.000000000 +0100
@@ -158,6 +158,5 @@
 				 unsigned int data_rate,
 				 unsigned int tape_len);
 extern int  ftape_calibrate_data_rate(unsigned int qic_std);
-extern int  ftape_init_drive(void);
 extern const ftape_info *ftape_get_status(void);
 #endif
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-ctl.c.old	2004-11-06 21:48:20.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-ctl.c	2004-11-06 21:49:27.000000000 +0100
@@ -113,11 +113,6 @@
 #endif
 }
 
-void ftape_set_status(const ftape_info *status)
-{
-	ftape_status = *status;
-}
-
 static int ftape_not_operational(int status)
 {
 	/* return true if status indicates tape can not be used.
@@ -210,7 +205,7 @@
 	return i;
 }
 
-void ftape_detach_drive(void)
+static void ftape_detach_drive(void)
 {
 	TRACE_FUN(ft_t_any);
 
@@ -241,7 +236,7 @@
 		ft_history.rewinds = 0;
 }
 
-int ftape_activate_drive(vendor_struct * drive_type)
+static int ftape_activate_drive(vendor_struct * drive_type)
 {
 	int result = 0;
 	TRACE_FUN(ft_t_flow);
@@ -301,7 +296,7 @@
 	TRACE_EXIT result;
 }
 
-int ftape_get_drive_status(void)
+static int ftape_get_drive_status(void)
 {
 	int result;
 	int status;
@@ -374,7 +369,7 @@
 	TRACE_EXIT 0;
 }
 
-void ftape_log_vendor_id(void)
+static void ftape_log_vendor_id(void)
 {
 	int vendor_index;
 	TRACE_FUN(ft_t_flow);
@@ -580,7 +575,7 @@
 	TRACE_EXIT 0;
 }
 
-int ftape_init_drive(void)
+static int ftape_init_drive(void)
 {
 	int status;
 	qic_model model;
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-init.c.old	2004-11-06 21:50:37.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-init.c	2004-11-06 21:50:58.000000000 +0100
@@ -48,12 +48,6 @@
 #include "../lowlevel/ftape-proc.h"
 #include "../lowlevel/ftape-tracing.h"
 
-/*      Global vars.
- */
-char ft_src[] __initdata = "$Source: /homes/cvs/ftape-stacked/ftape/lowlevel/ftape-init.c,v $";
-char ft_rev[] __initdata = "$Revision: 1.8 $";
-char ft_dat[] __initdata = "$Date: 1997/11/06 00:38:08 $";
-
 
 #if defined(MODULE) && !defined(CONFIG_FT_NO_TRACE_AT_ALL)
 static int ft_tracing = -1;
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-io.h.old	2004-11-06 21:51:28.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-io.h	2004-11-06 21:51:48.000000000 +0100
@@ -65,9 +65,6 @@
 			       unsigned int timeout,
 			       int *status);
 extern int  ftape_parameter(unsigned int parameter);
-extern int  ftape_parameter_wait(unsigned int parameter,
-				 unsigned int timeout,
-				 int *status);
 extern int ftape_report_operation(int *status,
 				  qic117_cmd_t  command,
 				  int result_length);
@@ -80,7 +77,6 @@
 extern int ftape_report_status(int *status);
 extern int ftape_ready_wait(unsigned int timeout, int *status);
 extern int ftape_seek_head_to_track(unsigned int track);
-extern int ftape_in_error_state(int status);
 extern int ftape_set_data_rate(unsigned int new_rate, unsigned int qic_std);
 extern int ftape_report_error(unsigned int *error,
 			      qic117_cmd_t *command,
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-io.c.old	2004-11-06 21:51:57.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-io.c	2004-11-06 21:52:34.000000000 +0100
@@ -350,7 +350,7 @@
 	return result;
 }
 
-int ftape_parameter_wait(unsigned int parm, unsigned int timeout, int *status)
+static int ftape_parameter_wait(unsigned int parm, unsigned int timeout, int *status)
 {
 	int result;
 
@@ -503,16 +503,6 @@
 	TRACE_EXIT 0;
 }
 
-int ftape_in_error_state(int status)
-{
-	TRACE_FUN(ft_t_any);
-
-	if ((status & QIC_STATUS_READY) && (status & QIC_STATUS_ERROR)) {
-		TRACE_ABORT(1, ft_t_warn, "warning: error status set!");
-	}
-	TRACE_EXIT 0;
-}
-
 int ftape_report_configuration(qic_model *model,
 			       unsigned int *rate,
 			       int *qic_std,
@@ -617,7 +607,7 @@
 	TRACE_EXIT (result < 0) ? -EIO : 0;
 }
 
-int ftape_report_rom_version(int *version)
+static int ftape_report_rom_version(int *version)
 {
 
 	if (ftape_report_operation(version, QIC_REPORT_ROM_VERSION, 8) < 0) {
@@ -627,16 +617,6 @@
 	}
 }
 
-int ftape_report_signature(int *signature)
-{
-	int result;
-
-	result = ftape_command(28);
-	result = ftape_report_operation(signature, 9, 8);
-	result = ftape_command(30);
-	return (result < 0) ? -EIO : 0;
-}
-
 void ftape_report_vendor_id(unsigned int *id)
 {
 	int result;
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-proc.c.old	2004-11-06 21:52:50.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-proc.c	2004-11-06 21:53:22.000000000 +0100
@@ -174,8 +174,8 @@
 	return len;
 }
 
-int ftape_read_proc(char *page, char **start, off_t off,
-		    int count, int *eof, void *data)
+static int ftape_read_proc(char *page, char **start, off_t off,
+			   int count, int *eof, void *data)
 {
 	char *ptr = page;
 	size_t len;
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-rw.h.old	2004-11-06 21:53:40.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-rw.h	2004-11-06 21:53:51.000000000 +0100
@@ -101,7 +101,6 @@
 extern buffer_struct *ftape_get_buffer  (ft_buffer_queue_t pos);
 extern int            ftape_buffer_id   (ft_buffer_queue_t pos);
 extern void           ftape_reset_buffer(void);
-extern int  ftape_read_id(void);
 extern void ftape_tape_parameters(__u8 drive_configuration);
 extern int  ftape_wait_segment(buffer_state_enum state);
 extern int  ftape_dumb_stop(void);
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-rw.c.old	2004-11-06 21:54:04.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/lowlevel/ftape-rw.c	2004-11-06 21:54:14.000000000 +0100
@@ -301,7 +301,7 @@
 
 /*      Read Id of first sector passing tape head.
  */
-int ftape_read_id(void)
+static int ftape_read_id(void)
 {
 	int status;
 	__u8 out[2];
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/zftape/zftape-buffers.h.old	2004-11-06 21:54:29.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/zftape/zftape-buffers.h	2004-11-06 21:54:48.000000000 +0100
@@ -37,7 +37,6 @@
 extern int   zft_vmalloc_once(void *new, size_t size);
 extern int   zft_vcalloc_once(void *new, size_t size);
 extern int   zft_vmalloc_always(void *new, size_t size);
-extern int   zft_vcalloc_always(void *new, size_t size);
 extern void  zft_vfree(void *old, size_t size);
 extern void *zft_kmalloc(size_t size);
 extern void  zft_kfree(void *old, size_t size);
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/zftape/zftape-buffers.c.old	2004-11-06 21:54:57.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/zftape/zftape-buffers.c	2004-11-06 21:55:09.000000000 +0100
@@ -87,13 +87,6 @@
 	TRACE_ABORT(0, ft_t_noise,
 		    "allocated buffer @ %p, %d bytes", *(void **)new, size);
 }
-int zft_vcalloc_always(void *new, size_t size)
-{
-	TRACE_FUN(ft_t_flow);
-
-	zft_vfree(new, size);
-	TRACE_EXIT zft_vcalloc_once(new, size);
-}
 int zft_vmalloc_always(void *new, size_t size)
 {
 	TRACE_FUN(ft_t_flow);
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/zftape/zftape_syms.c.old	2004-11-06 21:55:50.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/zftape/zftape_syms.c	2004-11-06 21:56:00.000000000 +0100
@@ -35,7 +35,6 @@
 
 /* zftape-init.c */
 EXPORT_SYMBOL(zft_cmpr_register);
-EXPORT_SYMBOL(zft_cmpr_unregister);
 /* zftape-read.c */
 EXPORT_SYMBOL(zft_fetch_segment_fraction);
 /* zftape-buffers.c */
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/zftape/zftape-init.h.old	2004-11-06 21:56:21.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/zftape/zftape-init.h	2004-11-06 21:57:26.000000000 +0100
@@ -70,7 +70,6 @@
 /* zftape-init.c defined global functions.
  */
 extern int                  zft_cmpr_register(struct zft_cmpr_ops *new_ops);
-extern struct zft_cmpr_ops *zft_cmpr_unregister(void);
 extern int                  zft_cmpr_lock(int try_to_load);
 
 #endif
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/zftape/zftape-init.c.old	2004-11-06 21:57:33.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/zftape/zftape-init.c	2004-11-06 21:58:02.000000000 +0100
@@ -46,10 +46,6 @@
 #include "../zftape/zftape-ctl.h"
 #include "../zftape/zftape-buffers.h"
 
-char zft_src[] __initdata = "$Source: /homes/cvs/ftape-stacked/ftape/zftape/zftape-init.c,v $";
-char zft_rev[] __initdata = "$Revision: 1.8 $";
-char zft_dat[] __initdata = "$Date: 1997/11/06 00:48:56 $";
-
 MODULE_AUTHOR("(c) 1996, 1997 Claus-Justus Heine "
 	      "(claus@momo.math.rwth-aachen.de)");
 MODULE_DESCRIPTION(ZFTAPE_VERSION " - "
@@ -278,15 +274,6 @@
 	}
 }
 
-struct zft_cmpr_ops *zft_cmpr_unregister(void)
-{
-	struct zft_cmpr_ops *old_ops = zft_cmpr_ops;
-	TRACE_FUN(ft_t_flow);
-
-	zft_cmpr_ops = NULL;
-	TRACE_EXIT old_ops;
-}
-
 /*  lock the zft-compressor() module.
  */
 int zft_cmpr_lock(int try_to_load)
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/zftape/zftape-rw.h.old	2004-11-06 21:58:16.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/zftape/zftape-rw.h	2004-11-06 21:58:29.000000000 +0100
@@ -79,7 +79,6 @@
 extern int zft_deblock_segment;
 extern zft_status_enum zft_io_state;
 extern int zft_header_changed;
-extern int zft_bad_sector_map_changed;
 extern int zft_qic113; /* conform to old specs. and old zftape */
 extern int zft_use_compression;
 extern unsigned int zft_blk_sz;
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/zftape/zftape-rw.c.old	2004-11-06 21:58:36.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/zftape/zftape-rw.c	2004-11-06 21:58:44.000000000 +0100
@@ -45,7 +45,6 @@
 int zft_deblock_segment = -1;
 zft_status_enum zft_io_state = zft_idle;
 int zft_header_changed;
-int zft_bad_sector_map_changed;
 int zft_qic113; /* conform to old specs. and old zftape */
 int zft_use_compression;
 zft_position zft_pos = {
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/zftape/zftape-vtbl.h.old	2004-11-06 21:59:14.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/zftape/zftape-vtbl.h	2004-11-06 21:59:20.000000000 +0100
@@ -152,7 +152,6 @@
 /* exported functions */
 extern void  zft_init_vtbl             (void);
 extern void  zft_free_vtbl             (void);
-extern void  zft_new_vtbl_entry        (void);
 extern int   zft_extract_volume_headers(__u8 *buffer);
 extern int   zft_update_volume_table   (unsigned int segment);
 extern int   zft_open_volume           (zft_position *pos,
--- linux-2.6.10-rc1-mm3-full/drivers/char/ftape/zftape/zftape-vtbl.c.old	2004-11-06 21:59:29.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ftape/zftape/zftape-vtbl.c	2004-11-06 21:59:59.000000000 +0100
@@ -62,7 +62,7 @@
 static zft_volinfo  eot_vtbl;
 static zft_volinfo *cur_vtbl;
 
-inline void zft_new_vtbl_entry(void)
+static inline void zft_new_vtbl_entry(void)
 {
 	struct list_head *tmp = &zft_last_vtbl->node;
 	zft_volinfo *new = zft_kmalloc(sizeof(zft_volinfo));
@@ -248,7 +248,7 @@
  * that buffer already contains the old volume-table, so that vtbl
  * entries without the zft_volume flag set can savely be ignored.
  */
-void zft_create_volume_headers(__u8 *buffer)
+static void zft_create_volume_headers(__u8 *buffer)
 {   
 	__u8 *entry;
 	struct list_head *tmp;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

