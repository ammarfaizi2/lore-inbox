Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263936AbTE3TpV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 15:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbTE3TpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 15:45:21 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:16850 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263936AbTE3TpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 15:45:20 -0400
Date: Fri, 30 May 2003 12:58:41 -0700
From: Andrew Morton <akpm@digeo.com>
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: 2.5.70-mm1 Strangeness
Message-Id: <20030530125841.61a12a9c.akpm@digeo.com>
In-Reply-To: <20030530212559.76f0d1ea.bonganilinux@mweb.co.za>
References: <20030529221622.542a6df5.bonganilinux@mweb.co.za>
	<20030529135541.7c926896.akpm@digeo.com>
	<20030529.171114.34756018.davem@redhat.com>
	<20030529175135.7b204aaf.akpm@digeo.com>
	<20030530212559.76f0d1ea.bonganilinux@mweb.co.za>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 May 2003 19:58:40.0365 (UTC) FILETIME=[DD98C9D0:01C326E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bongani Hlope <bonganilinux@mweb.co.za> wrote:
>
> So it seems like CONFIG_DEBUG_PAGEALLOC was causing the problem.

hm, okay.  Thanks for your help in working all that out.

Everything should have just balanced itself out - nothing in the memory
reclaim area cares or knows about the actual size of the objects.

You could run out of memory simply because the things are 20x bigger, but
only if they were pinned - say, a larger number of files open, or a large
number of files in ramfs or sysfs.

But from your last-gasp slabinfo the three caches seem to be of a
reasonable size.  It's a bit of a mystery.  

