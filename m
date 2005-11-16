Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965178AbVKPCYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbVKPCYy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 21:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbVKPCYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 21:24:54 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:8073 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S965178AbVKPCYx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 21:24:53 -0500
X-IronPort-AV: i="3.97,335,1125903600"; 
   d="scan'208"; a="230882422:sNHT26677684"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC] [PATCH 00/13] Introduce task_pid api
Date: Tue, 15 Nov 2005 18:24:44 -0800
Message-ID: <75D9B5F4E50C8B4BB27622BD06C2B82BD4D428@xmb-sjc-235.amer.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] [PATCH 00/13] Introduce task_pid api
Thread-Index: AcXqI63E1nP5fXG4QkqjG01D86CJkQAMA6YA
From: "Hua Zhong \(hzhong\)" <hzhong@cisco.com>
To: "Ray Bryant" <raybry@mpdtxmail.amd.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, "Hubertus Franke" <frankeh@watson.ibm.com>,
       "Dave Hansen" <haveblue@us.ibm.com>
X-OriginalArrivalTime: 16 Nov 2005 02:24:44.0871 (UTC) FILETIME=[E87EE570:01C5EA54]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did some checkpoint/restart work on Linux about 5 years ago (you may
still be able to google "CRAK"), so I'm jumping in with my 2 cents.

> Personally, I think that these assumptions are incorrect for a 
> checkpoint/restart facility.   I think that:
> 
> (1)  It is really only possible to checkpoint/restart a 
> cooperative process.

It's hard, but not impossible, at least theoretically.

> For this to work with uncooperative processes you have to 
> figure out (for example) how to save and restore the file 
> system state.  (e.g. how do you 
> get the file position set correctly for an open file in the 
> restored program instance?)

This is actually one of the simplest problems in checkpoint/restart.

You'd need kernel support to save the state, and restart could be done
entirely in user space to restore the file descriptors.

> And this doesn't even consider what to do with open network 
> connections.

Right, this is really hard. I played with it 5 years ago and I had semi
success on restoring network connections (with my limited understanding
on Linux networking and some really ugly hacks). I could restart a
killed remote Emacs X session with about 50% success rate.

> Similarly, what does one do about the content of System V 
> shared memory regions or the contents of System V semaphores?   I'm
sure 
> there are many more such problems we can come up with a careful study
of the 
> Linux/Unix API.
>
> (Note that "cooperation" in this context can also mean 
> "willing to run inside of a container of some kind that supports
checkpoint/restart".)
> 
> So you can probably only checkpoint the process at certain 
> points in its lifetime, points which the application should be willing
to 
> identify in some way.    And I would argue that at such points in
time, you 
> can require that the current register state doesn't include the
results of a 
> system call such as getpid(), couldn't you?

Again, it IS very hard, but I don't think it's impossible to have
transparent checkpoint/restart. I mean, it cant be more difficult than
writing Linux from scratch, can it? :-)

> So, I guess my question is wrt the task_pid API is the 
> following:   Given that there are a lot of other problems to solve
before transparent 
> checkpointing of uncooperative processes is possible, why should this 
> partial solution be accepted into the main line kernel and "set in
stone" so to speak?

I agree with this. Before we see a mature checkpoint/restart solution
already implemented, there is no point in doing the vpid thing.
