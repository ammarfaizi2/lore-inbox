Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbTCJHck>; Mon, 10 Mar 2003 02:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262529AbTCJHcj>; Mon, 10 Mar 2003 02:32:39 -0500
Received: from ns.miraclelinux.com ([219.101.34.26]:41211 "EHLO
	dns01.miraclelinux.com") by vger.kernel.org with ESMTP
	id <S262317AbTCJHci>; Mon, 10 Mar 2003 02:32:38 -0500
To: mikpe@user.it.uu.se
Cc: perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       hardmeter-users@lists.sourceforge.jp
Cc: hyoshiok@miraclelinux.com
Subject: Re: [Perfctr-devel] perfctr and Linus' tree?
In-Reply-To: <15976.40680.424597.305633@gargle.gargle.HOWL>
References: <20030307153354J.hyoshiok@miraclelinux.com>
	<15976.40680.424597.305633@gargle.gargle.HOWL>
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Cuyahoga Valley)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20030310164311N.hyoshiok@miraclelinux.com>
Date: Mon, 10 Mar 2003 16:43:11 +0900
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@user.it.uu.se>
> Hiro Yoshioka writes:
>  > I have a question. Is there any progress on merging the
>  > perfctr patch to Linus' kernel tree?
>  > 
>  > http://www.uwsg.iu.edu/hypermail/linux/kernel/0303.0/0647.html
>  > 
>  > I found the DCL patch set includes the perfctr patch.
>  > http://lists.osdl.org/pipermail/dcl_developer/2003-March/000009.html
> 
> No progress since Linus totally ignored it, but at least two
> perfctr-patched trees exist. OSDL does one for the development
> kernel, and Jack Perdue has pre-patched RedHat kernel .rpms.
> (For Jack's stuff, check out PAPI -> Links -> Related Software.)
> 
> I'm planning to simplify the kernel <--> user-space interface in
> perfctr-2.6 (drop /proc/pid/perfctr and go back to /dev/perfctr),
> and then I _think_ I can do a version that doesn't require patching
> kernel source. (It will do binary code patching at module load-time
> instead. Horrible as that sounds, it's easier to deal with for users.)

I like /proc/pid/perfctr interface (virtual PMC mode).

The following patch should be included into the main line kernel,
shouldn't it?

--- linux-2.5.62-perfctr/include/asm-i386/processor.h.~1~       2003-02-18 02:06
:53.000000000 +0100
+++ linux-2.5.62-perfctr/include/asm-i386/processor.h   2003-02-18 02:18:36.0000
00000 +0100
@@ -372,6 +372,11 @@
        unsigned long __cacheline_filler[5];
 };
 
+/*
+ * Virtual per-process performance-monitoring counters.
+ */
+struct vperfctr;       /* opaque; no need to depend on <linux/perfctr.h> */
+
 struct thread_struct {
 /* cached TLS descriptors. */
        struct desc_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
@@ -393,6 +398,8 @@
        unsigned int            saved_fs, saved_gs;
 /* IO permissions */
        unsigned long   *ts_io_bitmap;
+/* performance counters */
+       struct vperfctr *perfctr;
 };
 
 #define INIT_THREAD  {                                                 \

---------------------------------------------

I think a per process (thread) performance monitoring is very
important.

Thanks in advance,
  Hiro
