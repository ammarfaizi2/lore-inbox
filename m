Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292280AbSBBNkZ>; Sat, 2 Feb 2002 08:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292281AbSBBNkQ>; Sat, 2 Feb 2002 08:40:16 -0500
Received: from mail008.syd.optusnet.com.au ([203.2.75.232]:199 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S292280AbSBBNkL>; Sat, 2 Feb 2002 08:40:11 -0500
Date: Sun, 3 Feb 2002 00:39:37 +1100
From: Andrew Clausen <clausen@gnu.org>
To: Kevin Corry <corryk@us.ibm.com>
Cc: Joe Thornber <thornber@fib011235813.fsnet.co.uk>, linux-lvm@sistina.com,
        evms-devel@lists.sourceforge.net, Jim McDonald <Jim@mcdee.net>,
        Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: [evms-devel] [linux-lvm] [ANNOUNCE] LVM reimplementation ready for beta testing
Message-ID: <20020203003937.B874@gnu.org>
In-Reply-To: <OFBCE93B66.F7B9C14E-ON85256B52.006B8AB3@raleigh.ibm.com> <20020131125211.A8934@fib011235813.fsnet.co.uk> <02020115304301.00650@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <02020115304301.00650@boiler>; from corryk@us.ibm.com on Fri, Feb 01, 2002 at 03:59:06PM -0600
X-Accept-Language: en,pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 03:59:06PM -0600, Kevin Corry wrote:
> Current MD and LVM1: 11105 (this includes drivers/md, include/linux/lvm.h, 
> and include/linux/raid/)

Why are you counting MD?  It should be trivial to implement raid
with device-mapper.

> So I will agree - device-mapper does provide a nice, general-purpose I/O 
> remapping service in a small amount of code.

It provides everything you need (from a kernel) to do Volume
Management in general.  (What's missing?)

> And if you consider that EVMS has 
> implemented support for LVM1 and MD, then EVMS is really only adding 6580 
> lines of code to the kernel.

Yep, it's not the size, but the complexity.

device-mapper is *simple*.  It couldn't be simpler!
simple is *good*, as long as it's not "too simple", in the sense
that it doesn't get the job done.  So, tell us what the disadvantages
of device-mapper's "simplemindedness" is!

> In this scenario, we would wind up with exposed devices for every item in 
> this graph (except the volume group). But in reality, we don't want someone 
> coming along and mucking with md0 or with LV2 or with any of the disk 
> partitions, because they are all in use by the two volumes at the top.

It's the user's fault if they choose to write on such a device.

> As we know, EVMS does volume discovery in the kernel. LVM1 does discovery in 
> user-space, but Joe has hinted at an in-kernel LVM1 discovery module to work 
> with device-mapper. Back when we started on EVMS, people were basically 
> shouting "we need in-kernel discovery!",

Not me!  Anyway, device-mapper is compatible with in-kernel discovery.
But, why not just stick it in initramfs?  (Are there any Issues?)

> My belief is that it's the 
> kernel's job to tell user-space what the hardware looks like, not the other 
> way around.  If we move partition/volume/etc discovery into user-space, at 
> what point do we move device recognition into user-space?

There's a big difference: partition discovery isn't actually a hardware
thing, it's a software thing.

Some types of device recognition (iSCSI?) are also software things.

WRT: beliefs, I think the kernel should provide all the services that
can't be implemented well in userspace.

> Looking down that 
> path just seems more and more like a micro-kernel approach, and I'm sure we 
> don't want to rehash that discussion.

What's your point?

> Next, from what I've seen, device-mapper provides static remappings from one 
> device to another. It seems to be a good approach for setting up things like 
> disk partitions and LVM linear LVs. There is also striping support in 
> device-mapper, but I'm assuming it uses one notion of striping. For instance, 
> RAID-0 striping in MD is handled differently than striped LVs in LVM, and I 
> think AIX striping is also different. I'm not sure if one stiping module 
> could be generic enough to handle all of these cases.

Why do you need a single striping module?

> How about mirroring? Does the linear module in device-mapper allow for 1-to-n 
> mappings?

Wouldn't you use the strip module, with the chunk size set to
a good approximation of infinity?  Haven't tried it...

Anyway, this is just a small detail... if there was no way of doing it,
it would be easy to add a module...

> So another device-mapper "module" 
> would need to be written to handle bad-block.  This implicitly limits the 
> capabilities of device-mapper, or else ties it directly to the recognition 
> code. For EVMS and device-mapper to work together, we would have to agree on 
> metadata formats for these types of modules. Other similar example that come 
> to mind are RAID-5 and block-level encryption.

Agreed... but these shouldn't be big problems?  (raid-5 is already
a standard...)

Andrew
