Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267173AbSLEB1F>; Wed, 4 Dec 2002 20:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267175AbSLEB1F>; Wed, 4 Dec 2002 20:27:05 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:21642 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id <S267173AbSLEB1E>;
	Wed, 4 Dec 2002 20:27:04 -0500
Date: Thu, 5 Dec 2002 01:34:41 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: Process verification while running
Message-ID: <Pine.LNX.4.44.0212050125420.14956-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	I have an embedded Linux project that requires (by standards +
laws) that all code running in the system be verified against prestored
CRCs at a number of stages of execution.... (and they mean all code : both
kernel and userspace) to protect against memory issue and tampering. I
don't wish to debate the merits of these ideas, they are cast in stone,
what I want to know what is the best approach to doing this under Linux?
There is no swap in the system, and all process will be running with
mlockall().

For the kernel I'm going to add a kernel thread that loops over the text
segment verifying integrity.

For userspace I was initially going to use a userspace daemon that reads
via /proc/pid/mem interface and tests the text segments against what I
hope is in there.. but this seems to be a problem as I need to ptrace
attach the process (which starts sending SIGSTOPs around when the process
gets a signal) to get a /proc/pid/mem.

My other option is to implement my own kernel module to do the work, and
have a kernel thread running around.. I'd have to feed it the CRCs and
stuff at the start and let it go...

Could I remove the check that stops other processes reading /proc/pid/mem?
safely enough considering this system runs embedded with very little scope
for outside interference...

Thanks,
Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


