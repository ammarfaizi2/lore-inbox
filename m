Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbTIFWmH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 18:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbTIFWmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 18:42:07 -0400
Received: from law10-oe62.law10.hotmail.com ([64.4.14.197]:48646 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261792AbTIFWmF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 18:42:05 -0400
X-Originating-IP: [208.48.228.132]
X-Originating-Email: [jyau_kernel_dev@hotmail.com]
From: "John Yau" <jyau_kernel_dev@hotmail.com>
To: "'Robert Love'" <rml@tech9.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Date: Sat, 6 Sep 2003 18:41:52 -0400
Message-ID: <000201c374c8$1124ee20$f40a0a0a@Aria>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <1062878664.3754.12.camel@boobies.awol.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-OriginalArrivalTime: 06 Sep 2003 22:42:04.0520 (UTC) FILETIME=[18395E80:01C374C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The rationale behind Ingo's patch is to "break up" the timeslices to give
better scheduling latency to 
>multiple tasks at the same priority. 
>So it is not "unnecessary context switches," just "extra context switches."

Hmm...my reasoning is that those switches are unnecessary because the
interactivity bonus/penalty will take care of breaking the timeslices up in
case of a CPU hog, albeit not at precise 25 ms granularity.  Though having
regularity in scheduling is nice, I think Ingo's patch somewhat negates the
purpose of having heterogenous time slice lengths.  I suspect Ingo's
approach will thrash the caches quite a bit more than mine; we should
definitely test this a bit to find out for sure.  Any suggestions on how to
go about that?

If we're going to do a context switch every 25 ms no matter what, we might
as well just make the scheduler a true real time scheduler, dump having
different time slice lengths and interactivity recalculations, and go
completely round robin with strictly enforced priorities and a single class
of time slice somewhere 1 to 5 ms long.


John Yau
