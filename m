Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264219AbTFBXW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 19:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264221AbTFBXW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 19:22:28 -0400
Received: from franka.aracnet.com ([216.99.193.44]:42375 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264219AbTFBXW0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 19:22:26 -0400
Date: Mon, 02 Jun 2003 16:35:40 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 767] New: in ieee1394 file iso.c fails to compile
Message-ID: <209840000.1054596940@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


           Summary: in ieee1394 file iso.c fails to compile
    Kernel Version: 2.5.70
            Status: NEW
          Severity: normal
             Owner: bcollins@debian.org
         Submitter: donaldlf@i-55.com


Distribution:redhat
Hardware Environment:Alpha PC164LX
Software Environment:Rawhide

Problem Description:

file fails to compile (as module embedded untested)
drivers/ieee1394/iso.c: In function `hpsb_iso_xmit_sync':
drivers/ieee1394/iso.c:355: arithmetic on pointer to an incomplete type
drivers/ieee1394/iso.c:355: warning: implicit declaration of function
`set_current_state'
drivers/ieee1394/iso.c:355: `TASK_INTERRUPTIBLE' undeclared (first use in this
function)
drivers/ieee1394/iso.c:355: (Each undeclared identifier is reported only once
drivers/ieee1394/iso.c:355: for each function it appears in.)
drivers/ieee1394/iso.c:355: warning: implicit declaration of function
`signal_pending'
drivers/ieee1394/iso.c:355: arithmetic on pointer to an incomplete type
drivers/ieee1394/iso.c:355: warning: implicit declaration of function `schedule'
drivers/ieee1394/iso.c:355: arithmetic on pointer to an incomplete type
drivers/ieee1394/iso.c:355: dereferencing pointer to incomplete type
drivers/ieee1394/iso.c:355: `TASK_RUNNING' undeclared (first use in this function)
drivers/ieee1394/iso.c: In function `hpsb_iso_wake':
drivers/ieee1394/iso.c:431: `TASK_INTERRUPTIBLE' undeclared (first use in this
function)
make[2]: *** [drivers/ieee1394/iso.o] Error 1
make[1]: *** [drivers/ieee1394] Error 2
make: *** [drivers] Error 2

Steps to reproduce:

Select ieee1394 as an module and activate all items lower in the configuration
tree as an module

Solution

Add the line

# include <linux/sched.h>

between the following lines (line number 11)

# include <linux/slab.h>
# include "iso.h"


