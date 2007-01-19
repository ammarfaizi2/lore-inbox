Return-Path: <linux-kernel-owner+w=401wt.eu-S932840AbXASSnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932840AbXASSnZ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 13:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932841AbXASSnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 13:43:25 -0500
Received: from chicken.visionpro.com ([63.91.95.13]:44416 "EHLO
	chicken.machinevisionproducts.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932840AbXASSnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 13:43:24 -0500
X-Ninja-PIM: Scanned by Ninja
X-Ninja-AttachmentFiltering: (no action)
User-Agent: Microsoft-Entourage/11.3.3.061214
Date: Fri, 19 Jan 2007 10:43:13 -0800
Subject: Threading...
From: Brian McGrew <brian@visionpro.com>
To: <linux-kernel@vger.kernel.org>, <fedora-users@rdhat.com>
Message-ID: <C1D65141.16E37%brian@visionpro.com>
Thread-Topic: Threading...
Thread-Index: Acc7+ax76v5J66fsEdu+HwADk9KF+g==
Mime-version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a very interesting question about something that we're seeing
happening with threading between Fedora Core 3 and Fedora Core 5.  Running
on Dell PowerEdge 1800 Hardware with a Xeon processor with hyper-threading
turned on.  Both systems are using a 2.6.16.16 kernel (MVP al la special).

We have a multithreaded application that starts two worker threads.  On
Fedora Core 3 both of these we use getpid() to get the PID of the thread and
then use set_afinity to assign each thread to it's own CPU.  Both threads
run almost symmetrically even on their given CPU watching the system
monitor.

On Fedora Core 5 with whatever new threading mechanism is being used, getpid
no longer works on threads, it returns the same PID as the parent program.
So we're using _pthread_self to get a u_long thread id back.  However,
set_afinity doesn't accept that, it wants a real PID.  So we're leaving it
to the system to schedule the threads between the CPUS.

On FC3 the threads run on 2 CPUS in symmetry and almost in parallel.
However, the problem is on FC5 it doesn't work like that.  We're seeing the
threading is almost more serial, where one thread will run on CPU1 at 100%
then as it's finishing and the CPU utilization is coming down, thread two is
coming up to 100% on CPU2 and they're ping ponging back and forth ... Which
is costing us a lot of time!

What am I missing?  What do I need to do in FC5 or the kernel or the
threading library to get my threads to run in symmetric parallel again???

Thanks!

-- 

-brian

Brian McGrew    { brian@visionpro.com || brian@doubledimension.com }
--
> With hope comes chance,
    with chance comes destiny,
    with destiny comes fate,
    And with fate comes the courtesy flush!

