Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265348AbUG3DOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265348AbUG3DOn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 23:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267563AbUG3DOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 23:14:43 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:54281 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S265348AbUG3DOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 23:14:39 -0400
To: FabF <fabian.frederick@skynet.be>
Cc: lkml <linux-kernel@vger.kernel.org>
From: Tim Connors <tconnors+linuxkernel1091156355@astro.swin.edu.au>
Subject: Re: symlinks follow 8 or 5?
In-reply-to: <1091079278.1999.5.camel@localhost.localdomain>
References: <1091079278.1999.5.camel@localhost.localdomain>
X-Face: m+g#A-,3D0}Ygy5KUD`Hckr=I9Au;w${NzE;Iz!6bOPqeX^]}KGt=l~r!8X|W~qv'`Ph4dZczj*obWD25|2+/a5.$#s23k"0$ekRhi,{cP,CUk=}qJ/I1acc
Message-ID: <slrn-0.9.7.4-22364-14114-200407301259-tc@hexane.ssi.swin.edu.au>
Date: Fri, 30 Jul 2004 13:14:24 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF <fabian.frederick@skynet.be> said on Thu, 29 Jul 2004 07:34:39 +0200:
> Hi,
> 	do_follow_link comments is "This limits recursive symlink follows to 8"
> ... but having (x=1->10) ln -s x+1 x and trying cat 1 just works for x <
> 7 which drops follow mode to 5.Is this irrelevant ?

This popped up a few years ago.
http://www.ussg.iu.edu/hypermail/linux/kernel/9903.1/0018.html

Obviously, nothing came about it. And I suspect the problem (running
out of stack space) is even worse these days with 4k stacks. Why is
this even done recursively?

Note that 5 symlinks is quite a burden. I got hit by it a few days ago
with my farm of symlinks between nfs RAID disks and my home directory
(~/raid points to /nfs/cluster, papers refers to ~/raid/papers,
Astro-ph refers to ~/papers/Astro-ph, and then I autofs shfs mounted
~/ from another host, which involve a couple of symlinks again (/host
to /mnt/nfshost and /mnt/nfshost to /var/autofs/misc/host and ~/host
to /host - the first two so that when the network goes down, all I
have to do is remove (by script) /mnt/nfshost, and then autofs wont
try to mount something it can't when something tries to access
~/host)).

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
"We must use Tim as a tool, not as a couch." -- J F Kennedy
