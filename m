Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750780AbWFEUrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWFEUrF (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWFEUrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:47:05 -0400
Received: from father.pmc-sierra.com ([216.241.224.13]:8371 "HELO
	father.pmc-sierra.bc.ca") by vger.kernel.org with SMTP
	id S1750780AbWFEUrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:47:04 -0400
Message-ID: <478F19F21671F04298A2116393EEC3D52741E7@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>
To: linux-kernel@vger.kernel.org
Subject: process starvation with 2.6 scheduler
Date: Mon, 5 Jun 2006 13:46:58 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Kallol Biswas 
Sent: Monday, June 05, 2006 12:49 PM
To: 'linux-kernel@vger.kernel.org'
Subject: process starvation with 2.6 scheduler

Hello,
       We have a process starvation problem with our 2.6.11 kernel running on a ppc-440 based system.

We have a storage SOC based on PPC-440. The SOC is emulated on a system emulator called Palladium. It is from Cadence. The system runs at 400KHz speed. It has three Ethernet ports; they are connected to outside lab network with a speed bridge.

The netperf server netserver runs on the emulated system (2.6.11 kernel on Palladium). There are netperf linux clients running on a x86 box.

If netperf request response (TCP_RR) traffic is run on all three ports; after sometime only one port remains active, the application (netperf client) on other two ports wait for a long time and eventually time out.

The netserver code has been instrumented. For one of the starved netserver processes it has been found that the TCP_RR request from the netperf client on linux x86 box has been received by the server, it has issued send() call to send back reply but send() never returns.

With an ICE connected to the Palladium (emulator) I have dumped the kernel data structures of the starved process and the active process. 


For Active  Process:
  Time_slice 84
  Policy : SCHED_NORMAL
  Dynamic priority: 118
  Static priority: 120
  Preempt_count: 0x20100
  Flags = 0
  State = 0 (TASK_RUNNING)

For Starved Process:
  Time slice: 77
  Policy: SCHED_NORMAL
  Dynamic priority: 120
  Static priority: 120
  Preempt_count: 0x10000000 (PREEMPT_ACTIVE is set)
  Flags = 0 
  State = 0 (TASK_RUNNING)



CONFIG_PREEMPT is not set.
The system has single CPU.


Any help to debug the problem is welcome. 

Kallol
