Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbUKCUHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUKCUHi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbUKCUHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:07:37 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:47112 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261832AbUKCUHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:07:11 -0500
Date: Wed, 3 Nov 2004 21:13:22 +0100
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, bert hubert <ahu@ds9a.nl>
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041103201322.GA10816@hh.idb.hist.no>
References: <200411030751.39578.gene.heskett@verizon.net> <20041103143348.GA24596@outpost.ds9a.nl> <200411031124.19179.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411031124.19179.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 11:24:19AM -0500, Gene Heskett wrote:
> On Wednesday 03 November 2004 09:33, bert hubert wrote:
> >On Wed, Nov 03, 2004 at 07:51:39AM -0500, Gene Heskett wrote:
> >> But I'd tried to run gnomeradio earlier to listen to the
> >> elections,
> >
> >Depressing enough.
> >
> >> I'd tried to kill the zombie earlier but couldn't.
> >> Isn't there some way to clean up a &^$#^#@)_ zombie?
> >
> >Kill the parent, is the only (portable) way.
> 
> The parent would have been the icon.  It opened its usual sized small 
> window, but never did anything to it. I clicked on closing the 
> window, but 10 seconds later the system asked me if I wanted to kill 
> it as it wasn't responding. I said yes, the window disappeared, but 
> kpm said gomeradio was still present as process 8162, and that wasn't 
> killable.  Funny thing is, on the reboot, it automaticly self 
> restored and ran just fine.
> 
> I consider this as one of linux's achilles heels.  Such a hung and 
> dead process can be properly disposed of by a primitive os called os9 
> because it keeps track of all resources in tables in the kernel 
> memory space.  Issueing a kill procnumber removes the process from 
> the exec queue, reclaims all its memory to the system free memory 
> pool, and removes it from the IRQ service tables if an entry exists 
> there.  Near instant, total cleanup, nothing left, in about 250 
> microseconds max. 1.79 mhz cpu's aren't quite instant :)
> 
Killing a process in linux with "kill -9 oid" also release all resources, 
such as memory and file descriptors.  The resource consumption of a 
"zombie" is measured in bytes, not kilobytes.

> Lets just say that I think having to reboot because of a zombie that 
> has resources locked up, and have the reboot fubared by it too, 
> aren't exactly friendly actions.
> 
Did you try logging out from the graphical user interface,
and then logging in again?
GUI programs are usually children of the window manager (or some
app launcher, all of these quit when you log out.  A plain
zombie started from the GUI will disappear after that.  

Only something stuck in a device driver will need the reboot,
but that tends to be a bug in the driver.
You can try unloading the driver module, but linux has a
nasty tendency to answer that with an OOPS or worse.  When
something goes wrong - it does so properly and thourougly. :-)

> I fully realise that linux has a much more complex method of 
> allocating resources, but doesn't it *know* exactly what resources 
> have been passed out to each process?
> 
Yes it does - the problem is that not all resources are managed
by processes.  Some allocations are managed by drivers, so a driver
bug can get the device into a unuseable state _and_ tie up the
process(es) that were using the driver at the moment.

> And why is there no entry from the kill function into that resource 
> management portion of the kernel so that this could also be done by 
> the linux kernel, say with a "kill --total procnumber"?
> 
Interesting, but you might need a path from "kill" into
every device driver. :-/  And of course it wtill won't work 
if there is a bug in the driver. 

> Seems like a heck of a good question to me since an os written to run 
> on a 64k machine in 1981, and expanded to run on a 128K to 2 megabyte 
> machine in 1986 can do it just fine.  Even if that process is still 
> running and spitting out data to its parent window/shell!  Or if its 
> crashed and scribbled over all its memory, makes no difference to 
> os9.  You (root) wants it gone, fine, its gone.
> 
Can os9 do this if the process is busy calling into a buggy
device driver that simply doesn't return or perhaps believes
that some dma operation into process memory is taking forever?
Or perhaps os9 doesn't have lots and lots of drivers written by
different people with varying competence? 

Often, the real solution is to fix the driver to deal with
"unexpected" conditions.

Helge Hafting

