Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262750AbVDHIAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbVDHIAb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVDHIAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 04:00:06 -0400
Received: from waste.org ([216.27.176.166]:20620 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262749AbVDHH5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:57:03 -0400
Date: Fri, 8 Apr 2005 00:55:32 -0700
From: Matt Mackall <mpm@selenic.com>
To: Simon Derr <Simon.Derr@bull.net>
Cc: Yura Pakhuchiy <pakhuchiy@iptel.by>,
       Patrice Martinez <patrice.martinez@ext.bull.net>,
       linux-kernel@vger.kernel.org
Subject: Re: /dev/random problem on 2.6.12-rc1
Message-ID: <20050408075532.GX3174@waste.org>
References: <42552A33.6070704@ext.bull.net> <1112879666.2035.10.camel@chaos.void> <Pine.LNX.4.58.0504071727080.5654@localhost.localdomain> <20050407211257.GK25554@waste.org> <Pine.LNX.4.61.0504080817370.15652@openx3.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504080817370.15652@openx3.frec.bull.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 08:56:51AM +0200, Simon Derr wrote:
> On Thu, 7 Apr 2005, Matt Mackall wrote:
> 
> > On Thu, Apr 07, 2005 at 05:36:59PM +0200, Simon Derr wrote:
> > > 
> > > 
> > > On Thu, 7 Apr 2005, Yura Pakhuchiy wrote:
> > > 
> > > > On Thu, 2005-04-07 at 14:40 +0200, Patrice Martinez wrote:
> > > > > When  using a machine with a  2612-rc 1kernel, I encounter problems
> > > > > reading /dev/random:
> > > > >  it simply nevers returns anything, and the process is blocked in the
> > > > > read...
> > > > > The easiest way to see it is to type:
> > > > >  od < /dev/random
> > > > >
> > > > > Any idea?
> > > >
> > > > Because, /dev/random use user input, mouse movements and other things to
> > > > generate next random number. Use /dev/urandom if you want version that
> > > > will never block your machine.
> > > >
> > > > Read "man 4 random" for details.
> > > >
> > > Something changed since previous versions of the kernel, I guess.
> > > Running `find /usr | wc' on a ssh session generates both network and disk
> > > activity, and you should not expect any other kind of input on a networked
> > > server.
> > 
> Oops, the command is actually "find /usr | xargs wc", witch causes lots of 
> disk activity.
> 
> > FYI, network activity only generates entropy on a very small subset of
> > NICs, and probably not the one you're using. This is good, as network
> > activity is assumed passively observable/timable.
> Offtopic, but why isn't the policy the same for all NICs ?

The policy is the same, it just hasn't been implemented. SA_RANDOM
is scheduled for abolishment.
  
> > > Anyway, still zero bytes coming from /dev/random, for the few minutes I
> > > waited.
> > 
> > Are you and Patrice both experiencing this on the same machine? 
> Both IA-64, but that's the only common point.
> 
> > What
> > was the last kernel that was known to work for you? Do you see the
> > contents of /proc/sys/kernel/random/entropy_avail change over time?
> > Are there any other entropy consumers on your machine?
> None that I am aware of.
> 
> I run:
> # dd if=/dev/random bs=1 count=1 | od

strace the dd process, please. This works fine here.
  
> Another shell:
> # lsof /dev/random
> COMMAND  PID USER   FD   TYPE DEVICE SIZE  NODE NAME
> dd      1496 root    0r   CHR    1,8      99952 /dev/random
> 
> Now, find /usr | xargs wc running in background.
> 
> About /proc/sys/kernel/random/entropy_avail:
> (5 second refresh interval)

That may not be sufficient resolution. The upper layers will pull from
it whenever it rises above 64 and bash it back down to within 7 bits
of 0. What does it do when no one is reading from it?

-- 
Mathematics is the supreme nostalgia of our time.
