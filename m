Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUCMClB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 21:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbUCMClB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 21:41:01 -0500
Received: from florence.buici.com ([206.124.142.26]:41856 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S263028AbUCMCk7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 21:40:59 -0500
Date: Fri, 12 Mar 2004 18:40:58 -0800
From: Marc Singer <elf@buici.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Marc Lehmann <pcg@schmorp.de>, linux-kernel@vger.kernel.org,
       Joe Thornber <thornber@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: strange ext3 corruption problem on 2.6.x
Message-ID: <20040313024057.GA2207@buici.com>
References: <20040313004707.GA389@schmorp.de> <20040312183423.71d7bbb9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312183423.71d7bbb9.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 06:34:23PM -0800, Andrew Morton wrote:
> Marc Lehmann <pcg@schmorp.de> wrote:
> >
> >  I use lvm-over-raid5 and get these messages once a day (requiring a reboot
> >  afterwards):
> > 
> >     EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #4804801: directory entry across blocks - offset=0, inode=0, rec_len=50000,
> >     name_len=152
> >     Aborting journal on device dm-0.
> 
> (and fsck comes up clean)
> 
> There have been earlier reports of this.  Too many for it to be some random
> glitch.   We've had similar reports in 2.4, usually with raid5.
> 
> I'm fairly confident in ext3 - it's hard to think of an ext3-level bug
> which wouldn't have 10x as many reports from non-md users.  But perhaps
> some timing unique to the MD layer is triggering some ext3 bug.
> 
> Joe, Neil: have you spotted reports like this?  Any suggestions as to how
> to track it down a bit?

I, too, have been experiencing this with ext3 on top of lvm on top of
raid5.  I also have a dual-proc machine.

It seems to be some sort of race condition because it is triggered by
multiple disk-io intensive processes using the same volume.  Many
mornings, when I first login to this machine which runs all of the
time, I find that one or more of the volumes is mounted read-only.
Sometimes e2fsck shows errors and sometimes it doesn't.


