Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbTABAao>; Wed, 1 Jan 2003 19:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbTABAao>; Wed, 1 Jan 2003 19:30:44 -0500
Received: from gate.mvhi.com ([195.224.96.166]:13586 "EHLO gate.mvhi.com")
	by vger.kernel.org with ESMTP id <S265396AbTABAal>;
	Wed, 1 Jan 2003 19:30:41 -0500
Message-ID: <15891.35418.412034.594225@server.axiom.internal>
Date: Thu, 2 Jan 2003 00:39:54 +0000
From: Peter.Benie@mvhi.com (Peter Benie)
To: linux-kernel@vger.kernel.org
Subject: Does cli() need to be called before reading avenrun?
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel 2.4, in sys_sysinfo(), the code reads:

   cli();
   val.uptime = jiffies / HZ;

   val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
   val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
   val.loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);

   val.procs = nr_threads-1;
   sti();

In loadavg_read_proc, the code is in essence the same, except that it
isn't wrapped in cli/sti.  

Is there a reason for the cli?

Peter
