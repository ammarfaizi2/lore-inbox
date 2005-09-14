Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbVINU3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbVINU3F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932767AbVINU3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:29:04 -0400
Received: from smtpout.mac.com ([17.250.248.86]:4838 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932564AbVINU3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:29:02 -0400
In-Reply-To: <20050914200048.GB15017@mikebell.org>
References: <20050909214542.GA29200@kroah.com> <20050910082732.GR13742@mikebell.org> <20050910215254.GA15645@suse.de> <20050910230310.GS13742@mikebell.org> <20050911050906.GA6635@suse.de> <20050914200048.GB15017@mikebell.org>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BB5C2CC6-9BCC-410E-884E-C16749733F36@mac.com>
Cc: Greg KH <gregkh@suse.de>, LKML Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
Date: Wed, 14 Sep 2005 16:28:40 -0400
To: Mike Bell <mike@mikebell.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ CC list trimmed to spare Linus and Andrew the mailbox clutter ]

On Sep 14, 2005, at 16:00:49, Mike Bell wrote:
> On Sat, Sep 10, 2005 at 10:09:06PM -0700, Greg KH wrote:
>> Said people who like devfs are lazy and don't like running  
>> userspace programs.
>
> What I don't like is when someone arbitrarily declares that their  
> half-finished project obsoletes a working one, and yet even a full  
> year later with a massive development community using the latest  
> kernel features (sometimes added specifically for that project) it  
> isn't a full
> replacement for a project that has been - in your own words -  
> unmaintained for years and years.

What exactly does devfs do that udev doesn't, exactly?  I haven't  
been able to find anything on my wide variety of hardware, although I  
will admit that there are some drivers that do not yet fully/ 
correctly use the new driver model.

>> They pretty much also are pretty restricted to embedded systems.   
>> That's all I have been able to determine so far.  Care to help  
>> flush this profile out some?
>
> Probably because they're the people building linux systems from  
> scratch and caring about the size and speed of the result?

udev isn't that big or that slow, especially not the new netlink- 
socket version, so unless you can provide a concrete example, I'm not  
entirely sure what you're talking about.

>> My applogies, I used the OSS compatible module for ALSA when I  
>> tested this out.
>
> And while some input subsystem users force you to specify a device  
> node, this method is incompatible with hotplugging so the more  
> advanced ones rely on finding the input device nodes where they're  
> supposed to be, as they should.

What makes you think specifying nodes is incompatible with  
hotplugging?  I have my USB mouse and keyboard show up as /dev/ 
gyration_mouse and /dev/macally_keyboard, and I point my little input  
event program at those.  Admittedly, X kinda gets confused when I  
unplug and those go away, but X doesn't support hotplugging anyways.

>> Hm, ok, ALSA will not work.  Can you point to anything else?
>
> See above. And of course ndevfs doesn't create the device nodes  
> that udev doesn't support (yes, even in 2.6.12 devfs still  
> supported more devices than udev on my test system).

So there are broken non-new-driver-model drivers.  If you depend on  
them (especially if you depend on them for your commercial product),  
please feel free to fix them, because otherwise they won't be, and  
they'll get more out of date with every kernel release until somebody  
deletes them because they're unmaintained.

> ...before deciding there was no way to make it work without adding  
> sysfs attributes.

See above.  Feel free to fix the driver if you need it.

>> I'm claiming that the people who insisted that keeping the devfs  
>> patchset outside of the mainline kernel was impossible.  I show  
>> how to do this with 3 calls to "add a node" and three calls to  
>> "remove a node", in a total of only 2 different kernel files.   
>> Such a patch is _easily_ maintainable for pretty much forever  
>> outside the kernel tree.  Distros maintain patches _way_ more  
>> complex and rough than that all the time.
>
> ndevfs doesn't work,

Yes it does.  It works correctly for me.

> and isn't even remotely compatible with devfs.

So?  You need to change your /dev paths _now_.  You've known that  
those paths were kinda going away for a _long_ time, so it's not like  
you haven't had time to fix your code that used them.  And if you  
need a kernel-generated /dev, then ndevfs will work (albeit with sane  
paths, as opposed to the old devfs /dev/ide/host0/bus0/... crap).

> Yes, ndevfs is easy to maintain out of the kernel tree. But since  
> ndevfs has absolutely nothing to do with devfs, that doesn't change  
> the fact that devfs can't be maintained out of the kernel tree.

devfs can't be maintained _within_ the kernel tree, let alone _out_  
of it.  Besides, it contained unfixable races, etc.

> Anyway, if things continue the way they are with intentional devfs- 
> breakage having moved from out-of-tree drivers to in-tree drivers,  
> you'll get your wish soon enough when backhanded devfs removal  
> makes the in-tree version useless.

This sentence doesn't parse, perhaps you'd like to clarify?  In any  
case, devfs is going away because it's sufficiently racy and broken  
and has been marked as DEPRECATED for a year.  udev _has_ been  
completely working for a while, even if not for the full year.


Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.  The first method is far more difficult.
   -- C.A.R. Hoare


