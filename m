Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264862AbSJOVMh>; Tue, 15 Oct 2002 17:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbSJOVLS>; Tue, 15 Oct 2002 17:11:18 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52432 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S264862AbSJOVLG>;
	Tue, 15 Oct 2002 17:11:06 -0400
Date: Tue, 15 Oct 2002 23:28:00 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Cc: "David S. Miller" <davem@redhat.com>, <kuznet@ms2.inr.ac.ru>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Rename _bh to _softirq
In-Reply-To: <5.1.0.14.2.20021015135529.051b49b0@mail1.qualcomm.com>
Message-ID: <Pine.LNX.4.44.0210152321120.26390-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Oct 2002, Maksim (Max) Krasnyanskiy wrote:

> tasklets are softirqs. I mean they aren't much different. Tasklets are
> executed from the softirq, so they have same context and stuff.

well, tasklets are a subset of softirqs, in that the code triggered by a
tasklet can run only on one CPU at once. Ie. they are a special kind of
softirq that knows about global things like "I'm executing currently".

Ie., just to confuse things, they are similar to what old-BHs used to be,
with the difference that the enumeration of tasklets is much nicer
(pointer based and can be embedded in any structure), not some global
registry of integers like old-BHs were.

(tasklets can also be scheduled via two priority levels: a 'high' priority
scheduling and a 'low' priority scheduling. old-BHs used to have fixed
priority levels directly attached to their global enumeration integer
values.)

	Ingo

