Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbTF0FrN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 01:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTF0FrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 01:47:13 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:51986 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261985AbTF0FrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 01:47:11 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre2
Date: Fri, 27 Jun 2003 07:59:10 +0200
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_u09++sNiU4fM8Cu"
Message-Id: <200306270759.10932.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_u09++sNiU4fM8Cu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 27 June 2003 00:03, Marcelo Tosatti wrote:

Hi Marcelo,

> Here goes -pre2 with a big number of changes, including the new aic7xxx
> driver.
> I wont accept any big changes after -pre4: I want 2.4.22 timecycle to be
> short.
so why you don't merge this? This is now the 4th resend.

--------------------------------------------------------------------------
[PATCH 2.4.22-BK] [RESEND 3rd] Fix oom killer braindamage
Date: 21.06.2003 22:04
From: Marc-Christian Petersen <m.c.p@wolk-project.de>  (Working Overloaded 
Linux Kernel)
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: linux-kernel@vger.kernel.org

Hi Marcelo,

attached patch fixes the oom killer braindamage where it tries to kill 
processes again and again and again w/o any ending or successfull killing of 
the selected processes in an OOM case.

The attached, very simple but effective, patch fixes it.

All the kudos go to Rik van Riel.

Patch tested and works, and also for a long time in my tree (and maybe also 
others?!)

This issue is out there for several years.

Please apply it for 2.4.22-pre2, thanks.
--------------------------------------------------------------------------

ciao, Marc

--Boundary-00=_u09++sNiU4fM8Cu
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="oomkiller-braindamage-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="oomkiller-braindamage-fix.patch"

===== mm/oom_kill.c 1.11 vs edited =====
--- 1.11/mm/oom_kill.c	Fri Aug 16 10:59:46 2002
+++ edited/mm/oom_kill.c	Sat Feb 22 17:31:49 2003
@@ -61,11 +61,16 @@ static int badness(struct task_struct *p
 
 	if (!p->mm)
 		return 0;
+
+	if (p->flags & PF_MEMDIE)
+		return 0;
+
 	/*
 	 * Never kill init
 	 */
 	if (p->pid == 1)
 		return 0;
+
 	/*
 	 * The memory size of the process is the basis for the badness.
 	 */

--Boundary-00=_u09++sNiU4fM8Cu--

