Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318067AbSGLXkW>; Fri, 12 Jul 2002 19:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318068AbSGLXkV>; Fri, 12 Jul 2002 19:40:21 -0400
Received: from t2o913p32.telia.com ([195.252.44.152]:48256 "EHLO
	best.localdomain") by vger.kernel.org with ESMTP id <S318067AbSGLXkU>;
	Fri, 12 Jul 2002 19:40:20 -0400
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc1-ac3
References: <200207121914.g6CJEcN32497@devserv.devel.redhat.com>
From: Peter Osterlund <petero2@telia.com>
Date: 13 Jul 2002 01:42:52 +0200
In-Reply-To: <200207121914.g6CJEcN32497@devserv.devel.redhat.com>
Message-ID: <m2znwwikcj.fsf@best.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> writes:

> o	Update cpufreq, add PIV throttling		(Robert Schwebel,
> 			Padraig Brady, Zwane Mwaikambo, Arjan van de Ven,
> 			Tora Engstad)

It doesn't work because of a bug in cpufreq_p4_validatedc. Here is a
patch to fix it:

--- linux/arch/i386/kernel/p4-clockmod.c.orig	Sat Jul 13 01:27:30 2002
+++ linux/arch/i386/kernel/p4-clockmod.c	Sat Jul 13 01:27:55 2002
@@ -97,8 +97,9 @@
 	for (i=0; i<8; i++) 
 		if (percent <= cycle_table[i][0]) {
 			dc = cycle_table[i][1];
 			*pct = cycle_table[i][0];
+			break;
 		}
 
 
 	if (has_N44_O17_errata && (dc == DC_25PT || dc == DC_DFLT)) {

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
