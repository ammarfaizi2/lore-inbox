Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbTDOFXq (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 01:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264293AbTDOFXp (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 01:23:45 -0400
Received: from [12.47.58.203] ([12.47.58.203]:309 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S264291AbTDOFXo (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 01:23:44 -0400
Date: Mon, 14 Apr 2003 22:35:37 -0700
From: Andrew Morton <akpm@digeo.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.67-mm3
Message-Id: <20030414223537.45808bd9.akpm@digeo.com>
In-Reply-To: <20030415051534.GE706@holomorphy.com>
References: <20030414015313.4f6333ad.akpm@digeo.com>
	<20030415020057.GC706@holomorphy.com>
	<20030415041759.GA12487@holomorphy.com>
	<20030414213114.37dc7879.akpm@digeo.com>
	<20030415043947.GD706@holomorphy.com>
	<20030414215541.0aff47bc.akpm@digeo.com>
	<20030415051534.GE706@holomorphy.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Apr 2003 05:35:27.0919 (UTC) FILETIME=[D24DF3F0:01C30310]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Mon, Apr 14, 2003 at 09:55:41PM -0700, Andrew Morton wrote:
> > Sort-of.  The code is doing two things.
> > a) Make sure that all the relevant pte's are established in the correct
> >    state so we don't take a fault while holding the subsequent atomic kmap.
> >    This is just an optimisation.  If we _do_ take the fault while holding
> >    an atomic kmap, we fall back to sleeping kmap, and do the whole copy
> >    again.  It almost never happens.
> 
> This is the easy part; we're basically just prefaulting.

btw, this may sound like a lot of futzing about, but the other day I
timed four concurrent instances of

	dd if=/dev/zero of=$i bs=1 count=1M

on the four-way.  2.5 ran eight times faster than 2.4.  2.4's kmap_lock
contention was astonishing.

