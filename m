Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267646AbSLSLnk>; Thu, 19 Dec 2002 06:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267647AbSLSLnk>; Thu, 19 Dec 2002 06:43:40 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:20031 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S267646AbSLSLnj>;
	Thu, 19 Dec 2002 06:43:39 -0500
Date: Thu, 19 Dec 2002 12:51:23 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: jiri.wichern@hccnet.nl, "" <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: kernel 2.4.20 option CONFIG_BLK_STATS breaks /proc/partitons so "mount" can't mount devices by UUID.
Message-ID: <20021219115123.GA12670@win.tue.nl>
References: <3DFE6ED2.7174.1395ABF@localhost> <20021217005539.GA11900@win.tue.nl> <Pine.LNX.4.50L.0212181330100.3431-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0212181330100.3431-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 01:31:44PM -0200, Marcelo Tosatti wrote:

> Could you please expand on the "sporadically" so we can inform the user in
> a better way when he should not use CONFIG_BLK_STATS ?

He should never use it.

We had extensive discussion a few months ago, and I gave you
these Bugzilla references. Maybe you were confused because this
CONFIG_BLK_STATS code also was buggy, but that is unrelated.

Older versions of mount, fdisk and also the lvmutils, fail
because they expect the original format.

Later versions of mount and fdisk - I don't know about lvmutils -
just parse the start of a line, and hence can cope with additional
stuff at the end of the line.

But there is something else. One of the problems with statistics
in /proc/partitions is that the file changes dynamically - some
statistic can go from 99 to 100 and take a position more. A program
reading it will get bad data if it reads a buffer and then the next,
and between the two reads the contents shifts.

So far two solutions have been proposed:
A user side one: Tell stdio to use a very large buffer, in the hope
that all will be read at once. (This is what RedHat does.)
And a kernel side one: Make sure the kernel generates constant
length output.

[But it is really ridiculous to put ugly hacks in lots of programs -
Why? In order to avoid changing a single filename in sar?
Break mount in order not to break sar?
I still hope you remove this garbage again.]

Andries

