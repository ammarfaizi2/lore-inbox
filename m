Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVAPCwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVAPCwE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 21:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVAPCwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 21:52:04 -0500
Received: from waste.org ([216.27.176.166]:38345 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262408AbVAPCwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 21:52:00 -0500
Date: Sat, 15 Jan 2005 18:51:59 -0800
From: Matt Mackall <mpm@selenic.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: short read from /dev/urandom
Message-ID: <20050116025159.GB3867@waste.org>
References: <41E7509E.4030802@redhat.com> <20050114191056.GB17481@thunk.org> <41E833F4.8090800@redhat.com> <20050114232154.GB18479@thunk.org> <cs9vk8$43q$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cs9vk8$43q$1@terminus.zytor.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 02:36:56AM +0000, H. Peter Anvin wrote:
> Followup to:  <20050114232154.GB18479@thunk.org>
> By author:    "Theodore Ts'o" <tytso@mit.edu>
> In newsgroup: linux.dev.kernel
> > 
> > Good point.  The fact that there are other implementations out there
> > which are doing this is a convincing argument.  
> > 
> > I am still a bit concerned still that a stupidly written program that
> > opens /dev/urandom (perhaps unwittingly) and tries to read a few
> > hundred megabytes will become uninterruptible until the read
> > completes, but I'm not sure it's worth it to but in some kludge that
> > says "break if there's a signal and count > 1 megabyte --- otherwise
> > we'll return soon enough".
> > 
> 
> I'm very concerned about this; this is fundamentally a change to
> signal delivery semantics.
> 
> What we might want to go along with is a read smaller than PIPE_BUF
> (the largest size guaranteed to be atomic when writing to a pipe,
> which is another special case) should not return fractional.

What about signals to a process blocked on /dev/random (which also has no
documented mention of being interruptible by signals)?

Not handling short reads is always a bug.

-- 
Mathematics is the supreme nostalgia of our time.
