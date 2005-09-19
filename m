Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVISEtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVISEtR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 00:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVISEtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 00:49:17 -0400
Received: from fmr19.intel.com ([134.134.136.18]:9418 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932182AbVISEtQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 00:49:16 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PATCH: Fix race in cpu_down (hotplug cpu)
Date: Mon, 19 Sep 2005 12:48:38 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH: Fix race in cpu_down (hotplug cpu)
Thread-Index: AcW80k/meYPHAvTNTpGHj1m/CqGKoAAAe8MA
From: "Li, Shaohua" <shaohua.li@intel.com>
To: <vatsa@in.ibm.com>, "Nigel Cunningham" <ncunningham@cyclades.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Rusty Russell" <rusty@rustcorp.com.au>
X-OriginalArrivalTime: 19 Sep 2005 04:48:36.0642 (UTC) FILETIME=[65792020:01C5BCD5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
>
>On Mon, Sep 19, 2005 at 01:28:38PM +1000, Nigel Cunningham wrote:
>> There is a race condition in taking down a cpu
(kernel/cpu.c::cpu_down).
>> A cpu can already be idling when we clear its online flag, and we do
not
>> force the idle task to reschedule. This results in __cpu_die timing
out.
>
>"when we clear its online flag" - This happens in take_cpu_down in the
>context of stopmachine thread. take_cpu_down also ensures that idle
>thread runs when it returns (sched_idle_next). So when idle thread
runs,
>it should notice that it is offline and invoke play_dead.  So I don't
>understand why __cpu_die should time out.
I guess Nigel's point is cpu_idle is preempted before take_cpu_down. If
the preempt occurs after the cpu_is_offline check, when the cpu (after
sched_idle_next) goes into idle again, nobody can wake it up. Nigel,
isn't it?

Thanks,
Shaohua
