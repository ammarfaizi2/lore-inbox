Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVHCAAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVHCAAt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 20:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVHCAAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 20:00:49 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:58803 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261935AbVHCAAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 20:00:47 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Steven Rostedt <rostedt@goodmis.org>
To: dwalker@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1123025895.25712.7.camel@dhcp153.mvista.com>
References: <20050730160345.GA3584@elte.hu>
	 <1122920564.6759.15.camel@localhost.localdomain>
	 <1122931238.4623.17.camel@dhcp153.mvista.com>
	 <1122944010.6759.64.camel@localhost.localdomain>
	 <20050802101920.GA25759@elte.hu>
	 <1123011928.1590.43.camel@localhost.localdomain>
	 <1123025895.25712.7.camel@dhcp153.mvista.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 02 Aug 2005 20:00:26 -0400
Message-Id: <1123027226.1590.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 16:38 -0700, Daniel Walker wrote:
> Couldn't you just do some math off current->timestamp to see how long
> the task has been running? This per arch stuff seems a bit invasive..

The thing is, I'm tracking how long the task is running in the kernel
without doing a schedule.  That's actually easy, but I don't want to
count when the task is in userspace. The per-arch is only updating so
that we don't count user space, otherwise the count could be in the
task_struct.  If there is an arch-independent way to tell if a task is
running in user-space or kernel when an interrupt goes off then I would
use it.  The per arch is actually easy, and I would write it, but I
don't have the hardware now to test it.  I could at least do PPC and
MIPS since I'm quite familiar with both, but I don't currently have a
cross compiler to compile it.

I understand your point, I would really prefer an arch independent
solution, but the timestamp from current just wont cut it.  Have another
idea, I'm all open for it.

So far, what I submitted works with no know side-effects except that it
is a per-arch patch, which does suck.  

-- Steve

