Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265433AbUFRX7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbUFRX7U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 19:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265490AbUFRX7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:59:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:55017 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265749AbUFRX4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:56:54 -0400
Date: Sat, 19 Jun 2004 01:56:52 +0200
From: Andi Kleen <ak@suse.de>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: bcasavan@sgi.com, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] Add kallsyms_lookup() result cache
Message-Id: <20040619015652.232b3b55.ak@suse.de>
In-Reply-To: <200406181926.39294.jbarnes@engr.sgi.com>
References: <Pine.SGI.4.58.0406181435570.5029@kzerza.americas.sgi.com>
	<20040619000326.067c3ff6.ak@suse.de>
	<200406181926.39294.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004 19:26:39 -0400
Jesse Barnes <jbarnes@engr.sgi.com> wrote:

> On Friday, June 18, 2004 6:03 pm, Andi Kleen wrote:
> > On Fri, 18 Jun 2004 15:03:00 -0500
> >
> > Brent Casavant <bcasavan@sgi.com> wrote:
> > > On 2.6 based systems, the top command utilizes /proc/[pid]/wchan to
> > > determine WCHAN symbol name information.  This information is provided
> > > by the kernel function kallsyms_lookup(), which expands a stem-compressed
> >
> > That sounds more like a bug in your top to me. /proc/*/wchan itself
> > does not access kallsyms, it just outputs a number.undisclosed-recipients:;
> 
> No, it outputs a string:
> jbarnes@mill:~$ cat /proc/1/wchan
> do_select

Indeed. I looked at /proc/self/wchan, but of course that is 0 because
the process is running. 

But there is numerical wchan anyways - just get it from /proc/*/stat
That is what all 2.4 based tops always used.  I bet they still
have the fallback code for that around.The 2.6 change 
will just be to read the symbol table from /proc/kallsyms instead
of from the System.map file.

> 
> > Doing the cache in the kernel is the wrong place. This should be fixed
> > in user space.
> 
> Sure, but that would be a change in behavior.  It's arguably the right thing 
> to do though.

Change what behaviour? I argue that doing it in the kernel is the wrong
thing.

-Andi
