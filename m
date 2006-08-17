Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWHQPl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWHQPl6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWHQPl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:41:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19164 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964837AbWHQPl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:41:57 -0400
Date: Thu, 17 Aug 2006 08:40:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: rohitseth@google.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 4/7] UBC: syscalls (user interface)
Message-Id: <20060817084033.f199d4c7.akpm@osdl.org>
In-Reply-To: <44E45D6A.8000003@sw.ru>
References: <44E33893.6020700@sw.ru>
	<44E33C3F.3010509@sw.ru>
	<1155752277.22595.70.camel@galaxy.corp.google.com>
	<1155755069.24077.392.camel@localhost.localdomain>
	<1155756170.22595.109.camel@galaxy.corp.google.com>
	<44E45D6A.8000003@sw.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006 16:13:30 +0400
Kirill Korotaev <dev@sw.ru> wrote:

> > I was more thinking about (for example) user land physical memory limit
> > for that bean counter.  If the limits are going down, then the system
> > call should try to flush out page cache pages or swap out anonymous
> > memory.  But you are right that it won't be possible in all cases, like
> > for in kernel memory limits.
> Such kind of memory management is less efficient than the one 
> making decisions based on global shortages and global LRU alogrithm.

I also was quite surprised that openvz appears to have no way of
constraining a container's memory usage.  "I want to run this bunch of
processes in a 4.5GB container".

> The problem here is that doing swap out takes more expensive disk I/O
> influencing other users.

A well-set-up container would presumably be working against its own
spindle(s).  If the operator has gone to all the trouble of isolating a job
from the system's other jobs, he'd be pretty dumb to go and let all the
"isolated" jobs share a stinky-slow resource like a disk.

But yes, swap is a problem.  To do this properly we'd need a way of saying
"this container here uses that swap device over there".


