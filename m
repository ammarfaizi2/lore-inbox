Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262711AbVDHG5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbVDHG5T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 02:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbVDHG5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 02:57:19 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:49794 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262711AbVDHG5B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 02:57:01 -0400
Date: Fri, 8 Apr 2005 08:56:51 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Matt Mackall <mpm@selenic.com>
Cc: Simon Derr <simon.derr@bull.net>, Yura Pakhuchiy <pakhuchiy@iptel.by>,
       Patrice Martinez <patrice.martinez@ext.bull.net>,
       linux-kernel@vger.kernel.org
Subject: Re: /dev/random problem on 2.6.12-rc1
In-Reply-To: <20050407211257.GK25554@waste.org>
Message-ID: <Pine.LNX.4.61.0504080817370.15652@openx3.frec.bull.fr>
References: <42552A33.6070704@ext.bull.net> <1112879666.2035.10.camel@chaos.void>
 <Pine.LNX.4.58.0504071727080.5654@localhost.localdomain> <20050407211257.GK25554@waste.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/04/2005 09:06:48,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/04/2005 09:06:49,
	Serialize complete at 08/04/2005 09:06:49
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2005, Matt Mackall wrote:

> On Thu, Apr 07, 2005 at 05:36:59PM +0200, Simon Derr wrote:
> > 
> > 
> > On Thu, 7 Apr 2005, Yura Pakhuchiy wrote:
> > 
> > > On Thu, 2005-04-07 at 14:40 +0200, Patrice Martinez wrote:
> > > > When  using a machine with a  2612-rc 1kernel, I encounter problems
> > > > reading /dev/random:
> > > >  it simply nevers returns anything, and the process is blocked in the
> > > > read...
> > > > The easiest way to see it is to type:
> > > >  od < /dev/random
> > > >
> > > > Any idea?
> > >
> > > Because, /dev/random use user input, mouse movements and other things to
> > > generate next random number. Use /dev/urandom if you want version that
> > > will never block your machine.
> > >
> > > Read "man 4 random" for details.
> > >
> > Something changed since previous versions of the kernel, I guess.
> > Running `find /usr | wc' on a ssh session generates both network and disk
> > activity, and you should not expect any other kind of input on a networked
> > server.
> 
Oops, the command is actually "find /usr | xargs wc", witch causes lots of 
disk activity.

> FYI, network activity only generates entropy on a very small subset of
> NICs, and probably not the one you're using. This is good, as network
> activity is assumed passively observable/timable.
Offtopic, but why isn't the policy the same for all NICs ?
 
> > Anyway, still zero bytes coming from /dev/random, for the few minutes I
> > waited.
> 
> Are you and Patrice both experiencing this on the same machine? 
Both IA-64, but that's the only common point.

> What
> was the last kernel that was known to work for you? Do you see the
> contents of /proc/sys/kernel/random/entropy_avail change over time?
> Are there any other entropy consumers on your machine?
None that I am aware of.

I run:
# dd if=/dev/random bs=1 count=1 | od
 
Another shell:
# lsof /dev/random
COMMAND  PID USER   FD   TYPE DEVICE SIZE  NODE NAME
dd      1496 root    0r   CHR    1,8      99952 /dev/random

Now, find /usr | xargs wc running in background.

About /proc/sys/kernel/random/entropy_avail:
(5 second refresh interval)

0
0
0
0
[lots of 0]
0
0
0
6
0
8
2
0
0
[lots of 0]
0
0
0
3
1
0
0
[lots of 0]
0
0
0

...


After 10 minutes, dd is still running.

This is on Linux 2.6.12-rc1-bk1, same results for 2.6.12-rc2.

And /dev/random works fine on the same machine with Linux 2.6.11.
(i.e when running "find /usr | xargs wc", /dev/random spits out lots of 
bytes)


	Simon.

