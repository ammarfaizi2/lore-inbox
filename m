Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288495AbSADF03>; Fri, 4 Jan 2002 00:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288498AbSADF0U>; Fri, 4 Jan 2002 00:26:20 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:6154 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S288495AbSADF0G>; Fri, 4 Jan 2002 00:26:06 -0500
Date: Thu, 3 Jan 2002 23:26:01 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020103232601.B12884@asooo.flowerfire.com>
In-Reply-To: <20020103142301.C4759@asooo.flowerfire.com> <200201040019.BAA30736@webserver.ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200201040019.BAA30736@webserver.ithnet.com>; from skraw@ithnet.com on Fri, Jan 04, 2002 at 01:19:28AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 01:19:28AM +0100, Stephan von Krawczynski wrote:
| > A) VM has major issues                                              
|                                                                       
| On all boxes I run currently (all 1GB or below RAM), I cannot find    
| _major_ issues.                                                       

Yeah, I'm seeing it primarily with 1-4GB, though I have very few <1GB
machines in production.

| > 2) VM falls down on large-memory machines with a                    
| >    high inode count (slocate/updatedb, i/dcache)                    
|                                                                       
| Must be beyond the GB range.                                          

The critical part is the high inode count -- memory amount increases the
severity rather than triggering the problem.

| > 3) Memory allocation failures and OOM triggers                      
| >    even though caches remain full.                                  
|                                                                       
| I have not had one up to now in everyday life with 2.4.17             

I'm seeing this in malloc()-heavy apps, but fairly sporadic unless I
create a test case.  On desktops, most of these issues disappear, but I
do think the mindset behind the kernel needs to at least partially break
free of the grip of UP desktops, at least to the point of fixing issues
like I'm mentioning.

Not critical for me; but high-profile on lkml.

[...]
| > C) IO-APIC code that requires noapic on any and all SMP             
| >   machines that I've ever run on.                                   
|                                                                       
| I am currently running 5 Asus CUV4X-D based SMP boxes all with apic   
| _on_, amongst  which are squids, sql servers, workstation type setups 
| (2 my very own).                                                      

Do they have *sustained* heavy hit/IRQ/IO load?  For example, sending
25Mbit and >1,000 connections/s of sustained small images traffic
through khttpd will kill 2.4 (slow loss of timer and eventual total
freeze) in a couple of hours.  Trivially reproducable for me on SMP with
any amount of memory.  On HP, Tyan, Intel, Asus... etc.

| Have you run _yourself_ into a problem with 2.4.17?                   
| I mean it is not perfect of course, but it is far better than you make
| it look.                                                              

2.4.17 (and -pre/-rc) is my yardstick, actually.  With the exception of
-aa, I stay very close to the bleeding edge.

Please don't misunderstand -- I don't think any 2.4 kernel sucks (with
the exception of the two or three DONTUSE kernels. :)  In fact, I have
zero complaints other than the ones I've listed.  I was ecstatic when
2.2 came out, and 2.4 is just as impressive.

It's not that the kernel is bad, it's that there are specific things
that shouldn't be forgotten because of a "the kernel is good"
evaluation.  Especially those that make Linux regularly unstable in
common production environments.

| I could hand the brown bag to all versions below about 2.4.15  pretty 
| easy, but since 2.4.16 it has really become hard to shoot it down for 
| me. Ok, I use only pretty selected hardware, but there are reasons I  
| do, and they are not related to the kernel in first place.            

I use pretty selected hardware as well -- scaling hundreds of servers
for varied uses really depends on having someone track and select
hardware, and using it homogenously.  Of course, of all of the selected
hardware I've used over the last two years since 2.4.0-test1, C) has
persisted on all configurations, but the others are more recent but
equally omnipresent.

Like I said, I suspect that most people with machines in lower-load
environments don't have these issues, but "number of people effected" is
only one metric to judge the importance of an issue.

Of course, I'm not biased or anything. ;-)

Thanks for the input,
-- 
Ken.
brownfld@irridia.com


|                                                                       
| Regards,                                                              
| Stephan                                                               
|                                                                       
