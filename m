Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274873AbTGaVSv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274874AbTGaVSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:18:51 -0400
Received: from holomorphy.com ([66.224.33.161]:29657 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S274873AbTGaVSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:18:49 -0400
Date: Thu, 31 Jul 2003 14:19:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-mm1 results
Message-ID: <20030731211958.GD15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <5110000.1059489420@[10.10.2.4]> <200307310128.50189.kernel@kolivas.org> <58530000.1059663364@[10.10.2.4]> <200308010113.02866.kernel@kolivas.org> <59900000.1059664740@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59900000.1059664740@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Con Kolivas wrote:
>> How do we get around this? I'll be brave here and say I'm not sure
>> we need to, as cpu hogs have a knack of slowing things down for
>> everyone, and it is best not just for interactivity for this to
>> happen, but for fairness.

On Thu, Jul 31, 2003 at 08:19:01AM -0700, Martin J. Bligh wrote:
> Well, what you want to do is prioritise interactive tasks over cpu hogs.
> What *seems* to be happening is you're just switching between cpu hogs
> more ... that doesn't help anyone really. I don't have an easy answer
> for how to fix that, but it doesn't seem desireable to me - we need some
> better way of working out what's interactive, and what's not.

I don't believe so. You're describing the precise effect of finite-
quantum FB (or tiny quantum RR) on long-running tasks. Generally
multilevel queues are used to back off to a service-time dependent
queueing discipline (e.g. use RR with increasing quanta for each level
and use level promotion and demotion to discriminate interactive tasks,
which remain higher-priority since overall policy is FB) with longer
timeslices for such beasts for less context-switching overhead. I say
lengthen timeslices with service time and make priority preemption work.

-- wli
