Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264087AbTFDVS4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbTFDVS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:18:56 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:32137 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264087AbTFDVSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:18:54 -0400
Message-ID: <3EDE63FE.1010603@us.ibm.com>
Date: Wed, 04 Jun 2003 14:26:22 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: [patch] use valid value when unmapping cpus
Content-Type: multipart/mixed;
 boundary="------------040408050801090203070009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040408050801090203070009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

For some unknown reason, we stick a -1 in cpu_2_node when we unmap a cpu 
on i386.  We're better off sticking a 0 in there, because at least 0 is 
a valid value if something references it.  -1 is only going to cause 
problems at some point down the line.  Besides, we initialize the array 
with 0's, so undoing it should return it to that same value.

Cheers!

-Matt

--------------040408050801090203070009
Content-Type: text/plain;
 name="i386_smpboot_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386_smpboot_fix.patch"

--- linux-2.5.70-vanilla/arch/i386/kernel/smpboot.c	Mon Mar 24 14:00:35 2003
+++ linux-2.5.70-vanilla/arch/i386/kernel/smpboot.c.fixed	Wed Apr  2 18:23:06 2003
@@ -520,7 +520,7 @@
 	printk("Unmapping cpu %d from all nodes\n", cpu);
 	for (node = 0; node < MAX_NR_NODES; node ++)
 		node_2_cpu_mask[node] &= ~(1 << cpu);
-	cpu_2_node[cpu] = -1;
+	cpu_2_node[cpu] = 0;
 }
 #else /* !CONFIG_NUMA */
 

--------------040408050801090203070009--

