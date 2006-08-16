Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWHPJSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWHPJSK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 05:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWHPJSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 05:18:10 -0400
Received: from ns2.suse.de ([195.135.220.15]:58545 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750767AbWHPJSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 05:18:09 -0400
Date: Wed, 16 Aug 2006 11:18:01 +0200
From: Andi Kleen <ak@muc.de>
To: Greg KH <greg@kroah.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] [3/3] Support piping into commands in
 /proc/sys/kernel/core_pattern
Message-Id: <20060816111801.0fc5093e.ak@muc.de>
In-Reply-To: <20060816084354.GF24139@kroah.com>
References: <20060814127.183332000@suse.de>
	<20060814112732.684D313BD9@wotan.suse.de>
	<20060816084354.GF24139@kroah.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006 01:43:54 -0700
Greg KH <greg@kroah.com> wrote:

> On Mon, Aug 14, 2006 at 01:27:32PM +0200, Andi Kleen wrote:
> > 
> > Using the infrastructure created in previous patches implement support
> > to pipe core dumps into programs. 
> > 
> > This is done by overloading the existing core_pattern sysctl
> > with a new syntax:
> > 
> > |program
> 
> Very nice, do you happen to have a program that can accept this kind of
> input for crash dumps?  I'm guessing that the embedded people will
> really want this functionality.

I had a cheesy demo/prototype. Basically it wrote the dump to a file again,
ran gdb on it to get a backtrace and wrote the summary to a shared directory.
Then there was a simple CGI script to generate a "top 10" crashes
HTML listing.

Unfortunately this still had the disadvantage to needing full disk space
for a dump except for deleting it afterwards (in fact it was worse because 
over the pipe holes didn't work so if you have a holey address map it would 
require more space).

Fortunately gdb seems to be happy to handle /proc/pid/fd/xxx input pipes
as cores (at least it worked with zsh's =(cat core) syntax), so it would be 
likely possible to do it without temporary space with a simple wrapper that 
calls it in the right way.  I ran out of time before doing that though.

The demo prototype scripts weren't very good. If there is really interest
I can dig them out (they are currently on a laptop disk on the desk 
with the laptop itself being in service), but I would recommend to 
rewrite them for any  serious application of this and fix the disk space problem.

Also to be really useful it should probably find a way to automatically
fetch the debuginfos (I cheated and just installed them in advance)

If nobody else does it I can probably do the rewrite myself again at some point.

My hope at some point was that desktops would support it in their
builtin crash reporters, but at least the KDE people I talked
too seemed to be happy with their user space only solution.

-Andi
