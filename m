Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750699AbWJQV3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750699AbWJQV3q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWJQV3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:29:44 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:46971 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750699AbWJQV1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:27:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=MGwbV8qB/qtfbzVHmY4GvJOiKXaXYMMYZlhSbHYhNXIki04JMXb0Ii1etkZYp2JtqgXsVIfl22Kgo8kCZDZmyQUtFGEDWosecWuiMuawPt5m9tQr1zavM50ynNKMwpUPTMAOz8CSBL/j180zaUaOi9uREw1FJmQ+6qtJpfS7H7Y=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 02/10] uml: split memory allocation prototypes out of user.h
Date: Tue, 17 Oct 2006 23:27:07 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061017212707.26445.67427.stgit@americanbeauty.home.lan>
In-Reply-To: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

user.h is too generic a header name. I've split out allocation routines from it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/cow_sys.h                |    1 +
 arch/um/drivers/daemon_user.c            |    1 +
 arch/um/drivers/fd.c                     |    1 +
 arch/um/drivers/mcast_user.c             |    1 +
 arch/um/drivers/net_user.c               |    1 +
 arch/um/drivers/pcap_user.c              |    1 +
 arch/um/drivers/port_user.c              |    1 +
 arch/um/drivers/pty.c                    |    1 +
 arch/um/drivers/slip_user.c              |    1 +
 arch/um/drivers/tty.c                    |    1 +
 arch/um/include/um_malloc.h              |   17 +++++++++++++++++
 arch/um/include/user.h                   |    6 ------
 arch/um/include/user_util.h              |    1 -
 arch/um/kernel/irq.c                     |    1 +
 arch/um/kernel/process.c                 |    1 +
 arch/um/os-Linux/drivers/ethertap_user.c |    1 +
 arch/um/os-Linux/irq.c                   |    1 +
 arch/um/os-Linux/main.c                  |    1 +
 arch/um/os-Linux/sigio.c                 |    1 +
 19 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/um/drivers/cow_sys.h b/arch/um/drivers/cow_sys.h
index 7a5b4af..c6a3084 100644
--- a/arch/um/drivers/cow_sys.h
+++ b/arch/um/drivers/cow_sys.h
@@ -5,6 +5,7 @@ #include "kern_util.h"
 #include "user_util.h"
 #include "os.h"
 #include "user.h"
