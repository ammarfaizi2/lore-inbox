Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbUJ0PGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbUJ0PGr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbUJ0PGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:06:47 -0400
Received: from ida.rowland.org ([192.131.102.52]:5892 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262480AbUJ0PE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:04:57 -0400
Date: Wed, 27 Oct 2004 11:04:57 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Rusty Russell <rusty@rustcorp.com.au>
cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC as402] Delaying module memory release
In-Reply-To: <1098844811.22012.29.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0410271100480.1364-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Rusty Russell wrote:

> On Tue, 2004-10-26 at 15:52 -0400, Alan Stern wrote:
> > This issue has come up in the past, without much in the way of visible 
> > results.
> > 
> > The problem is that sometimes the memory for a kernel module needs to be
> > freed _after_ rmmod has exited.  The classic example is where the standard
> > input to the rmmod process has been redirected to a pseudo-file that pins
> > a kobject whose release method calls into the module.  Another example
> > (which could be worked around with some effort) is multiple kernel threads
> > executing in the module -- the module exit routine would have to wait for 
> > each one of them to terminate.
> > 
> > In these cases it's not desirable/feasible to increment the module's 
> > refcount.
> 
> Why not?  In the former the module is still in use, in the latter the
> module_exit routine is expected to clean up.

I have to apologize.  Shortly after sending off the earlier email message, 
I realized that the problem with sysfs pinning kobjects had already been 
fixed by taking a reference to the attribute's owner module.  The other 
problem can be handled by other means.  So my proposed change really is 
not needed.

Consider the patch revoked.

Alan Stern

