Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264447AbTCZAVr>; Tue, 25 Mar 2003 19:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264494AbTCZAVr>; Tue, 25 Mar 2003 19:21:47 -0500
Received: from rj.SGI.COM ([192.82.208.96]:58838 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S264447AbTCZAVq>;
	Tue, 25 Mar 2003 19:21:46 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 sched.c never resets cpus_runnable for UP
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Mar 2003 11:32:46 +1100
Message-ID: <28862.1048638766@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/sched.c uses task_set_cpu() and task_release_cpu() to modify the
cpus_runnable flag.  On UP, task_set_cpu() is called but
task_release_cpu() is not, it is wrapped in #ifdef CONFIG_SMP.  The
result is that all tasks have cpus_runnable=1 and task_has_cpu()
reports true for all tasks.

How to confuse a debugger in one easy lesson :(

