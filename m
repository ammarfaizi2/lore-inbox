Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbUCWAwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 19:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbUCWAwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 19:52:16 -0500
Received: from waste.org ([209.173.204.2]:1933 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261738AbUCWAwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 19:52:10 -0500
Date: Mon, 22 Mar 2004 18:52:04 -0600
From: Matt Mackall <mpm@selenic.com>
To: Matt Miller <mmiller@hick.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6: mmap complement, fdmap
Message-ID: <20040323005204.GF8366@waste.org>
References: <20040322190047.GC8366@waste.org> <PFEHKADDODPLDDIJFACJAEJHEAAA.mmiller@hick.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PFEHKADDODPLDDIJFACJAEJHEAAA.mmiller@hick.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 01:26:01PM -0600, Matt Miller wrote:
> > > > a) what the hell for?
> > >
> > > It's targetted mainly as a performance enhancer.  Some of the specific
> > > scenarios where it would be useful are:
> > >
> > > a) When one cannot afford to take the performance hit of synchronizing
> > >    a memory range to disk due to disk size limitations or speed
> > >    requirements.
> > > b) Some things can benefit from the ability to interface with
> > memory as a
> > >    file.
> > >
> > > The specific reason for implementing this was to allow for
> > loading dynamic
> > > libraries in the context of a process without having to write them to
> > > disk.
> >
> > How about tmpfs/ramfs instead? Open a file on tmpfs and mmap it and
> > you've got the same thing without any of the nasty corner cases.
> 
> Because tmpfs does not allow you to map a file descriptor to a specific
> memory
> range inside a process.  tmpfs allows you to open a file that exists only
> in memory, yes, but it does not accomplish what fdmap tries to accomplish.
> fdmap allows you to access arbitrary memory ranges as if they were a file.
> tmpfs allows you to access a file that happens to only exist in memory.
> You do not control the address range that tmpfs/ramfs map to.

You don't? Is this not what the first argument of mmap provides? I'm
afraid I can't see how it matters, as you'd have to populate said map
afterwards anyway.

Point is, mmap() is already its own complement and what you're
proposing is a hairy solution in search of a problem as the VFS
maintainer already pointed out.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
