Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267535AbTAGWfh>; Tue, 7 Jan 2003 17:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267536AbTAGWfh>; Tue, 7 Jan 2003 17:35:37 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:4778 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267535AbTAGWfg> convert rfc822-to-8bit;
	Tue, 7 Jan 2003 17:35:36 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Andrew Theurer <habanero@us.ibm.com>
To: nitin.a.kamble@intel.com
Subject: RE: [PATCH][2.4] generic cluster APIC support for systems with more than 8 CPUs
Date: Tue, 7 Jan 2003 16:42:39 -0600
User-Agent: KMail/1.4.3
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       jamesclv@us.ibm.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301071642.39321.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi Martin,
>  Would somebody get a chance to try the kirq patch out? If yes, please
>let me know, how the patch did on your systems. Did your guys find any
>issues with it? I will also appreciate more comments.
>
>Thanks & Regards,
>Nitin

Nitin,

I am seeing if I can get together a test for Netbench with/without your patch.  
Looking at the patch, I would expect a slight increase in performance.  I'll 
let you know the results as soon as I have them.  

I do have one question for you:  Have you tested netperf using only one 
gigabit adapter?  If so, have you been able to max out the adapter when using 
hyperthreading?  If not, could you test this?  So far I have not been able 
to, while I can quite easily with no hyperthreading (in Netbench). This is 
the case with both irq_balance and irq affinity.  having ints processed by 
one and only one logical CPU at one time really seems to bottleneck network 
throughput.  I'm sure some of this has to do with sharing those resources 
among 2 logical CPUs, but I also wonder if int processing is just a lot 
slower than P3 overall. 

I am bringing this up, because I recall James Cleverdon having some code which 
allows interrupts to be dynamically routed to two CPU destinations, a pair of 
CPUs with consecutive CPU ID's.  Interrupts are dynamically routed to the 
least loaded CPU, and if both are idle, to the CPU with the lower CPUID.  I 
like this idea, because when in HT, if consecutive logical CPU ID's map to 
one physical core, we get to use "whole" processor, and both destinations 
share the cache.  Anyway, just a thought. 

-Andrew Theurer
