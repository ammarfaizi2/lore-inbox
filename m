Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317679AbSFRXjE>; Tue, 18 Jun 2002 19:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317680AbSFRXjE>; Tue, 18 Jun 2002 19:39:04 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:58604 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317679AbSFRXjC>; Tue, 18 Jun 2002 19:39:02 -0400
Subject: Re: latest linus-2.5 BK broken
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: torvalds@transmeta.com
Cc: rusty@rustcorp.com.au, rml@tech9.net, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 18 Jun 2002 16:38:00 -0700
Message-Id: <1024443480.1514.33.camel@w-hbaum>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 18 2002, Linus Torvalds wrote:

> On Wed, 19 Jun 2002, Rusty Russell wrote:
>
> NO.  They want to be node-affine.  They don't want to specify what
> CPUs they attach to.
>
> So you're going to have separate interfaces for that? Gag me with a 
> volvo, but that's idiotic.
>
> Besides, even that would be broken. You want bitmaps, because bitmaps
> is really what it is all about. It's NOT about "I must run on this
> CPU", it can equally well be "I mustn't run on those two CPU's that
> are hosting the RT part of this thing" or something like that.
>
>		Linus


A bit mask is a very good choice for the sched_setaffinity()
interface.  I would suggest an additional argument be added
which would indicate the resource that the process is to be
affined to.  That way this interface could be used for binding
processes to cpus, memory nodes, perhaps NUMA nodes, and, 
as discussed recently in another thread, other processes.
Personally, I see NUMA nodes as an overkill, if a process
can be bound to cpus and memory nodes.

There has been an effort made to address the needs for binding
processes to processors, memory nodes, etc. for NUMA machines.
A proposed API has been developed and implemented.  See
http://lse.sourceforge.net/numa/numa_api.html for a spec on
the API.  Matt Dobson has posted the implementation to lkml
as a patch against 2.5 several times, but has not seen much
discussion.  I could see much of the capabilities provided
in the NUMA API being provided through the sched_setaffinity()
as described above.

Michael Hohnbaum
hohnbaum@us.ibm.com





