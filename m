Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267035AbSKTBAf>; Tue, 19 Nov 2002 20:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267135AbSKTBAf>; Tue, 19 Nov 2002 20:00:35 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:56244 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267035AbSKTBAe>;
	Tue, 19 Nov 2002 20:00:34 -0500
Subject: gettimeofday() cripples notsc system
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Nov 2002 17:06:25 -0800
Message-Id: <1037754386.3393.255.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,

Running a large application that issues many gettimeofday()
system calls on a kernel running with notsc, results in time
slowing way down.  I've seen the system time advance only 
three minutes over a 30 minute period.  The following program,
executed twice demonstrates the problem.  Three instances running
in parallel made a 16 processor machine completely unusable.

#include <sys/time.h>

main()
{
        struct timeval  tv;
        struct timezone tz;
        while (1) 
                if (gettimeofday(&tv, &tz)) 
                        return;
}

I've recreated on 2.5.30, 2.5.44, and 2.5.47.  Running a system that
is using the tsc I've tried 100 instances of this test running in
parallel with no problems - other than the normal incorrect time due 
to tsc skew.  At least no time slowdowns or hangs.  The system I'm 
using is a 4 node NUMAQ (x86) box.

I assume there is a lock starvation problem happening here, correct?
Any chance of fixing this?
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

