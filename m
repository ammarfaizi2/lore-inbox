Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264588AbSIQT6l>; Tue, 17 Sep 2002 15:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264590AbSIQT6l>; Tue, 17 Sep 2002 15:58:41 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:8140 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S264588AbSIQT6j>; Tue, 17 Sep 2002 15:58:39 -0400
Message-ID: <3D878A90.F5E4B8B0@us.ibm.com>
Date: Tue, 17 Sep 2002 15:03:28 -0500
From: Duc Vianney <dvianney@us.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Hyperthreading performance on 2.4.19 and 2.5.32
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following are data comparing the effects of hyperthreading (HT)on
stock kernel 2.4.19 and 2.5.32.
Hardware under test. The hardware is a Xeon 1-CPU MP, 1.6 gigahertz,
and 2.5 GB RAM.
Kernel under test. When testing under 2.4.19, the kernel was built
as an SMP kernel, and was run on the hardware with HT enabled through
the boot option 'noht'. When testing under 2.5.32, the kernel was
built as an SMP kernel, and was run on the hardware with HT enabled
through selecting ACPI in configuration.
Benchmarks. For multithreaded benchmarks: chat, dbench and tbench.
Summary of results. The results on Linux kernel 2.4.19 show HT might
improve multithreaded application by as much as 30%. On kernel 2.5.32,
HT may provide speed-up as high as 60%.
Observations. There are two major differences between 2.4.19 and
2.5.32 which could affect HT performance: O(1)scheduler and Ingo's
shared runqueue patch for HT that went in 2.5.32. However, Ingo's HT
patch is for handling load balancing, affinity, and task pickup. Those
are problems that exist in systems with >= 2CPUs. Since I have only
1-CPU in my test, I think the O(1) scheduler has had greater impact
than the runqueue patch. On 2.5.32, the chat workload seems to benefit
the most, followed by tbench and dbench.
The data for each number of chat rooms run (e.g., 20) represents the
geometric mean of five runs. Same method was also used for each number
of clients run in dbench and tbench.

chat workload     2.4.19     2.5.32
No. chat rooms   Speed-up   Speed-up
     20            24%        51%
     30            22%        41%
     40            22%        60%
     50            28%        39%
Geometric Mean     24%        45%

dbench workload   2.4.19     2.5.32
No.clients       Speed-up   Speed-up
     20            29%        27%
     30            29%         9%
     60            12%         1%
     90             9%         4%
    120            16%        23%
Geometric Mean     18%        12%

tbench workload   2.4.19     2.5.32
No.clients       Speed-up   Speed-up
     20            31%        36%
     30            30%        36%
     60            26%        36%
     90            22%        35%
    120            27%        33%
Geometric Mean     27%        35%

Duc Vianney - dvianney@us.ibm.com

