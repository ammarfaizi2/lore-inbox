Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317371AbSHSLez>; Mon, 19 Aug 2002 07:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318308AbSHSLez>; Mon, 19 Aug 2002 07:34:55 -0400
Received: from smtp-stjh-01-04.rogers.nf.net ([192.75.13.144]:56043 "EHLO
	smtp-stjh-01-04.rogers.nf.net") by vger.kernel.org with ESMTP
	id <S317371AbSHSLey>; Mon, 19 Aug 2002 07:34:54 -0400
From: "Skidley" <skidley@roadrunner.nf.net>
Date: Mon, 19 Aug 2002 09:08:49 -0230
To: Mauricio Pretto <pretto@interage.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre3 boot hang
Message-ID: <20020819113849.GA352@hendrix>
Mail-Followup-To: Mauricio Pretto <pretto@interage.com.br>,
	linux-kernel@vger.kernel.org
References: <20020818153145.GA3184@df1tlpc.local.here> <3D60D2DB.3050202@interage.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D60D2DB.3050202@interage.com.br>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 08:13:31AM -0300, Mauricio Pretto wrote:
> Same Problem Here, athlon 1.1 , Right after Rt netlink socket it hangs.
> My .config goes attach.
> 
> 
> Klaus Dittrich wrote:
> 
> >SMP, P-III, Intel-BX
> >
> >booting Linux 2.4.20-pre3 stops after 
> >
> >Linux NET4.0 for Linux 2.4 
> >Based upon Swansea University Computer Society NET3.039 
> >Initializing RT netlink socket 
> >
> >
> 
> 
> -- 
> Mauricio Pretto
> Gerente de Produtos
> Interage Integradora
> http://www.interage.com.br
> 
> T?cnico Certificado Conectiva Linux

This patch was posted to lkml earlier, it fixed the same problem for me:


diff -urN linux-2.4/kernel/sched.c pmac/kernel/sched.c
--- linux-2.4/kernel/sched.c	Wed Aug  7 18:10:01 2002
+++ pmac/kernel/sched.c	Mon Aug 19 10:39:39 2002
@@ -1081,6 +1081,7 @@
 {
 	set_current_state(TASK_RUNNING);
 	sys_sched_yield();
+	schedule();
 }
 
 void __cond_resched(void)

-- 
"I mean they are gonna kill ya so like if ya give em a quick, short, sharp,
shock they won't do it again. Dig it! I mean he got off lightly cuz I would 
have given him a thrashing. I only hit him once. It was only a difference of 
opinion but really... I mean good manners don't cost nothin do they. Eh?"
