Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUGXRqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUGXRqt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 13:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUGXRqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 13:46:48 -0400
Received: from [66.35.79.110] ([66.35.79.110]:54687 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S262080AbUGXRqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 13:46:46 -0400
Date: Sat, 24 Jul 2004 10:46:36 -0700
From: Tim Hockin <thockin@hockin.org>
To: Robert Love <rml@ximian.com>
Cc: dsaxena@plexity.net, Michael Clark <michael@metaparadigm.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-ID: <20040724174636.GA29367@hockin.org>
References: <1090604517.13415.0.camel@lucy> <4101D14D.6090007@metaparadigm.com> <1090638881.2296.14.camel@localhost> <20040724150838.GA24765@plexity.net> <1090683953.2296.78.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090683953.2296.78.camel@localhost>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2004 at 11:45:53AM -0400, Robert Love wrote:
> 
> Not everything has a corresponding sysfs name, which really makes the
> whole notion moot.

The things that do can use it, though.  Here's a place where inconsistency
(if present) is pointless.1

> I might not of been clear - path name of the file in the kernel source
> tree.  So if you add an event to fs/open.c the path is
> "/org/kernel/fs/open".  This is a pretty generic naming scheme that
> ensures names will be unique within the kernel and will not conflict
> with names outside the kernel (e.g. the global URI space of whatever is
> used in user-space).

This immediately strikes me as a really bad idea.  Stuff moves between
files.  Two files might really want to signal an event from the same
source.  

> "high" is only an arbitrary string if it is not standardized.  If the
> temperature event is defined to come from such and such an interface,
> with such and such values, it is all very easy to use.  I mean, this is
> how object systems work today.

As long as we're religious about making every subsystem standardize these
names, it should be ok.  Another reason to macro-ize.  There are way too
many people touching too much code that might take advantage of a generic
kernel->user event to rely on soft rules.

> > In the case of a file close, the object name is the file path and the 
> > attribute could be the ctime, but it needs more thinking.  
> 
> This is where the sysfs naming scheme breaks down.  You now have two
> different namespaces - kobjects and files on a filesystem.  We really
> need something a lot simpler.  Let user-space map stuff around if we
> want that.

Assuming that we're going to be doing file notifications via this,
wouldn't something like "/fs/file close /path/to/foo" be right(er)?

Cheers
Tim
