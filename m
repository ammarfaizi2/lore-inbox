Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbTIJCU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 22:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTIJCU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 22:20:56 -0400
Received: from law10-oe47.law10.hotmail.com ([64.4.14.19]:51984 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264626AbTIJCUy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 22:20:54 -0400
X-Originating-IP: [208.48.228.132]
X-Originating-Email: [jyau_kernel_dev@hotmail.com]
From: "John Yau" <jyau_kernel_dev@hotmail.com>
To: <piggin@cyberone.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: 
Date: Tue, 9 Sep 2003 22:20:45 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <Law10-OE471DczmBlrP0000b07a@hotmail.com>
X-OriginalArrivalTime: 10 Sep 2003 02:20:53.0604 (UTC) FILETIME=[2901DA40:01C37742]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Your mechanism is basically "backboost". Its how you get X to keep a
>high piroirity, but quite unpredictable. Giving a boost to a process
>holding a semaphore is an interesting idea, but it doesn't address the
>X problem.

Hmm...I'm actually curious why you called it "backboosting".  In academia
this approach first described in the paper here:

L. Sha, R. Rajkumar, and J. P. Lehoczky. Priority Inheritance Protocols: An
Approach to Real-Time Synchronization. In IEEE Transactions on Computers,
vol. 39, pp. 1175-1185, Sep. 1990.

is referred to as priority inheritance.  Is there significant difference
between your implementation and priority inheritance schemes implemented in
other OSes?  If so, why backboosting?

I was under the impression that pipes and IPC in general are synchronized
using some sort of semaphores/mutex...or does Linux use a different
mechanism for IPC and does away with user space synchronization all together
(e.g. flip-flop buffers with the kernel arbitrating all contention)?  IIRC
processes don't write to X directly and has to send data to X via IPC.  If
some futex derivative is used to synchronize the producers with X, then
making priority inheritable futexes would solve the problem.

>The scheduler in Linus' tree is basically obsolete now, so there isn't
>any point testing it really. Test Con's or my patches, and let us know
>if you're still having problems with sir dumps-a-lot.

Okay enough said, you and Con should get your patches merged into that tree
ASAP if they're ready.


John Yau
