Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161327AbWF0Vpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161327AbWF0Vpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 17:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161328AbWF0Vpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 17:45:30 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:46519 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161327AbWF0Vp3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 17:45:29 -0400
Subject: Re: [RFC][PATCH 0/3] Process events biarch bug: Intro
From: Matt Helsley <matthltc@us.ibm.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
In-Reply-To: <20060627123325.GA26716@2ka.mipt.ru>
References: <1151408822.21787.1807.camel@stark>
	 <20060627123325.GA26716@2ka.mipt.ru>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 14:39:51 -0700
Message-Id: <1151444391.21787.1860.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 16:33 +0400, Evgeniy Polyakov wrote:
> On Tue, Jun 27, 2006 at 04:47:01AM -0700, Matt Helsley (matthltc@us.ibm.com) wrote:
> > The events sent by Process Events from a 64-bit kernel are not binary compatible
> > with what a 32-bit userspace program would expect to recieve because the timespec
> > struct (used to send a timestamp) is not the same. This means that fields stored
> > after the timestamp are offset and programs that don't take this into account
> > break under these circumstances.
> > 
> > This is a problem for 32-bit userspace programs running with 64-bit kernels on
> > ppc64, s390, x86-64.. any "biarch" system.
> > 
> > This series:
> > 
> > 1 - Gives a name to the union of the process events structure so it may be used
> > 	to work around the problem from userspace.
> > 2 - Comments on the bug and describes a userspace workaround in
> > 	Documentation/connector/process_events.txt
> > 3 - Implements a second connector interface without the problem
> > 	(Removing the old interface or changing the definition would break
> > 	 binary compatibility)
> 
> If you are sure binary compatibility on this stage of process
> notification connector is really major issue, then I agree that above is
> correct, otherwise I would recommend to just replace broken code with fixed size objects.

	It's not clear whether event binary compatibility is a major issue. I
chose to assume it was and presented the best option (that I could think
of) for preserving binary compatibility.

> Btw, __u64 is not the best choice for some arches too due to it's
> alignment (64bit code requires u64 to be aligned to 64 bit, while 32bit
> code will only align it to 32 bits), so you will need 
> attribute ((aligned(8)))) for your own ___u64.

	Fixing the alignment would be a good idea. Though setting it to 8 would
introduce 4 unused bytes at the end of the structure.

Cheers,
	-Matt Helsley

