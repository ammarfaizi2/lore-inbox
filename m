Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSFTNHt>; Thu, 20 Jun 2002 09:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314381AbSFTNHs>; Thu, 20 Jun 2002 09:07:48 -0400
Received: from draco.netpower.no ([212.33.133.34]:40197 "EHLO
	draco.netpower.no") by vger.kernel.org with ESMTP
	id <S314340AbSFTNHr>; Thu, 20 Jun 2002 09:07:47 -0400
Date: Thu, 20 Jun 2002 15:07:30 +0200
From: Erlend Aasland <erlend-a@innova.no>
To: Felipe Alfaro Solana <falfaro@borak.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.23 won't compile
Message-ID: <20020620150730.A12658@innova.no>
References: <3D11CDED.4070106@borak.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3D11CDED.4070106@borak.es>; from falfaro@borak.es on Thu, Jun 20, 2002 at 02:43:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 02:43:25PM +0200, Felipe Alfaro Solana wrote:
>     sched.c: In function `sys_sched_getaffinity':
>     sched.c:1391: `cpu_online_map' undeclared (first use in this function)

This was fixed by Linus with this patch (it is in Linus' BK repository):

--- a/include/linux/smp.h       Wed Jun 19 00:00:41 2002
+++ b/include/linux/smp.h       Wed Jun 19 00:00:41 2002
@@ -86,6 +86,7 @@
 #define smp_call_function(func,info,retry,wait)        ({ 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
 +#define cpu_online_map                        1
 #define cpu_online(cpu)                                1
 #define num_online_cpus()                      1
 #define __per_cpu_data


 Mvh Erlend Aasland

 P.S. BTW, this has already been asked twice on this list:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102447447725526&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=102445697313894&w=2
 The linux-kernel archives at http://marc.theaimsgroup.com/?l=linux-kernel
 is a nice place to check if somebody already has asked a question.
