Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbTBUJpP>; Fri, 21 Feb 2003 04:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267270AbTBUJpO>; Fri, 21 Feb 2003 04:45:14 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:41861 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267268AbTBUJpO>;
	Fri, 21 Feb 2003 04:45:14 -0500
Date: Fri, 21 Feb 2003 10:54:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dejan Muhamedagic <dejan@hello-penguin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm issues on sap app server
Message-ID: <20030221095459.GK31480@x30.school.suse.de>
References: <20030219171432.A6059@smp.colors.kwc> <20030219180523.GK14633@x30.suse.de> <20030220124026.GA4051@lilith.homenet> <20030220130858.GI31480@x30.school.suse.de> <20030221000322.GA8096@lilith.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221000322.GA8096@lilith.homenet>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 01:03:22AM +0100, Dejan Muhamedagic wrote:
> I'd disagree here.  The system _should_ be able to keep stability
> without resetting.  If it can't, then there's something wrong.

I really meant restarting the app server, not the kernel.

> (1)  Summing up the RSS column of "ps aux" yields incredible 21GB.
> Could one calculate used_mem - bufs - cached + used_swap ?

you're counting the size of the shm for the N tasks that are mapping it,
perfectly normal.

For the increased swapping, it is also possible you pay some pagetable
overhead that increases over time after all the processes touches the
whole 2G. Not sure if each task is reading the whole shm after the mmap
or shmat during startup (and certainly it's not mlocked, so the ptes
will be allocated lazily).

Again, if after stopping and starting the app server it returns at peak
performance I don't see how this can be a kernel issue.

Andrea
