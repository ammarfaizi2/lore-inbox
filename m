Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130824AbRCTSzx>; Tue, 20 Mar 2001 13:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130831AbRCTSzn>; Tue, 20 Mar 2001 13:55:43 -0500
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:37067 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S130824AbRCTSze>; Tue, 20 Mar 2001 13:55:34 -0500
Date: Tue, 20 Mar 2001 13:54:49 -0500
To: Josh Grebe <squash@primary.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about memory usage in 2.4 vs 2.2
Message-ID: <20010320135449.A24252@cs.cmu.edu>
Mail-Followup-To: Josh Grebe <squash@primary.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200103190207.UAA13397@senechalle.net> <Pine.LNX.4.21.0103201038140.2405-100000@scarface.primary.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.21.0103201038140.2405-100000@scarface.primary.net>; from squash@primary.net on Tue, Mar 20, 2001 at 11:01:52AM -0600
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2001 at 11:01:52AM -0600, Josh Grebe wrote:
> Greetings,
> 
> I have a server farm made of identical hardware running pop3 and imap mail
> functions. recently, we upgraded all the machines to kernel 2.4.2, but we
> noticed that according to free, our memory utilization went way up. Here
> is the output of free on the 2.4.2 machine:
>              total       used       free     shared    buffers     cached
> Mem:        513192     492772      20420          0       1684     263188
> -/+ buffers/cache:     227900     285292
> Swap:       819304        540     818764
> 
> 
> On the 2.2..18 machine:
>              total       used       free     shared    buffers     cached
> Mem:        517256     351280     165976      19920      82820     186836
> -/+ buffers/cache:      81624     435632
> Swap:       819304          0     819304
> 
> 
> Doing the math, the 2.4 machine is using 44% of available memory, while
> the 2.2 is using only about 14%.

What does /proc/slabinfo report for the number of pages locked down in
the inode and dentry caches? My machine has pretty much every inode in
memory and is using close to 50% of my memory for these (214MB/512MB).

These caches do not seem to be counted towards 'reclaimable' memory by
the new VM and are only pruned when _all_ other attempts to free up
memory have failed.

This becomes very noticeable on a not very fast, small memory machine
(i.e. 48MB sparc-IPC), where 2.2 stays relatively snappy, but 2.4
becomes unusable after an updatedb run.

Jan

