Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTIITFa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTIITFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:05:30 -0400
Received: from law10-oe33.law10.hotmail.com ([64.4.14.90]:40967 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264030AbTIITFU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:05:20 -0400
X-Originating-IP: [208.48.228.132]
X-Originating-Email: [jyau_kernel_dev@hotmail.com]
From: "John Yau" <jyau_kernel_dev@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Cc: <miller@techsource.com>
Subject: Re: Use of AI for process scheduling
Date: Tue, 9 Sep 2003 15:05:08 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <Law10-OE33H7cvO49sK0000ac5c@hotmail.com>
X-OriginalArrivalTime: 09 Sep 2003 19:05:19.0701 (UTC) FILETIME=[4FFCB850:01C37705]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>You talk about weights. Would the linux community be willing to put a
neural net into the kernel? I'm
>sure we could optimize it to not take a lot of processing overhead, but
it's an "unknown".

A neural net is a bad idea in something that requires very low processing
overhead.  There's really no way you can optimize it except through hardware
assistance (i.e. a neural network chip).  You have to iterate through every
node and every connection in the neural to get a result, there's no escape
from that.  Too much computing overhead to be of much use in today's general
purpose processors.

>It would
>be scary to some people to be unable to disect the actual workings of it
and have no way of
>determining corner-case behavior from examining code. But if we have, say,
only a 2-layer neural
>net, we might still be able to reverse-engineer it.

You need at the minimum 3 layers to simulate xor, which is a very important
logic function in any decision process, in a feed forward NN (the one you're
describing?).  NNs in general make decent nonlinear classifiers and not much
beyond that, so I doubt even if we were to reverse engineer it, it'd be very
useful except to classify tasks (e.g. CPU hog or not CPU hog), which can
already be done with very simple heuristics.  Most folks doing research in
AI tend to stay away from NNs these days, and use standard linear
regressions, decision trees, hidden markov models, and etc to do classifier
work.

>One thing I was thinking of is that if there is some information about a
process which is inconvenient
>to get normally but could be accessed by a kernel or user-space thread,
then this process could
>feed back info to the scheduler AI for it to do automatic tuning. Some
information that the scheduler
>doesn't have direct (or efficient) access to could be inferred from
information it DOES have access
>to, and that would be learned through adjustment of weights via
backpropogation.

Again, backpropagation training is computationally very very expensive
(actually a order of magnitude more expensive than extracting results from a
NN).  Using gradient descent, to "learn" something, you have to adjust every
single connection weight in the network thousands of times.  To have AI to
schedule something in realtime is asking too much right now and to put it
simply not necessary.

Where I do see AI can solve some problems is when we expose "tuning knobs"
and need some way to get optimal values offline and not realtime.  A very
good example is the connection matrix in the KLAT II beowulf cluster where
they used genetic algorithms to solve for the optimal solution.  In the
current scheduler situation I can see using genetic algorithms to get
optimal values for Ingo, Con, or Nick's schedulers so they can get compiled
into the scheduler.



John Yau