+#include "um_malloc.h"
 
 static inline void *cow_malloc(int size)
 {
diff --git a/arch/um/drivers/daemon_user.c b/arch/um/drivers/daemon_user.c
index 77954ea..310af0f 100644
--- a/arch/um/drivers/daemon_user.c
+++ b/arch/um/drivers/daemon_user.c
@@ -17,6 +17,7 @@ #include "kern_util.h"
 #include "user_util.h"
 #include "user.h"
 #include "os.h"
+#include "um_malloc.h"
 
 #define MAX_PACKET (ETH_MAX_PACKET + ETH_HEADER_OTHER)
 
diff --git a/arch/um/drivers/fd.c b/arch/um/drivers/fd.c
index 108b7da..218aa0e 100644
--- a/arch/um/drivers/fd.c
+++ b/arch/um/drivers/fd.c
@@ -12,6 +12,7 @@ #include "user.h"
 #include "user_util.h"
 #include "chan_user.h"
 #include "os.h"
+#include "um_malloc.h"
 
 struct fd_chan {
 	int fd;
diff --git a/arch/um/drivers/mcast_user.c b/arch/um/drivers/mcast_user.c
index 4d2bd39..8138f5e 100644
--- a/arch/um/drivers/mcast_user.c
+++ b/arch/um/drivers/mcast_user.c
@@ -23,6 +23,7 @@ #include "kern_util.h"
 #include "user_util.h"
 #include "user.h"
 #include "os.h"
+#include "um_malloc.h"
 
 #define MAX_PACKET (ETH_MAX_PACKET + ETH_HEADER_OTHER)
 
diff --git a/arch/um/drivers/net_user.c b/arch/um/drivers/net_user.c
index f3a3f8a..0ffd7ac 100644
--- a/arch/um/drivers/net_user.c
+++ b/arch/um/drivers/net_user.c
@@ -18,6 +18,7 @@ #include "user_util.h"
 #include "kern_util.h"
 #include "net_user.h"
 #include "os.h"
+#include "um_malloc.h"
 
 int tap_open_common(void *dev, char *gate_addr)
 {
diff --git a/arch/um/drivers/pcap_user.c b/arch/um/drivers/pcap_user.c
index 2ef641d..11921a7 100644
--- a/arch/um/drivers/pcap_user.c
+++ b/arch/um/drivers/pcap_user.c
@@ -12,6 +12,7 @@ #include <asm/types.h>
 #include "net_user.h"
 #include "pcap_user.h"
 #include "user.h"
+#include "um_malloc.h"
 
 #define MAX_PACKET (ETH_MAX_PACKET + ETH_HEADER_OTHER)
 
diff --git a/arch/um/drivers/port_user.c b/arch/um/drivers/port_user.c
index f2e8fc4..bc6afaf 100644
--- a/arch/um/drivers/port_user.c
+++ b/arch/um/drivers/port_user.c
@@ -19,6 +19,7 @@ #include "user.h"
 #include "chan_user.h"
 #include "port.h"
 #include "os.h"
+#include "um_malloc.h"
 
 struct port_chan {
 	int raw;
diff --git a/arch/um/drivers/pty.c b/arch/um/drivers/pty.c
index abec620..829a5ec 100644
--- a/arch/um/drivers/pty.c
+++ b/arch/um/drivers/pty.c
@@ -13,6 +13,7 @@ #include "user.h"
 #include "user_util.h"
 #include "kern_util.h"
 #include "os.h"
+#include "um_malloc.h"
 
 struct pty_chan {
 	void (*announce)(char *dev_name, int dev);
diff --git a/arch/um/drivers/slip_user.c b/arch/um/drivers/slip_user.c
index 8460285..7eddacc 100644
--- a/arch/um/drivers/slip_user.c
+++ b/arch/um/drivers/slip_user.c
@@ -15,6 +15,7 @@ #include "net_user.h"
 #include "slip.h"
 #include "slip_common.h"
 #include "os.h"
+#include "um_malloc.h"
 
 void slip_user_init(void *data, void *dev)
 {
diff --git a/arch/um/drivers/tty.c b/arch/um/drivers/tty.c
index 11de3ac..d95d643 100644
--- a/arch/um/drivers/tty.c
+++ b/arch/um/drivers/tty.c
@@ -11,6 +11,7 @@ #include "chan_user.h"
 #include "user_util.h"
 #include "user.h"
 #include "os.h"
+#include "um_malloc.h"
 
 struct tty_chan {
 	char *dev;
diff --git a/arch/um/include/um_malloc.h b/arch/um/include/um_malloc.h
new file mode 100644
index 0000000..0363a9b
--- /dev/null
+++ b/arch/um/include/um_malloc.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2005 Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
+ * Licensed under the GPL
+ */
+
+#ifndef __UM_MALLOC_H__
+#define __UM_MALLOC_H__
+
+extern void *um_kmalloc(int size);
+extern void *um_kmalloc_atomic(int size);
+extern void kfree(const void *ptr);
+
+extern void *um_vmalloc(int size);
+extern void *um_vmalloc_atomic(int size);
+extern void vfree(void *ptr);
+
+#endif /* __UM_MALLOC_H__ */
diff --git a/arch/um/include/user.h b/arch/um/include/user.h
index 39f8c88..acadce3 100644
--- a/arch/um/include/user.h
+++ b/arch/um/include/user.h
@@ -11,17 +11,11 @@ extern void panic(const char *fmt, ...)
 extern int printk(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 extern void schedule(void);
-extern void *um_kmalloc(int size);
-extern void *um_kmalloc_atomic(int size);
-extern void kfree(void *ptr);
 extern int in_aton(char *str);
 extern int open_gdb_chan(void);
 /* These use size_t, however unsigned long is correct on both i386 and x86_64. */
 extern unsigned long strlcpy(char *, const char *, unsigned long);
 extern unsigned long strlcat(char *, const char *, unsigned long);
-extern void *um_vmalloc(int size);
-extern void *um_vmalloc_atomic(int size);
-extern void vfree(void *ptr);
 
 #endif
 
diff --git a/arch/um/include/user_util.h b/arch/um/include/user_util.h
index 802d784..06625fe 100644
--- a/arch/um/include/user_util.h
+++ b/arch/um/include/user_util.h
@@ -52,7 +52,6 @@ extern int linux_main(int argc, char **a
 extern void set_cmdline(char *cmd);
 extern void input_cb(void (*proc)(void *), void *arg, int arg_len);
 extern int get_pty(void);
-extern void *um_kmalloc(int size);
 extern int switcheroo(int fd, int prot, void *from, void *to, int size);
 extern void do_exec(int old_pid, int new_pid);
 extern void tracer_panic(char *msg, ...)
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index ef25956..5c1e611 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -31,6 +31,7 @@ #include "irq_user.h"
 #include "irq_kern.h"
 #include "os.h"
 #include "sigio.h"
+#include "um_malloc.h"
 #include "misc_constants.h"
 
 /*
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index fe6c64a..348b272 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -46,6 +46,7 @@ #include "os.h"
 #include "mode.h"
 #include "mode_kern.h"
 #include "choose-mode.h"
+#include "um_malloc.h"
 
 /* This is a per-cpu array.  A processor only modifies its entry and it only
  * cares about its entry, so it's OK if another processor is modifying its
diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/arch/um/os-Linux/drivers/ethertap_user.c
index f559bdf..863981b 100644
--- a/arch/um/os-Linux/drivers/ethertap_user.c
+++ b/arch/um/os-Linux/drivers/ethertap_user.c
@@ -20,6 +20,7 @@ #include "user_util.h"
 #include "net_user.h"
 #include "etap.h"
 #include "os.h"
+#include "um_malloc.h"
 
 #define MAX_PACKET ETH_MAX_PACKET
 
diff --git a/arch/um/os-Linux/irq.c b/arch/um/os-Linux/irq.c
index a97206d..d46b818 100644
--- a/arch/um/os-Linux/irq.c
+++ b/arch/um/os-Linux/irq.c
@@ -18,6 +18,7 @@ #include "process.h"
 #include "sigio.h"
 #include "irq_user.h"
 #include "os.h"
+#include "um_malloc.h"
 
 static struct pollfd *pollfds = NULL;
 static int pollfds_num = 0;
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index d1c5670..685feaa 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -23,6 +23,7 @@ #include "mode.h"
 #include "choose-mode.h"
 #include "uml-config.h"
 #include "os.h"
+#include "um_malloc.h"
 
 /* Set in set_stklim, which is called from main and __wrap_malloc.
  * __wrap_malloc only calls it if main hasn't started.
diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index f645776..925a652 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -19,6 +19,7 @@ #include "kern_util.h"
 #include "user_util.h"
 #include "sigio.h"
 #include "os.h"
+#include "um_malloc.h"
 
 /* Protected by sigio_lock(), also used by sigio_cleanup, which is an
  * exitcall.
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
