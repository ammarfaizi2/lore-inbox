Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbUBEFS5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 00:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbUBEFS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 00:18:57 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:56993 "EHLO
	omta06.mta.everyone.net") by vger.kernel.org with ESMTP
	id S264359AbUBEFSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 00:18:55 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Wed, 4 Feb 2004 21:17:36 -0800 (PST)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: US/KS performance question
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.187.247]
Message-Id: <20040205051736.89307CF33@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC me all replies.

I'm doing a little work on ACLs.  Instead of a LSM, I'm writing up a little bit
of code and some hooks to allow a userspace daemon to do the decision making.

The plan is as follows:

 - acld connects to kernel, sleeps.
 - Kernel needs to ask something of acld, ques request in US
 - Kernel wakes acld up
 - Kernel puts the requesting thread to sleep
 - acld processes requests
 - Each request processed is followed by a syscall to the kernel with the result
 - Kernel takes the result, finds the thread that wanted it, wakes thread up
 - When there's no more requests, acld sleeps

Now, I have two major bottlenecks:
 - Userspace acld MAC daemon has to make a syscall and pass data from US to KS
 - Kernel has to sometimes wake up acld and always has to wake up the requesting
   thread after getting the result back from acld

Any ideas on how much overhead this could add?  If it takes only a few more
microseconds to wake up acld, sleep the process, process the syscall, and finally
wake the process; as opposed to calling a kernel function to make the decision,
then it should be okay.  If it's going to be some 10 or 20 miliseconds per request,
I might have problems.  If it's going to take more than 100 mS for this, I need
a redesign.

_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
