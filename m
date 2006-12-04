Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937214AbWLDREb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937214AbWLDREb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 12:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937215AbWLDREa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 12:04:30 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:39951 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937214AbWLDRE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 12:04:29 -0500
Date: Mon, 4 Dec 2006 09:03:59 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Aucoin@houston.rr.com,
       "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       linux-kernel@vger.kernel.org, pj@sgi.com
Subject: Re: la la la la ... swappiness
In-Reply-To: <Pine.LNX.4.64.0612032111280.3476@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612040900210.31485@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.63.0612032137380.17489@gockel.physik3.uni-rostock.de>
 <200612032356.kB3NuPc0010673@ms-smtp-04.texas.rr.com> <20061203205649.98df030b.akpm@osdl.org>
 <Pine.LNX.4.64.0612032111280.3476@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2006, Linus Torvalds wrote:

> Wouldn't it be much nicer to just lower the dirty-page limit?
> 
> 	echo 1 > /proc/sys/vm/dirty_background_ratio
> 	echo 2 > /proc/sys/vm/dirty_ratio

Dirty ratio cannot be set to less than 5%. See 
mm/page-writeback.c:get_dirty_limits().

> or something. Which we already discussed in another thread and almost 
> already decided we should lower the values for big-mem machines..

We also have an issue with cpusets. Dirty page throttling does not work in 
a cpuset if it is relatively small to the total memory on the system since 
we calculate the percentage of the total memory and not a percentage of 
the memory the process is allowed to use.
