Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318014AbSIJTLg>; Tue, 10 Sep 2002 15:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318032AbSIJTLg>; Tue, 10 Sep 2002 15:11:36 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:27140 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S318014AbSIJTLe>;
	Tue, 10 Sep 2002 15:11:34 -0400
Date: Tue, 10 Sep 2002 21:15:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Mikael Pettersson <mikpe@csd.uu.se>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] undo 2.5.34 ftape damage
Message-ID: <20020910211544.B2197@mars.ravnborg.org>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <15742.2206.709234.102259@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15742.2206.709234.102259@kim.it.uu.se>; from mikpe@csd.uu.se on Tue, Sep 10, 2002 at 04:58:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 04:58:38PM +0200, Mikael Pettersson wrote:
> In the 2.5.33->2.5.34 step someone removed "export-objs" from
> drivers/char/ftape/lowlevel/Makefile, which makes it impossible to build
> ftape as a module since is _does_ have a number of EXPORT_SYMBOL's.
> 
> The patch below reverts that change. Linus, please apply.

The reason for this error to pop up is the usage of the FT_KSYM macro
in ftape_syms.c.
That exist solely for backwards compatibility for kernel 2.1.18 and older.
Better clean it up as follows.
Compiled, not tested.

	Sam

===== drivers/char/ftape/lowlevel/ftape_syms.c 1.1 vs edited =====
--- 1.1/drivers/char/ftape/lowlevel/ftape_syms.c	Tue Feb  5 18:40:05 2002
+++ edited/drivers/char/ftape/lowlevel/ftape_syms.c	Tue Sep 10 21:14:26 2002
@@ -42,62 +42,48 @@
 #include "../lowlevel/ftape-buffer.h"
 #include "../lowlevel/ftape-format.h"
 
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,1,18)
-# define FT_KSYM(sym) EXPORT_SYMBOL(sym);
-#else
-# define FT_KSYM(sym) X(sym),
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VER(2,1,18)
-struct symbol_table ftape_symbol_table = {
-#include <linux/symtab_begin.h>
-#endif
 /* bad sector handling from ftape-bsm.c */
-FT_KSYM(ftape_get_bad_sector_entry)
-FT_KSYM(ftape_find_end_of_bsm_list)
+EXPORT_SYMBOL(ftape_get_bad_sector_entry);
+EXPORT_SYMBOL(ftape_find_end_of_bsm_list);
 /* from ftape-rw.c */
-FT_KSYM(ftape_set_state)
+EXPORT_SYMBOL(ftape_set_state);
 /* from ftape-ctl.c */
-FT_KSYM(ftape_seek_to_bot)
-FT_KSYM(ftape_seek_to_eot)
-FT_KSYM(ftape_abort_operation)
-FT_KSYM(ftape_get_status)
-FT_KSYM(ftape_enable)
-FT_KSYM(ftape_disable)
-FT_KSYM(ftape_mmap)
-FT_KSYM(ftape_calibrate_data_rate)
+EXPORT_SYMBOL(ftape_seek_to_bot);
+EXPORT_SYMBOL(ftape_seek_to_eot);
+EXPORT_SYMBOL(ftape_abort_operation);
+EXPORT_SYMBOL(ftape_get_status);
+EXPORT_SYMBOL(ftape_enable);
+EXPORT_SYMBOL(ftape_disable);
+EXPORT_SYMBOL(ftape_mmap);
+EXPORT_SYMBOL(ftape_calibrate_data_rate);
 /* from ftape-io.c */
-FT_KSYM(ftape_reset_drive)
-FT_KSYM(ftape_command)
-FT_KSYM(ftape_parameter)
-FT_KSYM(ftape_ready_wait)
-FT_KSYM(ftape_report_operation)
-FT_KSYM(ftape_report_error)
+EXPORT_SYMBOL(ftape_reset_drive);
+EXPORT_SYMBOL(ftape_command);
+EXPORT_SYMBOL(ftape_parameter);
+EXPORT_SYMBOL(ftape_ready_wait);
+EXPORT_SYMBOL(ftape_report_operation);
+EXPORT_SYMBOL(ftape_report_error);
 /* from ftape-read.c */
-FT_KSYM(ftape_read_segment_fraction)
-FT_KSYM(ftape_zap_read_buffers)
-FT_KSYM(ftape_read_header_segment)
-FT_KSYM(ftape_decode_header_segment)
+EXPORT_SYMBOL(ftape_read_segment_fraction);
+EXPORT_SYMBOL(ftape_zap_read_buffers);
+EXPORT_SYMBOL(ftape_read_header_segment);
+EXPORT_SYMBOL(ftape_decode_header_segment);
 /* from ftape-write.c */
-FT_KSYM(ftape_write_segment)
-FT_KSYM(ftape_start_writing)
-FT_KSYM(ftape_loop_until_writes_done)
+EXPORT_SYMBOL(ftape_write_segment);
+EXPORT_SYMBOL(ftape_start_writing);
+EXPORT_SYMBOL(ftape_loop_until_writes_done);
 /* from ftape-buffer.h */
-FT_KSYM(ftape_set_nr_buffers)
+EXPORT_SYMBOL(ftape_set_nr_buffers);
 /* from ftape-format.h */
-FT_KSYM(ftape_format_track)
-FT_KSYM(ftape_format_status)
-FT_KSYM(ftape_verify_segment)
+EXPORT_SYMBOL(ftape_format_track);
+EXPORT_SYMBOL(ftape_format_status);
+EXPORT_SYMBOL(ftape_verify_segment);
 /* from tracing.c */
 #ifndef CONFIG_FT_NO_TRACE_AT_ALL
-FT_KSYM(ftape_tracing)
-FT_KSYM(ftape_function_nest_level)
-FT_KSYM(ftape_trace_call)
-FT_KSYM(ftape_trace_exit)
-FT_KSYM(ftape_trace_log)
-#endif
-/* end of ksym table */
-#if LINUX_VERSION_CODE < KERNEL_VER(2,1,18)
-#include <linux/symtab_end.h>
-};
+EXPORT_SYMBOL(ftape_tracing);
+EXPORT_SYMBOL(ftape_function_nest_level);
+EXPORT_SYMBOL(ftape_trace_call);
+EXPORT_SYMBOL(ftape_trace_exit);
+EXPORT_SYMBOL(ftape_trace_log);
 #endif
+

