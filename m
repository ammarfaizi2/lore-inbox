Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTEGXVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTEGXVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:21:23 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:20528 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264372AbTEGXTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:19:42 -0400
Date: Wed, 7 May 2003 16:28:30 -0700
From: Andrew Morton <akpm@digeo.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WimMark I report for 2.5.69
Message-Id: <20030507162830.47af1d47.akpm@digeo.com>
In-Reply-To: <20030507231919.GA3989@ca-server1.us.oracle.com>
References: <20030507175422.GX3989@ca-server1.us.oracle.com>
	<20030507154150.005db55e.akpm@digeo.com>
	<20030507231919.GA3989@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 May 2003 23:32:12.0079 (UTC) FILETIME=[E278F3F0:01C314F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
> On Wed, May 07, 2003 at 03:41:50PM -0700, Andrew Morton wrote:
> > > Runs:  1462.17 1005.78 1995.99
> > > ...
> > > This benchmark is sensitive to random system events.
> > 
> > You can say that again.
> > 
> > We need to understand why there is such variation.  If we can do that,
> > then perhaps we can make those 1.0's and 1.5's go away.
> 
> 	Some kernels run very very even.  Others do not.  I suspect that
> certain kernel behaviors and changes exacerbate the issues.

Correct me if I'm wrong, but this test is largely seek-bound, is it not?

Do you monitor the total CPU utilisation during the run?  Is it generally
low?  If so then we're seek-bound.

File layout will influence things a lot.  Small variations in timing and in
CPU scheduler activity could well cause significant dfifferences in file
layout.

Does the test generate the files on-the-fly, or are they laid out
beforehand?

Is it possible to fully populate the datafiles before the run, with a
single thread of control?  That will ensure that each run is working off
the same layout and will give a better basis for comparison.

It will also tell us that some layout tweaks may be needed.
