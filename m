Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbUKJKk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUKJKk1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 05:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbUKJKk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 05:40:27 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:30914 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261672AbUKJKkT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 05:40:19 -0500
Date: Wed, 10 Nov 2004 11:40:08 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Matt Mackall <mpm@selenic.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] change Kconfig entry for RAMFS
In-Reply-To: <20041109232402.GA8040@waste.org>
Message-ID: <Pine.LNX.4.60.0411101103560.3940@alpha.polcom.net>
References: <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org>
 <20041105014146.GA7397@pclin040.win.tue.nl> <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org>
 <20041105195045.GA16766@taniwha.stupidest.org> <Pine.LNX.4.58.0411051203470.2223@ppc970.osdl.org>
 <Pine.LNX.4.60.0411052242090.3255@alpha.polcom.net>
 <Pine.LNX.4.58.0411051406200.2223@ppc970.osdl.org>
 <Pine.LNX.4.60.0411052319160.3255@alpha.polcom.net>
 <Pine.LNX.4.58.0411051506590.2223@ppc970.osdl.org>
 <Pine.LNX.4.60.0411060027560.3255@alpha.polcom.net> <20041109232402.GA8040@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2004, Matt Mackall wrote:

> On Sat, Nov 06, 2004 at 12:44:14AM +0100, Grzegorz Kulewski wrote:
>>> So at the very least you'd need to make the Kconfig understand the
>>> dependency on ramfs.
>>
>> Should I add dependency to tmpfs on ramfs when building for embedded? Or
>> should I introduce new config option to stop registering ramfs as a
>> mountable filesystem?
>
> Root is ramfs at early boot time, making it optional is tricky.

You mean it is

rootfs / rootfs rw 0 0

in my /proc/mounts? Why this can not be tmpfs on normal dektop or server 
machines?

I have two goals in removing ramfs:
- stop user or distribution from mounting it somewhere to avoid strange 
oom panics when, by some unkown reason, something writes more data on it 
than RAM in the box,
- maybe construct / on tmpfs (from initramfs => "inittmpfs") in the 
future. Then ramfs will mount all needed filesystem (possibly from net or 
some sophisticated compressed / encrypted / raid volumes. But I will want 
/ on tmpfs to stay, just mount --bind /mnt/root/bin /bin and the same for 
other / directories. This way I can mount /proc, /sys, create /dev for 
udev and so on once, and I think this is simpler than mounting some real 
fs latter on / or using pivot_root. This way I can survive some serious fs 
problems on real disk / because I can umount it (maybe in single mode) and 
run some fs checker from my inittmpfs on it. I do not want to use ramfs 
for that because it can oom when some program or I will write big file to 
/.

I really do not understand why we need ramfs on not embedded boxes. If we 
can not remove its code then at least make in impossible to mount. But 
that is only my opinion.


Thanks,

Grzegorz Kulewski

