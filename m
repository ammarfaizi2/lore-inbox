Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbVEGRUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbVEGRUR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 13:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVEGRUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 13:20:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53669 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262726AbVEGRUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 13:20:11 -0400
Date: Sat, 7 May 2005 13:20:05 -0400
From: Dave Jones <davej@redhat.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Andrew Morton <akpm@osdl.org>, Ricky Beam <jfbeam@bluetronic.net>,
       nico-kernel@schottelius.org, linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-ID: <20050507172005.GB26088@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Willy Tarreau <willy@w.ods.org>, Andrew Morton <akpm@osdl.org>,
	Ricky Beam <jfbeam@bluetronic.net>, nico-kernel@schottelius.org,
	linux-kernel@vger.kernel.org
References: <20050419121530.GB23282@schottelius.org> <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net> <20050506211455.3d2b3f29.akpm@osdl.org> <20050507075828.GF777@alpha.home.local> <20050507165357.GA19601@redhat.com> <20050507170555.GA19329@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050507170555.GA19329@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 07:05:56PM +0200, Willy Tarreau wrote:

 > Well, that's exactly for this that I formulated the proposal. A
 > CPU-intensive application which benefits from the cache would better
 > choose to run on HT pairs. A network-hungry application will prefer
 > running on only one sibling of each HT pair, and probably one process
 > per core, particularly when each core receives one NIC's interrupt.
 > A memory bandwidth intensive application will choose to run on a
 > single NUMA node, etc... So either the application can choose this
 > itself from its understanding of the CPU layout, or it can ask the
 > system "hey, I'd like this type of workload, how many process should
 > I start, and where should I bind them ?".

I think generalising this and having a method to do this in the kernel
is a much better idea than each application parsing this themselves.
Things are only getting more and more complex as time goes on,
and I don't trust application developers to get it right.

Centralising this in the kernel (or maybe even glibc) means we can get
it right, and have every application benefit. If we get it wrong, we
fix it, and all the applications are fixed without needing fixing/recompiling.

		Dave

