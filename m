Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbVITPOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbVITPOl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbVITPOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:14:40 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:52662 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964955AbVITPOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:14:39 -0400
Date: Tue, 20 Sep 2005 08:14:28 -0700
From: Paul Jackson <pj@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: holt@sgi.com, zippel@linux-m68k.org, akpm@osdl.org, torvalds@osdl.org,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
Message-Id: <20050920081428.6fb2c711.pj@sgi.com>
In-Reply-To: <20050920145449.GA31461@lnx-holt.americas.sgi.com>
References: <20050912153135.3812d8e2.pj@sgi.com>
	<Pine.LNX.4.61.0509131120020.3728@scrub.home>
	<20050913103724.19ac5efa.pj@sgi.com>
	<Pine.LNX.4.61.0509141446590.3728@scrub.home>
	<20050914124642.1b19dd73.pj@sgi.com>
	<Pine.LNX.4.61.0509150116150.3728@scrub.home>
	<20050915104535.6058bbda.pj@sgi.com>
	<20050920005743.4ea5f224.pj@sgi.com>
	<20050920120523.GC21435@lnx-holt.americas.sgi.com>
	<20050920072255.0096f1bb.pj@sgi.com>
	<20050920145449.GA31461@lnx-holt.americas.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin wrote:
> This makes things even easier!!!

Easy is good.


> When the vfs code is traversing the list, you need to ensure
> that it does not iterate unless the child list lock is held.
> I have not looked at how you implemented the vfs stuff, but
> that should be easily accomplished.
> 
> Where are the holes?

The hole is my understanding of vfs.

My gut instinct is to recoil in horror from this suggestion, because it
seems to involve walking the cpuset tree from bottom up, setting locks,
while some other task might be doing a normal file system open on one
of these cpusets, walking the tree top-down, setting locks.

That smells like deadlock city to me.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
