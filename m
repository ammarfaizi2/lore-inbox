Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264272AbRFIS2U>; Sat, 9 Jun 2001 14:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264443AbRFIS2J>; Sat, 9 Jun 2001 14:28:09 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:61424 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S264272AbRFIS2A>;
	Sat, 9 Jun 2001 14:28:00 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: whitney@math.berkeley.edu
cc: tomlins@cam.org, tlan@stud.ntnu.no, linux-kernel@vger.kernel.org,
        mingo@redhat.com, torvalds@transmeta.com
Subject: Re: missing symbol do_softirq in net moduels for pre-2 
In-Reply-To: Your message of "Sat, 09 Jun 2001 11:13:46 MST."
             <200106091813.f59IDkX00991@adsl-209-76-109-63.dsl.snfc21.pacbell.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Jun 2001 04:28:15 +1000
Message-ID: <17844.992111295@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jun 2001 11:13:46 -0700, 
Wayne Whitney <whitney@math.berkeley.edu> wrote:
>I have verified that the versioning of the do_softirq symbol above is
>the source of the problems in 2.4.6-pre2

Resend, the first patch never appeared.  The problem is the call to
do_softirq inside an asm string where cpp cannot convert it.  The
correct fix is toe xpose do_softirq so cpp can convert it then map to a
string and concatenate with teh asm string.  But that requires ugly
helper macros, a cleaner fix is:

Against 2.4.6-pre2.  Note: you must run make mrproper after applying
this patch.

Index: 6-pre2.1/kernel/ksyms.c
--- 6-pre2.1/kernel/ksyms.c Sat, 09 Jun 2001 11:25:53 +1000 kaos (linux-2.4/j/46_ksyms.c 1.1.2.2.1.1.2.1.1.8.2.1.2.1 644)
+++ 6-pre2.1(w)/kernel/ksyms.c Sun, 10 Jun 2001 03:36:12 +1000 kaos (linux-2.4/j/46_ksyms.c 1.1.2.2.1.1.2.1.1.8.2.1.2.1 644)
@@ -536,7 +536,7 @@ EXPORT_SYMBOL(remove_bh);
 EXPORT_SYMBOL(tasklet_init);
 EXPORT_SYMBOL(tasklet_kill);
 EXPORT_SYMBOL(__run_task_queue);
-EXPORT_SYMBOL(do_softirq);
+EXPORT_SYMBOL_NOVERS(do_softirq);
 EXPORT_SYMBOL(tasklet_schedule);
 EXPORT_SYMBOL(tasklet_hi_schedule);
 

