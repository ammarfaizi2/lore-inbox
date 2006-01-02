Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWABJu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWABJu4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 04:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWABJu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 04:50:56 -0500
Received: from 213-140-2-68.ip.fastwebnet.it ([213.140.2.68]:58262 "EHLO
	aa001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932341AbWABJu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 04:50:56 -0500
Date: Mon, 2 Jan 2006 10:50:56 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Mike Galbraith <efault@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Message-ID: <20060102105056.5e6d5205@localhost>
In-Reply-To: <5.2.1.1.2.20060102092903.00bde090@pop.gmx.net>
References: <5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
	<5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
	<200512281027.00252.kernel@kolivas.org>
	<20051227190918.65c2abac@localhost>
	<20051227224846.6edcff88@localhost>
	<200512281027.00252.kernel@kolivas.org>
	<5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
	<5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
	<5.2.1.1.2.20060102092903.00bde090@pop.gmx.net>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Jan 2006 10:15:43 +0100
Mike Galbraith <efault@gmx.de> wrote:

> >This is the bad situation I hate: some cpu-eaters that eat all the CPU
> >time BUT have a really good priority only because they sleeps a bit.
> 
> Yup, your proggy fools the interactivity estimator quite well.  This 
> problem was addressed a long time ago, and thought to be more or less 
> cured.  Guess not.

In my original real-life test case (transcode) I found that the problem
started with the removing of "interactive_credit":

http://groups.google.com/group/fa.linux.kernel/browse_thread/thread/6aa5c93c379ae9e1/a9a83db6446edaf7?lnk=st&q=insubject%3Asched+author%3APaolo+author%3AOrnati&rnum=1&hl=en#a9a83db6446edaf7

This is not actually true... in fact that change only unhidden the
problem for that particular test-case.

With my little proggy I'm now able to reproduce the problem even with
"interactive_credit" applied (for example with a 2.6.10 kernel).

Said this, and since "nicksched" doesn't have this problem at all, it
is an ingosched (and others as well) problem.

-- 
	Paolo Ornati
	Linux 2.6.15-rc7-plugsched on x86_64
