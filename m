Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbUKCQYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUKCQYZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 11:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbUKCQYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 11:24:25 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:39058 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261681AbUKCQYU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 11:24:20 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 3 Nov 2004 11:24:19 -0500
User-Agent: KMail/1.7
Cc: bert hubert <ahu@ds9a.nl>
References: <200411030751.39578.gene.heskett@verizon.net> <20041103143348.GA24596@outpost.ds9a.nl>
In-Reply-To: <20041103143348.GA24596@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411031124.19179.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.46.51] at Wed, 3 Nov 2004 10:24:19 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 09:33, bert hubert wrote:
>On Wed, Nov 03, 2004 at 07:51:39AM -0500, Gene Heskett wrote:
>> But I'd tried to run gnomeradio earlier to listen to the
>> elections,
>
>Depressing enough.
>
>> I'd tried to kill the zombie earlier but couldn't.
>> Isn't there some way to clean up a &^$#^#@)_ zombie?
>
>Kill the parent, is the only (portable) way.

The parent would have been the icon.  It opened its usual sized small 
window, but never did anything to it. I clicked on closing the 
window, but 10 seconds later the system asked me if I wanted to kill 
it as it wasn't responding. I said yes, the window disappeared, but 
kpm said gomeradio was still present as process 8162, and that wasn't 
killable.  Funny thing is, on the reboot, it automaticly self 
restored and ran just fine.

I consider this as one of linux's achilles heels.  Such a hung and 
dead process can be properly disposed of by a primitive os called os9 
because it keeps track of all resources in tables in the kernel 
memory space.  Issueing a kill procnumber removes the process from 
the exec queue, reclaims all its memory to the system free memory 
pool, and removes it from the IRQ service tables if an entry exists 
there.  Near instant, total cleanup, nothing left, in about 250 
microseconds max. 1.79 mhz cpu's aren't quite instant :)

Lets just say that I think having to reboot because of a zombie that 
has resources locked up, and have the reboot fubared by it too, 
aren't exactly friendly actions.

I fully realise that linux has a much more complex method of 
allocating resources, but doesn't it *know* exactly what resources 
have been passed out to each process?

And why is there no entry from the kill function into that resource 
management portion of the kernel so that this could also be done by 
the linux kernel, say with a "kill --total procnumber"?

Seems like a heck of a good question to me since an os written to run 
on a 64k machine in 1981, and expanded to run on a 128K to 2 megabyte 
machine in 1986 can do it just fine.  Even if that process is still 
running and spitting out data to its parent window/shell!  Or if its 
crashed and scribbled over all its memory, makes no difference to 
os9.  You (root) wants it gone, fine, its gone.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
