Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbTAVVpu>; Wed, 22 Jan 2003 16:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbTAVVpt>; Wed, 22 Jan 2003 16:45:49 -0500
Received: from packet.digeo.com ([12.110.80.53]:55432 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263333AbTAVVpt>;
	Wed, 22 Jan 2003 16:45:49 -0500
Date: Wed, 22 Jan 2003 13:48:44 -0800
From: Andrew Morton <akpm@digeo.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why isn't quota dependant on ext2?
Message-Id: <20030122134844.2a74c588.akpm@digeo.com>
In-Reply-To: <200301222105.h0ML5t719018@devserv.devel.redhat.com>
References: <20030121185927.3abd9298.akpm@digeo.com>
	<Pine.LNX.4.44.0301212259270.5687-100000@innerfire.net>
	<mailman.1043208901.31378.linux-kernel2news@redhat.com>
	<200301222105.h0ML5t719018@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jan 2003 21:54:51.0589 (UTC) FILETIME=[E3E52750:01C2C260]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> wrote:
>
> >> > ext3, ufs and udf also use the core quota code.
> >> 
> >> The documentation says it only works with ext2 where would I find working
> >> utilities to get it working on ext3 ?
> > 
> > ext3 uses the same tools as ext2 - checkquota, quotaon, etc.
> > 
> > http://quota-tools.sourceforge.net/ (site seems to be broken)
> 
> The bad news is that quota on ext3 is virtually guaranteed
> to deadlock, so you can do it, but you do not want to do it.

Darnit, I had all that working 18 months ago ;)

> The original memo describes a deadlock in RH 2.4.18-5, which
> I assure you, was NOT fixed in Marcelo 2.4.20.

Yes, that's a common ext3 problem.  A journal_start()/journal_stop() pair is
the same, for locking purposes, as down()/up().  So they need to be ranked
consistently.

Let me crunch on that a bit...

