Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264152AbTDOXHq (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 19:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbTDOXHq 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 19:07:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:13289 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264152AbTDOXHo convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 19:07:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: 2.5.66-mm3 -  bad ext2 performance ?
Date: Tue, 15 Apr 2003 16:17:08 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
References: <200304151356.24323.pbadari@us.ibm.com> <20030415152421.X26054@schatzie.adilger.int>
In-Reply-To: <20030415152421.X26054@schatzie.adilger.int>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304151617.08267.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 April 2003 02:24 pm, Andreas Dilger wrote:
> On Apr 15, 2003  14:00 -0700, Badari Pulavarty wrote:
> > This is kind of extreem. But  I have 1070 LUNS and I mkfs/mounted (ext2)
> > all these and running "fsx" on all of them.
> >
> > I see very bad IO rate on the machine.  fsx with O_DIRECT seems to be
> > doing okay. Any ideas on why regular filesystem (buffered) IO sucks ?
> > I dont' see even cache increasing ..
>
> Depending on what parameters you have passed to fsx, it isn't necessarily
> going to be doing a lot of I/O.  The default for the fsx I have is to max
> the file size out at 256kB (on average it will be about half of that), and
> you have 1070 instances running, so that agrees with the ~110MB of cache
> difference between O_DIRECT and non-O_DIRECT.
>
> Also, in the non-O_DIRECT case fsx will be doing reads from cache and not
> disk, so there is no reason to see anything in "bi".  The writes may or
> may not be a problem, as fsx is "truncate happy", so some large amounts of
> data that are "written" are immediately truncated again.  For O_DIRECT,
> everything is going straight to/from disk, hence much higher IO numbers.
>
> What you should really be checking is how many "ops per second" you are
> getting from fsx with and without O_DIRECT.  It would be my guess that
> the O_DIRECT fsx is actually _slower_ because it is doing more I/O (and
> waiting for it to complete).  Run each fsx with some fixed number of ops
> (-N <num ops>) and see how long it takes for both tests to complete.

Sure. Will do !!

Thanks.
Badari

