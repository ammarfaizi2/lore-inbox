Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266840AbTAIRD5>; Thu, 9 Jan 2003 12:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266841AbTAIRD5>; Thu, 9 Jan 2003 12:03:57 -0500
Received: from robur.slu.se ([130.238.98.12]:33554 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S266840AbTAIRD4>;
	Thu, 9 Jan 2003 12:03:56 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15901.44924.430586.886@robur.slu.se>
Date: Thu, 9 Jan 2003 18:21:00 +0100
To: "David S. Miller" <davem@redhat.com>
Cc: Steffen Persvold <sp@scali.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NAPI and tg3
In-Reply-To: <Pine.LNX.4.44.0301080059060.1128-100000@sp-laptop.isdn.scali.no>
References: <15899.21204.884559.523678@robur.slu.se>
	<Pine.LNX.4.44.0301080059060.1128-100000@sp-laptop.isdn.scali.no>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Before it's get forgotten...

Cheers.
						--ro


--- NAPI_HOWTO.txt.orig	2002-12-24 06:20:31.000000000 +0100
+++ NAPI_HOWTO.txt	2003-01-09 13:25:30.000000000 +0100
@@ -721,6 +721,23 @@
 
 
 
+
+APPENDIX 3: Scheduling issues.
+==============================
+As seen NAPI moves processing to softirq level. Linux uses the ksoftirqd as the 
+general solution to schedule softirq's to run before next interrupt and by putting 
+them under scheduler control. Also this prevents consecutive softirq's from 
+monopolize the CPU. This also have the effect that the priority of ksoftirq needs 
+to be considered when running very CPU-intensive applications and networking to
+get the proper balance of softirq/user balance. Increasing ksoftirq priority to 0 
+(eventually more) is reported cure problems with low network performance at high 
+CPU load.
+
+Most used processes in a GIGE router:
+USER       PID %CPU %MEM  SIZE   RSS TTY STAT START   TIME COMMAND
+root         3  0.2  0.0     0     0  ?  RWN Aug 15 602:00 (ksoftirqd_CPU0)
+root       232  0.0  7.9 41400 40884  ?  S   Aug 15  74:12 gated 
+
 --------------------------------------------------------------------
 
 relevant sites:
