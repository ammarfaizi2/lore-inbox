Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272281AbTHBIvD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 04:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272325AbTHBIvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 04:51:03 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:47624
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S272281AbTHBIvA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 04:51:00 -0400
Subject: Re: [PATCH] bug in setpgid()? process groups and thread groups
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <3F2B7435.7070101@redhat.com>
References: <1059811048.18516.43.camel@ixodes.goop.org>
	 <3F2B7435.7070101@redhat.com>
Content-Type: text/plain
Message-Id: <1059814257.18860.38.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 02 Aug 2003 01:50:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-02 at 01:20, Ulrich Drepper wrote:
> Your approach with iterating over the threads is not acceptable (at
> least to me). 

I've noticed that postings with patches get paid a lot more attention to
those without.  It was just the patch I used to prove to myself what the
problem is.

> It is racy (concurrent runs are not synchronized) 

Erm, it's protected by tasklist_lock, so that isn't a problem.

> and has
> a non-constant time.  We've sketched out already a mechanism which
> solves to problem.  Basically, most of the time the value from the
> thread group leader is used (just follow the pointer).  Then setting the
> value is an atomic operation an constant.

I was considering that, but it needs changes all over the place where
people look at current->pgrp.  This way makes for a clearer patch.

	J

