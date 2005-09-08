Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbVIHFjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVIHFjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 01:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbVIHFjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 01:39:13 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:23234 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932529AbVIHFjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 01:39:12 -0400
Date: Thu, 8 Sep 2005 14:39:11 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] SUBCPUSETS: a resource control functionality using
 CPUSETS
X-Mailer: Sylpheed version 2.1.0+svn (GTK+ 2.6.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050908053912.1352770031@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset adds resource control functionality to the 
CPUSETS code by subdividing a cpuset into smaller pieces (SUBCPUSETS).
It is made up from two parts, one for the resource control framework 
and another for the specific resource controller.  Resource controllers
can be added by using interfaces provided by the SUBCPUSETS.

For now, it enables us to guarantee the CPU time percentage that tasks 
attached to the subcpuset consume.  The memory resource controller code 
is coming soon.

The patchset is for linux-2.6.13 and consists of 5 patches:
[1/5] Fixes minor problem in the current CPUSETS.
[2/5] Implements resource control framework functionality to the CPUSETS
      (SUBCPUSETS).
[3/5] Adds document for SUBCPUSETS.
[4/5] Implements the CPU time resource controller.
[5/5] Puts the CPU time resource controller into SUBCPUSETS.


The following step might be to useful see how this patchset works:

# mount -t cpuset none /dev/cpuset
	(mount the cpuset filesystem)
# /bin/echo 1 > /dev/cpuset/subcpuset_top
	(declare that the cpuset is the toplevel directory of subcpusets;
	you can declare the toplevel directory of subcpusets other than
	the root cpuset of course)
# mkdir /dev/cpuset/sub-a
# mkdir /dev/cpuset/sub-b
	(create subcpuset directories)
# /bin/echo 20 > /dev/cpuset/sub-a/cpu_guar
	(guarantee 20% of the CPU time usage to tasks in the "sub-a" subcpuset)
# /bin/echo 80 > /dev/cpuset/sub-b/cpu_guar
	(guarantee 80% of the CPU time usage to tasks in the "sub-b" subcpuset)
# echo $$ > /dev/cpuset/sub-a/tasks
	(change the cpuset of the shell to the "sub-a" subcpuset)
# (while true; do true; done)&
	(start a CPU consuming process in sub-a subcpuset)
# echo $$ > /dev/cpuset/sub-b/tasks
	(change the cpuset of the shell to the "sub-b" subcpuset)
# (while true; do true; done)&
	(start a CPU consuming process in sub-b subcpuset)
# top
	(see how subcpusets works)


Thanks,

KUROSAWA, Takahiro
