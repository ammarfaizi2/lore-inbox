Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbUADAEM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 19:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbUADAEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 19:04:12 -0500
Received: from [193.138.115.2] ([193.138.115.2]:13580 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S264363AbUADAEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 19:04:06 -0500
Date: Sun, 4 Jan 2004 01:01:26 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: [minor & trivial patch] kill some potential warnings about inline
 keyword placement - 2.6.1-rc1-mm1
Message-ID: <Pine.LNX.4.56.0401040046450.4664@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm compiling 2.6.1-rc1-mm1 with "-W -Wall" to look for potential problems
and minor stuff to clean up.

One of the things that enabling the extra warnings turn up is errors about
the placement of the inline keyword - like :

arch/i386/kernel/efi.c:177: warning: `inline' is not at beginning of declaration
arch/i386/kernel/efi.c:210: warning: `inline' is not at beginning of declaration
include/linux/efi.h:300: warning: `inline' is not at beginning of declaration
include/linux/efi.h:301: warning: `inline' is not at beginning of declaration
kernel/posix-timers.c:577: warning: `inline' is not at beginning of declaration

While these warnings do not show up with the usual gcc arguments used to
build the kernel and they are harmless, they are none the less trivial to
correct, so below is a patch that does just that.  I don't see why not
(well, unless some consider it an important style issue that is) ...

I haven't been over the entire source looking for this particular issue
yet, but if the patches below are appreciated then I'll go through it all.


--- linux-2.6.1-rc1-mm1-orig/include/linux/efi.h        2003-12-31 05:48:26.000000000 +0100
+++ linux-2.6.1-rc1-mm1/include/linux/efi.h     2004-01-04 00:29:48.000000000 +0100
@@ -297,8 +297,8 @@ extern u64 efi_mem_attributes (unsigned
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
                                        struct resource *data_resource);
 extern efi_status_t phys_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc);
-extern unsigned long inline __init efi_get_time(void);
-extern int inline __init efi_set_rtc_mmss(unsigned long nowtime);
+inline extern unsigned long __init efi_get_time(void);
+inline extern int __init efi_set_rtc_mmss(unsigned long nowtime);
 extern struct efi_memory_map memmap;

 #ifdef CONFIG_EFI


--- linux-2.6.1-rc1-mm1-orig/arch/i386/kernel/efi.c     2003-12-31 05:47:59.000000000 +0100
+++ linux-2.6.1-rc1-mm1/arch/i386/kernel/efi.c  2004-01-04 00:30:53.000000000 +0100
@@ -174,7 +174,7 @@ phys_efi_get_time(efi_time_t *tm, efi_ti
        return status;
 }

-int inline efi_set_rtc_mmss(unsigned long nowtime)
+inline int efi_set_rtc_mmss(unsigned long nowtime)
 {
        int real_seconds, real_minutes;
        efi_status_t    status;
@@ -207,7 +207,7 @@ int inline efi_set_rtc_mmss(unsigned lon
  * services have been remapped, therefore, we'll need to call in physical
  * mode.  Note, this call isn't used later, so mark it __init.
  */
-unsigned long inline __init efi_get_time(void)
+inline unsigned long __init efi_get_time(void)
 {
        efi_status_t status;
        efi_time_t eft;


--- linux-2.6.1-rc1-mm1-orig/kernel/posix-timers.c      2003-12-31 05:47:26.000000000 +0100
+++ linux-2.6.1-rc1-mm1/kernel/posix-timers.c   2004-01-04 00:31:45.000000000 +0100
@@ -574,7 +574,7 @@ static struct k_itimer * lock_timer(time
  * it is the same as a requeue pending timer WRT to what we should
  * report.
  */
-void inline
+inline void
 do_timer_gettime(struct k_itimer *timr, struct itimerspec *cur_setting)
 {
        unsigned long expires;



Kind regards,

Jesper Juhl

