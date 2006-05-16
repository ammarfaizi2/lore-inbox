Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751826AbWEPNYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbWEPNYJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 09:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWEPNYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 09:24:09 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35076 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751826AbWEPNYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 09:24:08 -0400
Date: Tue, 16 May 2006 15:24:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, dzickus <dzickus@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: [-mm patch] arch/i386/oprofile/: make functions static
Message-ID: <20060516132405.GU6931@stusta.de>
References: <20060515005637.00b54560.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515005637.00b54560.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 12:56:37AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc3-mm1:
>...
> +x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions.patch
>...
>  x86_64 tree updates
>...


This patch makes the following needlessly global functions static:
- nmi_int.c: profile_exceptions_notify()
- nmi_timer_int.c: profile_timer_exceptions_notify()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/oprofile/nmi_int.c       |    4 ++--
 arch/i386/oprofile/nmi_timer_int.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.17-rc4-mm1-full/arch/i386/oprofile/nmi_int.c.old	2006-05-16 12:32:15.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/arch/i386/oprofile/nmi_int.c	2006-05-16 12:32:34.000000000 +0200
@@ -82,8 +82,8 @@
 #define exit_driverfs() do { } while (0)
 #endif /* CONFIG_PM */
 
-int profile_exceptions_notify(struct notifier_block *self,
-				unsigned long val, void *data)
+static int profile_exceptions_notify(struct notifier_block *self,
+				     unsigned long val, void *data)
 {
 	struct die_args *args = (struct die_args *)data;
 	int ret = NOTIFY_DONE;
--- linux-2.6.17-rc4-mm1-full/arch/i386/oprofile/nmi_timer_int.c.old	2006-05-16 12:32:55.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/arch/i386/oprofile/nmi_timer_int.c	2006-05-16 12:33:04.000000000 +0200
@@ -19,8 +19,8 @@
 #include <asm/ptrace.h>
 #include <asm/kdebug.h>
  
-int profile_timer_exceptions_notify(struct notifier_block *self,
-				unsigned long val, void *data)
+static int profile_timer_exceptions_notify(struct notifier_block *self,
+					   unsigned long val, void *data)
 {
 	struct die_args *args = (struct die_args *)data;
 	int ret = NOTIFY_DONE;

