Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267687AbTCFFGx>; Thu, 6 Mar 2003 00:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267775AbTCFFGx>; Thu, 6 Mar 2003 00:06:53 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:22436 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267687AbTCFFGw> convert rfc822-to-8bit; Thu, 6 Mar 2003 00:06:52 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: <linux-kernel@vger.kernel.org>
Subject: HT and idle = poll
Date: Wed, 5 Mar 2003 23:18:04 -0600
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303052318.04647.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The test:  kernbench (average of  kernel compiles5) with -j2 on a 2 physical/4 
logical P4 system.  This is on 2.5.64-HTschedB3:

idle != poll: Elapsed: 136.692s User: 249.846s System: 30.596s CPU: 204.8%
idle  = poll: Elapsed: 161.868s User: 295.738s System: 32.966s CPU: 202.6%

A 15.5% increase in compile times.

So, don't use idle=poll with HT when you know your workload has idle time!  I 
have not tried oprofile, but it stands to reason that this would be a 
problem.  There's no point in using idle=poll with oprofile and HT anyway, as 
the cpu utilization is totally wrong with HT to begin with (more on that 
later).

Presumably a logical cpu polling while idle uses too many cpu resources 
unnecessarily and significantly affects the performance of its sibling. 

-Andrew Theurer

