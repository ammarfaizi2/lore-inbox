Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263213AbSJHO0a>; Tue, 8 Oct 2002 10:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263211AbSJHO0a>; Tue, 8 Oct 2002 10:26:30 -0400
Received: from aneto.able.es ([212.97.163.22]:5760 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id <S263213AbSJHO01>;
	Tue, 8 Oct 2002 10:26:27 -0400
Date: Tue, 8 Oct 2002 16:31:45 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Rik van Riel <riel@conectiva.com.br>
Cc: procps-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] procps 2.0.10
Message-ID: <20021008143145.GA1560@werewolf.able.es>
References: <Pine.LNX.4.44L.0210081034360.1909-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44L.0210081034360.1909-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Tue, Oct 08, 2002 at 15:35:40 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.08 Rik van Riel wrote:
>		Procps 2.0.10
>		8 Oct 2002
>
>
>Procps is the package containing various system monitoring tools, like
>ps, top, vmstat, free, kill, sysctl, uptime and more.  After a long
>period of inactivity procps maintenance is active again and suggestions,
>bugreports and patches are always welcome on the procps list.
>
>The plan is to release a procps 2.1.0 around the time the 2.6.0 kernel
>comes out, with regular releases until then. Code cleanups and all kinds
>of enhancements are welcome.
>
>
>You can download procps 2.0.10 from:
>
>	http://surriel.com/procps/procps-2.0.10.tar.bz2

This makes CPU percentages stay aligned in column when some of them
reach 100%:

--- top.c.orig	2002-10-08 15:28:10.000000000 +0200
+++ top.c	2002-10-08 16:18:59.000000000 +0200
@@ -1700,8 +1700,8 @@
 								    cpu_mapping
 								    [i];
 							printf
-							    ("CPU%d states: %2d%s%-d%% user, %2d%s%-d%% system,"
-							     " %2d%s%-d%% nice, %2d%s%-d%% iowait, %2d%s%-d%% idle",
+							    ("CPU%d: %3d%s%-d%% user, %3d%s%-d%% system,"
+							     " %3d%s%-d%% nice, %3d%s%-d%% iowait, %3d%s%-d%% idle",
 							     cpumap,
 							     trimzero(u_ticks - u_ticks_o [i] + n_ticks - n_ticks_o [i]) * 100 / t_ticks,
 							     decimal_point,

It also kills the 'states' part, things are beginning to spread past 80
columns...is it very important ?

I am gettin also strange outputs sometimes, with a ton of digits in decimal
parts. Sample before my patch:

CPU0 states:  0,0% user,  0,6% system,  0,0% nice,  4,1070653% iowait,  0,109% idle
CPU1 states:  0,1% user,  0,1% system,  0,0% nice,  4,1070653% iowait,  0,113% idle

And after:

CPU0:   0,12% user,   0,5% system,   0,0% nice,  99,1357% iowait,   0,489% idle
CPU1:   0,13% user,   0,15% system,   0,0% nice,  99,1357% iowait,   0,478% idle

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (dolphin) for i586
Linux 2.4.20-pre9-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
