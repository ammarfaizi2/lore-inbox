Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbTFSC2u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 22:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265703AbTFSC2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 22:28:50 -0400
Received: from franka.aracnet.com ([216.99.193.44]:62139 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265701AbTFSC2t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 22:28:49 -0400
Date: Wed, 18 Jun 2003 19:42:41 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 830] New: ltp ajdtimex failures 
Message-ID: <4610000.1055990561@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: ltp ajdtimex failures
    Kernel Version: 2.5.72
            Status: NEW
          Severity: normal
             Owner: johnstul@us.ibm.com
         Submitter: johnstul@us.ibm.com


Distribution: SUSE 
Hardware Environment: AMD64/i386 
Software Environment: ltp-full-20030606 
Problem Description: 
	ltp adjtimex01 and adjtimex02 tests fail.  
 
Steps to reproduce: 
	Boot a 2.5.72 kernel 
	Run ltp 
 
The problem is related to some time cleanups that went in recently. TICK_USEC has 
been changed to be based off of TICK_NSEC which is ACTHZ based. However 
TICK_USEC should be USER_HZ based.  The kernel rejects adjtimex changes to 
timex.tick (tick_usec)  if the value is outside 9,000->11,000 usecs per tick 
(USER_HZ=100), however now TICK_USEC is ACTHZ based, adjtimex is returning 
timex.tick values ~1,000 usecs per tick (HZ=1000).  
 
Currently working with George Anzinger and Eric Piel to resolve this issue.

