Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTKXQ6k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 11:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263801AbTKXQ6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 11:58:40 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:8389 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263800AbTKXQ6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 11:58:39 -0500
Date: Mon, 24 Nov 2003 09:23:39 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: berkley@cs.wustl.edu
Subject: [Bug 1584] New: 2.6.0-test10 hangs in aix79xxx after	iocell_workaround message 
Message-ID: <11330000.1069694619@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1584

           Summary: 2.6.0-test10 hangs in aix79xxx after iocell_workaround
                    message
    Kernel Version: 2.6.0-test10 SMP
            Status: NEW
          Severity: blocking
             Owner: andmike@us.ibm.com
         Submitter: berkley@cs.wustl.edu


Distribution:
Hardware Environment: P4-Xeon-2.4GHz 2GB Adaptec 39320/AIC7902
Software Environment: Redhat 9.0
Problem Description:
Booting 2.6.0-test10 fails in AIC79XX (spinlock problem?) after executing
iocell_workaround in aic79xx_core.c (last message with ahd_debug set to 15)
since there were no changes to aic* since -test9 (which works fine) I'm assuming
the problem is in scsi.c which has many changes, most involving adding spinlocks.
The aic79xx module is loaded in the kernel (=y, not as a module =m)
at compile time.

Steps to reproduce:

boot -test10 kernel with either a 39320 U320 scsi controller or the motherboard
equivalent the AIC7902. With no debug on, the kernel hangs hard (no
<ctrl-alt-del>) just after showing the IDE partitions.
Setting the module parameter ahd_debug=15 to enable lots of messages shows
printf("%s: Setting up iocell workaround\n", ahd_name(ahd)); at 5383 in
aic79xx.c as the last known entry in syslog.

