Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265516AbTFMUIU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 16:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265518AbTFMUIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 16:08:20 -0400
Received: from angband.namesys.com ([212.16.7.85]:30594 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S265516AbTFMUIS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 16:08:18 -0400
Date: Sat, 14 Jun 2003 00:22:05 +0400
From: Oleg Drokin <green@namesys.com>
To: Christian Jaeger <christian.jaeger@ethlife.ethz.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lockups with loop'ed sparse files on reiserfs?
Message-ID: <20030613202205.GB22032@namesys.com>
References: <p04320407bb0f79fd523e@[192.168.3.11]> <20030613155634.GA18478@namesys.com> <20030613155934.GA19307@namesys.com> <p04320409bb0fb23f89f8@[192.168.3.11]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p04320409bb0fb23f89f8@[192.168.3.11]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jun 13, 2003 at 08:07:55PM +0200, Christian Jaeger wrote:

> >Any chance to hit say sysrq-T/sysrq-P to find out where CPU spins?
> I've never used those, I'll have to learn about those debugging 
> options first. Where should I go to?

Read /usr/src/linux/Documentation/sysrq.txt

> Now the question is wbat happens if a partition is full.

There were a known problem with reiserfs that it might sometimes
deadlock in out-of-space situation.
This is fixed in 2.4.21

> In fact I've seen this in kern.log (full log at
> http://pflanze.mine.nu/~chris/scratch/kern.log ):
> Jun 13 11:34:57 pflanze kernel: raid5: md0, not all disks are 
> operational -- trying to recover array
> ...
> Jun 13 11:34:57 pflanze kernel: md0: resyncing spare disk [dev 07:07] 
> to replace failed disk

This is raid5 stuff resyncing. Probably it is normal if you just
setup the raid5 array.

> What does happen if a raid array fails (i.e. 2 disks fail and there's 
> no spare, or 1 spare and 3 disks fail etc.)? If it's not an important 

Everything that will access this array will break, I presume ;)

> array (i.e. no swap or root filesystem on it), is there a reason for 
> the system to go down? Isn't it possible to just mark the mounted 
> filesystem  as erroneous and return EIO to applications accessing it?

Something like that will happen.

> There's also the case 1, using uml. In this case I'm sure there was 
> no problem with space. The sparse filesystem image file I used is 
> exactly 500'000'000 bytes, and there's 1675228 k free space on the 
> partition where it is put on.

Ok, that's where sysrq-T/sysrq-P traceswould be most useful.
And if you'd try with 2.4.21 that would be even better.

Thank you.

Bye,
    Oleg
