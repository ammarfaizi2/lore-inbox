Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030477AbVLWKMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbVLWKMc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 05:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbVLWKMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 05:12:32 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:12427 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030477AbVLWKMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 05:12:31 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Parag Warudkar <kernel-stuff@comcast.net>,
       Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Reply-To: 7eggert@gmx.de
Date: Fri, 23 Dec 2005 11:12:38 +0100
References: <5lQOU-492-31@gated-at.bofh.it> <5lQOU-492-29@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1Epjug-0001iA-In@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl> wrote:

> "With some drawbacks" is the point: It has been determined that the
> drawbacks are heavy enough that the 8KiB stack option should go.

Determined by voodoo and wild guessing.

Let's detect the need for 4K stacks: (I hope I found the correct place)

(Maybe the printk should be completely ifdefed, but I'm not sure)


Signed-off-by: Bodo Eggert <7eggert@gmx.de>

--- 2.6.14/kernel/fork.c.ori    2005-12-21 19:06:24.000000000 +0100
+++ 2.6.14/kernel/fork.c        2005-12-21 19:15:23.000000000 +0100
@@ -168,4 +168,9 @@ static struct task_struct *dup_task_stru
        if (!ti) {
                free_task_struct(tsk);
+               printk(KERN_WARNING, "Can't allocate new task structure"
+#ifndef CONFIG_4KSTACKS
+               ". Maybe you could benefit from 4K stacks.\n"
+#endif
+               "\n");
                return NULL;
        }

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
