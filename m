Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271445AbTGQRG6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 13:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271493AbTGQRG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 13:06:58 -0400
Received: from franka.aracnet.com ([216.99.193.44]:60858 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S271445AbTGQRG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 13:06:56 -0400
Date: Thu, 17 Jul 2003 10:21:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 949] New: System was crashed during hammerhead/apache test (Kernel Oops happened) 
Message-ID: <27020000.1058462495@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=949

           Summary: System was crashed during hammerhead/apache test (Kernel
                    Oops happened)
    Kernel Version: 2.6.0-test1
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: zhanga@us.ibm.com


Distribution: SuSE 8.0
Hardware Environment: 
           CPU : AMD Athlon(tm) Processor(2-way); cpu MHz: 1194.857;    
                 cache size: 256KB
           Memory: total 513MB

Software Environment:
           Kernel(server system): 2.6.0-test1
           Apache(server system): httpd-2.0.45
           Hammerhead(client system): 2.4.18-4GB,hammerhead-2.1.2
Problem Description:
           Started a 96-hour hammerhead against apache server. The number of 
           sections to simulate(thread) was 50. After it ran for about 24 hours, 
           the system was crashed and got the following information on screen:
Oops: 0000[#1]
CPU: 1
EIP: 0060:[<c011f15f>] Not tainted
EFLAGS: 00010883
EIP is at release_task + 0x1e0
eax: 00000000 ebx: d4b42670 ecx: 6b6b6b6b edx: 6b6b6b6b esi: 00000000 
edi: 00000000 ebp: bffff260 esp: c6ea1f40 ds: 007b es: 007b ss: 0068
Process httpd (pid: 4560, threadinfo = c6ea0000, tesk = d83cd310)
Stack: d4b42670 00003a03 c0120682 d4b40270 00003a03 d4b42714 d4b42670 d83cd310
       00000001 00000246 c0120e8d d4b42670 bffff260 00000000 00003a03 00000000
       bffff260 c6ea0000 00000001 d83cd3ac c6ea0000 00000001 00000000 d83cd310
Call Trace:
       [<c012ob82>] Wait_task_zombie + 0x172/0x190
       [<c0120e8d>] Sys_wait4 + 0x13d/0x260
       [<c0119aa0>] default_wake_function + 0x0/0x20
       [<c0109123>] syscall_call + 0x7/0xb

Code: 8b 50 0c 83 c0 0c 39 02 75 19 8b 01 83 f8 08 75 12 8b 41 6c

Steps to reproduce:
       1. Downloaded 2.6.0-test1 from kernel.org tree and built it, reboot
       2. Installed apache server(httpd-2.0.45) on system and start it
       3. Choose a client system with 2.4 kernel on it; 
          installed hammerhead-2.1.2; 
          cd to /etc/hammerhead; 
          vi post.scn file and put the following lines in it:
                NSample GET
                RGET /cgi-bin/test-cgi
                T0
          rm root.scn
          create a hammerhead scenario file to run hammerhead:
                Set up section number to be 50
                Set up run time to be 96 hours
          run the following command to start hammerhead:
                hammerhead -c hammerhead-scenario

      4. The system crashed after about 24 hours in my case.

