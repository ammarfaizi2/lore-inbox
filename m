Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbUKHUwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbUKHUwc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 15:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbUKHUvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 15:51:14 -0500
Received: from hqemgate00.nvidia.com ([216.228.112.144]:37900 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S261221AbUKHUuk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 15:50:40 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: SCHED_RR and kernel threads
Date: Mon, 8 Nov 2004 12:50:37 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B002A7F0CE@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SCHED_RR and kernel threads
thread-index: AcTF0bc08eaHc3fvSzq0CPrcc4168QAAiQRg
From: "Stephen Warren" <SWarren@nvidia.com>
To: "Con Kolivas" <kernel@kolivas.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Nov 2004 20:50:38.0983 (UTC) FILETIME=[9A8C2170:01C4C5D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Con Kolivas [mailto:kernel@kolivas.org] 
> Stephen Warren wrote:
> > It appears that during times of high application CPU usage, some
> > *kernel* threads don't get to run.
> > ...
> > This appears to be due to the fact that the kernel threads are all
> > SCHED_OTHER, so our SCHED_RR user-space application trumps them!
> 
> Don't run your userspace at SCHED_RR? The kernel threads are 
> SCHED_NORMAL precisely for the reason that you wont get real time 
> performance if the kernel threads rear their ugly heads, 
> albeit rarely.

We have actually set the kernel threads to priority SCHED_RR 50, and
most user-space threads to SCHED_RR priority 50. Some critical
user-space threads are above priority 50.

Won't this allow the kernel and user space threads to co-operate nicely
all the time?

What is it specifically that will make kernel SCHED_RR threads cause
non-real-time operation? If it's just a bunch of corner cases or odd
conditions, we may be in an environment we can control so that doesn't
happen...

I guess we could have most threads stay at SCHED_NORMAL, and just make
the few critical threads SCHED_RR, but I'm getting a lot of push-back on
this, since it makes our thread API a lot more complex.

-- 
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html
