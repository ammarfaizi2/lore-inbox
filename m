Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbUKCUkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbUKCUkz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbUKCUkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:40:55 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:52133 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261856AbUKCUkH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:40:07 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 3 Nov 2004 15:40:03 -0500
User-Agent: KMail/1.7
Cc: Helge Hafting <helgehaf@aitel.hist.no>, bert hubert <ahu@ds9a.nl>
References: <200411030751.39578.gene.heskett@verizon.net> <200411031124.19179.gene.heskett@verizon.net> <20041103201322.GA10816@hh.idb.hist.no>
In-Reply-To: <20041103201322.GA10816@hh.idb.hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411031540.03598.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.46.51] at Wed, 3 Nov 2004 14:40:04 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 15:13, Helge Hafting wrote:
>On Wed, Nov 03, 2004 at 11:24:19AM -0500, Gene Heskett wrote:
[...]
>> Lets just say that I think having to reboot because of a zombie
>> that has resources locked up, and have the reboot fubared by it
>> too, aren't exactly friendly actions.
>
>Did you try logging out from the graphical user interface,
>and then logging in again?

It took around 2 minutes for the logout of X to get back to a VC.
So obviously something slowed it down as thats a 4 second operation 
here normally.  And it didn't surprise me when the "reboot" shutdown 
hung on "stopping alsasound" and I had to use the reset button.
[...]
>> I fully realise that linux has a much more complex method of
>> allocating resources, but doesn't it *know* exactly what resources
>> have been passed out to each process?
>
>Yes it does - the problem is that not all resources are managed
>by processes.  Some allocations are managed by drivers, so a driver
>bug can get the device into a unuseable state _and_ tie up the
>process(es) that were using the driver at the moment.

This from my viewpoint, is wrong.  The kernel, and only the kernel 
should be ultimately responsible for handing out resources, and 
reclaiming at its convienience.

>> And why is there no entry from the kill function into that
>> resource management portion of the kernel so that this could also
>> be done by the linux kernel, say with a "kill --total procnumber"?
>
>Interesting, but you might need a path from "kill" into
>every device driver. :-/  And of course it wtill won't work
>if there is a bug in the driver.

Thats the fault of the design IMO.

>> Seems like a heck of a good question to me since an os written to
>> run on a 64k machine in 1981, and expanded to run on a 128K to 2
>> megabyte machine in 1986 can do it just fine.  Even if that
>> process is still running and spitting out data to its parent
>> window/shell!  Or if its crashed and scribbled over all its
>> memory, makes no difference to os9.  You (root) wants it gone,
>> fine, its gone.
>
>Can os9 do this if the process is busy calling into a buggy
>device driver that simply doesn't return or perhaps believes
>that some dma operation into process memory is taking forever?
>Or perhaps os9 doesn't have lots and lots of drivers written by
>different people with varying competence?

It did have quite a few authors involved in it over the years 
including me, I did many of its utilities, and converted the rbf.mn 
from 6809 code to 6309 code, roughly doubleing its speed without 
fiddling with the clock speed, which is married to the video on that 
machine.  I also did a couple of its clock modules, which are the 
heart of the multitasking it does.  And yes, it could kill, 
absolutely cleanly, any process you named on the command line at any 
time.  Any drivers involved got their scratch space from the callers 
loading of a set of pointers, so if a driver was being accessed by 2 
or more processes, each instance had its own stack/process space.  
When the process disappeared, the recovery included that space in 
memory.  The driver proper had no long term history of that processes 
actions, even if a disk seek microsleep or similar was in progress 
when the caller disappeared.

>Often, the real solution is to fix the driver to deal with
>"unexpected" conditions.
>
>Helge Hafting

As I said earlier, lets let this horse be buried, "its dead Jim", and 
my beating on it is only wasting bandwitdh.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
