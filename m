Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbTKVTlL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 14:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbTKVTlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 14:41:10 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:39555
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262730AbTKVTlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 14:41:07 -0500
Date: Sat, 22 Nov 2003 14:39:50 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Remi Colinet <remi.colinet@wanadoo.fr>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm5 : compile error
In-Reply-To: <3FBFA6DA.3070707@wanadoo.fr>
Message-ID: <Pine.LNX.4.53.0311221438150.2498@montezuma.fsmlabs.com>
References: <3FBF5C79.5050409@wanadoo.fr> <Pine.LNX.4.53.0311220946280.2498@montezuma.fsmlabs.com>
 <3FBF99E6.1070402@wanadoo.fr> <Pine.LNX.4.53.0311221218350.2498@montezuma.fsmlabs.com>
 <3FBFA6DA.3070707@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Nov 2003, Remi Colinet wrote:

> Zwane Mwaikambo wrote:
> >
> I have dowloaded linux-2.6.0-test9.tar.bz2 and 2.6.0-test9-mm5.bz2. Here 
> is the begining of my arch/i386/kernel/process.c file after applying the 
> mm patch :

Thanks for verifying that, the error was in my auto cvs import script. It 
seems to have generated rejects. I presume the following patch would 
suffice (including your other changes)?

Index: linux-2.6.0-test9-mm5/drivers/oprofile/oprofile_stats.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test9-mm5/drivers/oprofile/oprofile_stats.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 oprofile_stats.c
--- linux-2.6.0-test9-mm5/drivers/oprofile/oprofile_stats.c	21 Nov 2003 20:59:40 -0000	1.1.1.1
+++ linux-2.6.0-test9-mm5/drivers/oprofile/oprofile_stats.c	21 Nov 2003 21:27:44 -0000
@@ -10,7 +10,8 @@
 #include <linux/oprofile.h>
 #include <linux/cpumask.h>
 #include <linux/threads.h>
- 
+#include <linux/smp.h>
+
 #include "oprofile_stats.h"
 #include "cpu_buffer.h"
  
Index: linux-2.6.0-test9-mm5/include/linux/cpumask.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test9-mm5/include/linux/cpumask.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 cpumask.h
--- linux-2.6.0-test9-mm5/include/linux/cpumask.h	21 Nov 2003 20:59:57 -0000	1.1.1.1
+++ linux-2.6.0-test9-mm5/include/linux/cpumask.h	21 Nov 2003 21:52:39 -0000
@@ -39,9 +39,8 @@ typedef unsigned long cpumask_t;
 
 
 #ifdef CONFIG_SMP
-
+#include <asm/smp.h>
 extern cpumask_t cpu_online_map;
-extern cpumask_t cpu_possible_map;
 
 #define num_online_cpus()		cpus_weight(cpu_online_map)
 #define cpu_online(cpu)			cpu_isset(cpu, cpu_online_map)
