Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVEGRPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVEGRPA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 13:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbVEGRPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 13:15:00 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:65033 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262615AbVEGRO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 13:14:58 -0400
Date: Sat, 7 May 2005 19:05:56 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ricky Beam <jfbeam@bluetronic.net>, nico-kernel@schottelius.org,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-ID: <20050507170555.GA19329@alpha.home.local>
References: <20050419121530.GB23282@schottelius.org> <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net> <20050506211455.3d2b3f29.akpm@osdl.org> <20050507075828.GF777@alpha.home.local> <20050507165357.GA19601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050507165357.GA19601@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Sat, May 07, 2005 at 12:53:57PM -0400, Dave Jones wrote:
> On Sat, May 07, 2005 at 09:58:29AM +0200, Willy Tarreau wrote:
 
> What /could/ be useful would be a way to tell sched_setaffinity
> and co "I have two threads, I'd like them both to run on different cores,
> avoiding HT pairs, and never be migrated off them" without having to care
> about the layout of the cpus in each application.

Well, that's exactly for this that I formulated the proposal. A
CPU-intensive application which benefits from the cache would better
choose to run on HT pairs. A network-hungry application will prefer
running on only one sibling of each HT pair, and probably one process
per core, particularly when each core receives one NIC's interrupt.
A memory bandwidth intensive application will choose to run on a
single NUMA node, etc... So either the application can choose this
itself from its understanding of the CPU layout, or it can ask the
system "hey, I'd like this type of workload, how many process should
I start, and where should I bind them ?". I agree that the later
seems more portable and puts less burden on the application.

Regards,
Willy

