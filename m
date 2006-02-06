Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWBFU7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWBFU7J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWBFU7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:59:09 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:27275 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964821AbWBFU7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:59:08 -0500
Date: Mon, 6 Feb 2006 12:59:03 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: ak@suse.de
cc: pj@sgi.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: OOM behavior in constrained memory situations
Message-ID: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are situations in which memory allocations are restricted by policy, 
by a cpuset or by type of allocation. 

I propose that we need different OOM behavior for the cases in which the
user has imposed a limit on what type of memory to be allocated. In that 
case the application should be terminate with OOM. The OOM killer should 
not run.

The huge page allocator has already been modified to return a Bus Error
because it would otherwise trigger the OOM killer. Its a bit strange
if an app returns a Bus Error because it its out of memory.

Could we modify the system so that the application requesting 
memory is terminated with an out of memory condition if

1. No huge pages are available anymore.

2. The application has set a policy that restricts allocation to
   certain nodes.

3. An application is restricted by a cpuset to certain nodes.

4. An application has requested large amounts of memory and the 
   allocation fails.

That should avoid the OOM killer in most situations.

