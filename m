Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130873AbRCTUde>; Tue, 20 Mar 2001 15:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130831AbRCTUdY>; Tue, 20 Mar 2001 15:33:24 -0500
Received: from zeus.kernel.org ([209.10.41.242]:54725 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130777AbRCTUdR>;
	Tue, 20 Mar 2001 15:33:17 -0500
Date: Tue, 20 Mar 2001 14:29:01 -0600 (CST)
From: Josh Grebe <squash@primary.net>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question about memory usage in 2.4 vs 2.2
In-Reply-To: <20010320135449.A24252@cs.cmu.edu>
Message-ID: <Pine.LNX.4.21.0103201403440.2405-100000@scarface.primary.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

slabinfo reports:

inode_cache       189974 243512    480 30439 30439    1 :  124   62
dentry_cache      201179 341940    128 11398 11398    1 :  252  126

However, I am hard pressed to find documentation on how to actually read
this data, especially on a SMP box. Could someone give me a brief
runwdown? 

Also, if this memory is cached, wouldn't it make sense if it were reported
as part of the total cached memory in /proc/meminfo?  And can this
behavior be tuned so that it uses less of the overall memory?

Thanks,

Josh

---
Josh Grebe
Senior Unix Systems Administrator
Primary Network, an MPower Company
http://www.primary.net

On Tue, 20 Mar 2001, Jan Harkes wrote:

> On Tue, Mar 20, 2001 at 11:01:52AM -0600, Josh Grebe wrote:
> > Greetings,
> > 
> > I have a server farm made of identical hardware running pop3 and imap mail
> > functions. recently, we upgraded all the machines to kernel 2.4.2, but we
> > noticed that according to free, our memory utilization went way up. Here
> > is the output of free on the 2.4.2 machine:
> >              total       used       free     shared    buffers     cached
> > Mem:        513192     492772      20420          0       1684     263188
> > -/+ buffers/cache:     227900     285292
> > Swap:       819304        540     818764
> > 
> > 
> > On the 2.2..18 machine:
> >              total       used       free     shared    buffers     cached
> > Mem:        517256     351280     165976      19920      82820     186836
> > -/+ buffers/cache:      81624     435632
> > Swap:       819304          0     819304
> > 
> > 
> > Doing the math, the 2.4 machine is using 44% of available memory, while
> > the 2.2 is using only about 14%.
> 
> What does /proc/slabinfo report for the number of pages locked down in
> the inode and dentry caches? My machine has pretty much every inode in
> memory and is using close to 50% of my memory for these (214MB/512MB).
> 
> These caches do not seem to be counted towards 'reclaimable' memory by
> the new VM and are only pruned when _all_ other attempts to free up
> memory have failed.
> 
> This becomes very noticeable on a not very fast, small memory machine
> (i.e. 48MB sparc-IPC), where 2.2 stays relatively snappy, but 2.4
> becomes unusable after an updatedb run.
> 
> Jan
> 



