Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbUFSF0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUFSF0R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 01:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUFSF0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 01:26:17 -0400
Received: from mail016.syd.optusnet.com.au ([211.29.132.167]:448 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261907AbUFSF0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 01:26:14 -0400
Message-ID: <40D3CE68.2000403@kolivas.org>
Date: Sat, 19 Jun 2004 15:26:00 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7a (X11/20040614)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: Grzegorz Kulewski <kangur@polcom.net>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-ck1
References: <200406162122.51430.kernel@kolivas.org> <1087576093.2057.1.camel@teapot.felipe-alfaro.com> <Pine.LNX.4.58.0406182004370.32121@alpha.polcom.net> <200406191406.45750.kernel@kolivas.org>
In-Reply-To: <200406191406.45750.kernel@kolivas.org>
Content-Type: multipart/mixed;
 boundary="------------040403060900080007010103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040403060900080007010103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:
> On Sat, 19 Jun 2004 04:35, Grzegorz Kulewski wrote:
> 
>>Hi Con,
>>
>>I have two problems with 2.6.7-ck1. My distribution is Gentoo Linux
>>unstable with all latest updates. Oh, yes, both 2.6.7-ck1 and 2.6.7-rc3
>>I tested have vesafb-tng applied from http://dev.gentoo.org/~spock/, but
>>it should not cause any problems because it is very non-intrusive patch I
>>think. Maybe you should include this in your patchset?
>>
>>1. When booting init script freezes after starting input hotplugging (it
>>is udev system). The only way to make it run is to press Ctrl-Alt-SysRQ
>>and various keys to display kernel state several times. After that system
>>starts normally. I do not know if it is only -ck problem because I had
>>no time to test 2.6.7 vanilla, but 2.6.7-rc3 worked fine. (Log included.)
> 
> 
> Yes I have a sneaking suspicion it's related to the fact kernel threads are 
> fixed priority at the moment in staircase (they dont descend priority like 
> normal tasks so act like relatively low priority real time tasks). I'm 
> addressing that for the next version so hopefully that will fix it.

Here's a diff for -ck1 which brings you up to staircase7.1
Can you try that?

Con

--------------040403060900080007010103
Content-Type: text/x-troff-man;
 name="from-2.6.7-ck1_to_staircase7.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="from-2.6.7-ck1_to_staircase7.1"

--- linux-2.6.7-ck2pre/kernel/sched.c	2004-06-19 15:12:15.280924354 +1000
+++ linux-2.6.7-ck1/kernel/sched.c	2004-06-19 14:58:08.000000000 +1000
@@ -334,8 +334,7 @@ static int effective_prio(task_t *p)
 
 	if (used_slice < first_slice)
 		return prio;
-	if (p->mm)
-		prio += 1 + (used_slice - first_slice) / rr;
+	prio += 1 + (used_slice - first_slice) / rr;
 	if (prio > MAX_PRIO - 2)
 		prio = MAX_PRIO - 2;
 	return prio;

--------------040403060900080007010103--
