Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbTAOHjc>; Wed, 15 Jan 2003 02:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265791AbTAOHjc>; Wed, 15 Jan 2003 02:39:32 -0500
Received: from franka.aracnet.com ([216.99.193.44]:45800 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265786AbTAOHjb>; Wed, 15 Jan 2003 02:39:31 -0500
Date: Tue, 14 Jan 2003 23:47:45 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Andrew Theurer <habanero@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>
cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
Message-ID: <832910000.1042616864@titus>
In-Reply-To: <200301141723.29613.efocht@ess.nec.de>
References: <52570000.1042156448@flay> <200301141214.12323.efocht@ess.nec.de> <200301141655.06660.efocht@ess.nec.de> <200301141723.29613.efocht@ess.nec.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, ran some tests on incremental version of the stack.
newsched3 = patches 1+2+3 ... etc.
oldsched = Erich's old code + Michael's ilb.
newsched4-tune = patches 1,2,3,4 + tuning patch below:

Tuning seems to help quite a bit ... need to stick this into arch topo code.
Sleep time now ;-)

Kernbench:
                                   Elapsed        User      System         CPU
                   2.5.58-mjb1     19.522s    186.566s     41.516s     1167.8%
          2.5.58-mjb1-oldsched     19.488s     186.73s     42.382s     1175.6%
         2.5.58-mjb1-newsched2     19.286s    186.418s     40.998s     1178.8%
         2.5.58-mjb1-newsched3      19.58s    187.658s     43.694s     1181.2%
         2.5.58-mjb1-newsched4     19.266s    187.772s     42.984s     1197.4%
    2.5.58-mjb1-newsched4-tune     19.424s    186.664s     41.422s     1173.6%
         2.5.58-mjb1-newsched5     19.462s    187.692s      43.02s       1185%

NUMA schedbench 4:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                   2.5.58-mjb1                                                
          2.5.58-mjb1-oldsched        0.00       35.16       88.55        0.68
         2.5.58-mjb1-newsched2        0.00       19.12       63.71        0.48
         2.5.58-mjb1-newsched3        0.00       35.73       88.26        0.58
         2.5.58-mjb1-newsched4        0.00       35.64       88.46        0.60
    2.5.58-mjb1-newsched4-tune        0.00       37.10       91.99        0.58
         2.5.58-mjb1-newsched5        0.00       35.34       88.60        0.64

NUMA schedbench 8:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                   2.5.58-mjb1        0.00       35.34       88.60        0.64
          2.5.58-mjb1-oldsched        0.00       64.01      338.77        1.50
         2.5.58-mjb1-newsched2        0.00       31.56      227.72        1.03
         2.5.58-mjb1-newsched3        0.00       35.44      220.63        1.36
         2.5.58-mjb1-newsched4        0.00       35.47      223.86        1.33
    2.5.58-mjb1-newsched4-tune        0.00       37.04      232.92        1.14
         2.5.58-mjb1-newsched5        0.00       36.11      223.14        1.39

NUMA schedbench 16:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                   2.5.58-mjb1        0.00       36.11      223.14        1.39
          2.5.58-mjb1-oldsched        0.00       62.60      834.67        4.85
         2.5.58-mjb1-newsched2        0.00       57.24      850.12        2.64
         2.5.58-mjb1-newsched3        0.00       64.15      870.25        3.18
         2.5.58-mjb1-newsched4        0.00       64.01      875.17        3.10
    2.5.58-mjb1-newsched4-tune        0.00       57.84      841.48        2.96
         2.5.58-mjb1-newsched5        0.00       61.87      828.37        3.47

NUMA schedbench 32:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                   2.5.58-mjb1        0.00       61.87      828.37        3.47
          2.5.58-mjb1-oldsched        0.00      154.30     2031.93        9.35
         2.5.58-mjb1-newsched2        0.00      117.75     1798.53        5.52
         2.5.58-mjb1-newsched3        0.00      122.87     1771.71        8.33
         2.5.58-mjb1-newsched4        0.00      134.86     1863.51        8.27
    2.5.58-mjb1-newsched4-tune        0.00      118.18     1809.38        6.58
         2.5.58-mjb1-newsched5        0.00      134.36     1853.94        8.33

NUMA schedbench 64:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                   2.5.58-mjb1        0.00      134.36     1853.94        8.33
          2.5.58-mjb1-oldsched        0.00      318.68     4852.81       21.47
         2.5.58-mjb1-newsched2        0.00      241.11     3603.29       12.70
         2.5.58-mjb1-newsched3        0.00      258.72     3977.50       16.88
         2.5.58-mjb1-newsched4        0.00      252.87     3850.55       18.51
    2.5.58-mjb1-newsched4-tune        0.00      235.43     3627.28       15.90
         2.5.58-mjb1-newsched5        0.00      265.09     3967.70       18.81

--- sched.c.premjb4     2003-01-14 22:12:36.000000000 -0800
+++ sched.c     2003-01-14 22:20:19.000000000 -0800
@@ -85,7 +85,7 @@
 #define NODE_THRESHOLD          125
 #define MAX_INTERNODE_LB 40
 #define MIN_INTERNODE_LB 4
-#define NODE_BALANCE_RATIO 10
+#define NODE_BALANCE_RATIO 250
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -763,7 +763,8 @@
                        + atomic_read(&node_nr_running[i]);
                this_rq()->prev_node_load[i] = load;
                if (load > maxload &&
-                   (100*load > ((NODE_THRESHOLD*100*this_load)/100))) {
+                   (100*load > (NODE_THRESHOLD*this_load))
+                   && load > this_load + 4) {
                        maxload = load;
                        node = i;
                }


