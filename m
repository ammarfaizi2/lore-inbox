Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWFJQ6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWFJQ6g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 12:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWFJQ6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 12:58:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11944 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750816AbWFJQ6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 12:58:35 -0400
Date: Sat, 10 Jun 2006 09:58:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: michal.k.k.piotrowski@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2
Message-Id: <20060610095832.6cb1ba04.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606100939480.6651@schroedinger.engr.sgi.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
	<6bffcb0e0606100323p122e9b23g37350fa9692337ae@mail.gmail.com>
	<20060610092412.66dd109f.akpm@osdl.org>
	<Pine.LNX.4.64.0606100939480.6651@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2006 09:43:49 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Sat, 10 Jun 2006, Andrew Morton wrote:
> 
> > You'll need to disable CONFIG_DEBUG_PREEMPT, sorry.
> > 
> > Christoph, that is the last straw - I'll drop all these patches.  There's a
> > file in -mm Documentation/SubmitChecklist - please tape to to yor monitor.
> 
> Would it be possible only the drop the patchset that caused this? 

We need to move things aroind between files anyway - it's best that I drop
everything so it can all be refactored.  Please keep the same breakup
(patch swap_prefetch.c separately, reiser4 as well).

Also, it's really preferable that the kernel compile and work at each step
of the series.  V1 didn't come close.

So the series needs significant restructuring.

> This seems to be caused by the event counters and not by the zoned VM 
> counters. I intentially try to separate these two. There are numerous 
> issues still to be resolved for the zoned VM counters. I listed some in 
> the header.
> 
> > page-flags.h was an inappropriate place for that code.
> 
> You mean I should move all the vm counters into separate header and c file 
> right?

That would be nice.  I was worried about fixing the per-cpu errors in
page-flags.h because that adds lots of include dependencies and we'd
probably introduce build breakage.

