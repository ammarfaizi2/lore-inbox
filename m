Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWBVQTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWBVQTJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWBVQTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:19:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49377 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750799AbWBVQTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:19:07 -0500
Subject: Re: 2.6.16-rc4: known regressions
From: David Zeuthen <david@fubar.dk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kay Sievers <kay.sievers@suse.de>, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Greg KH <gregkh@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0602220737170.30245@g5.osdl.org>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
	 <20060217231444.GM4422@stusta.de>
	 <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
	 <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost>
	 <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost>
	 <20060221225718.GA12480@vrfy.org>
	 <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI>
	 <20060222152743.GA22281@vrfy.org>
	 <Pine.LNX.4.64.0602220737170.30245@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 11:18:22 -0500
Message-Id: <1140625103.21517.18.camel@daxter.boston.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 07:44 -0800, Linus Torvalds wrote:
> 
> On Wed, 22 Feb 2006, Kay Sievers wrote:
> > 
> > Well, that's part of the contract by using an experimental version of HAL,
> > it has nothing to do with the kernel
> 
> NO NO NO!
> 
> Dammit, if this is the logic and mode of operation of HAL people, then we 
> must stop accepting patches to the kernel from HAL people.
> 
> THIS IS NOT DEBATABLE.
> 
> If you cannot maintain a stable kernel interface, then you damn well 
> should not send your patches in for inclusion in the standard kernel. Keep 
> your own "HAL-unstable" kernel and ask people to test it there.

Oh, you know, I don't think that's exactly how it works; HAL is pretty
much at the mercy of what changes goes into the kernel. And, trust me,
the changes we need to cope with from your so-called stable API are not
so nice. 

But I realize these changes are important because it's progress and back
in 2.6.0 things were horribly broken for at least desktop workloads [1].
It also makes me release note that newer HAL releases require newer
kernel and udev releases and that's alright. In fact it's perfectly
fine. We get users to upgrade to the latest and greatest and we keep
making good progress. That's open source at it's finest I think.

For just one example of API breaking see

 https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175998

This breaks stuff for end users in a stable distribution. Not good.

> It really is that easy. Once a system call or other kernel interface goes 
> into the standard kernel, it stays that way. It doesn't get switched 
> around to break user space.
> 
> Bugs happen, and sometimes we break user space by mistake. Sometimes it 
> really really is inevitable. But we NEVER EVER say what you say: "it's 
> your own fault". It's _our_ fault, and it's _our_ problem to work out.
> 
> Guys: you now have two choices: fix it by sending me a patch and an 
> explanation of what went wrong, or see the patch that broke things be 
> reverted. And STOP THIS DAMN APOLOGIA. 
> 
> I'm fed up with hearing how "breaking user space is ok because it's HAL or 
> hotplug". IT IS NOT OK. Get your damn act together, and stop blaming other 
> people. 

I think maintaining a stable syscall interface makes sense. Didn't you
once say that only the syscall interface was supposed to be stable? Or
was that Greg KH? I can't remember...

And I also think that breaking things like sysfs can be alright as long
as you coordinate it with major users of it, e.g. udev and HAL. Please
realize how useful the changes sysfs changes from 2.6.0 to present were
and... and that there still is a lot of work left to make certain things
work for desktop workloads.

I even think changing things like in the RH bug I linked to above is
fine provided that you mentioned it in the release notes...

One day perhaps sysfs will be "just right" and you can mark it as being
stable. I just don't think we're there yet. And I see no reason
whatsoever to paint things as black and white as you do.

    David (Please keep me Cc'ed, I can't keep up with lkml)

[1] : plug in a USB hub with other hubs attached and 10-20 USB devices;
works a lot better with current kernels and udev than it ever did in
2.6.0 with /sbin/hotplug (fork bomb)


