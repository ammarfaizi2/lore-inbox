Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTLJDvm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 22:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTLJDvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 22:51:42 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:46091 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S262790AbTLJDvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 22:51:40 -0500
Message-ID: <3FD69CB3.8080308@nishanet.com>
Date: Tue, 09 Dec 2003 23:10:27 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: State of devfs in 2.6?
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <pan.2003.12.08.23.04.07.111640@dungeon.inka.de> <20031208233428.GA31370@kroah.com> <1070953338.7668.6.camel@simulacron> <20031209083228.GC1698@kroah.com> <3FD681D0.1090600@tequila.co.jp>
In-Reply-To: <3FD681D0.1090600@tequila.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Skip to Bottom line: Does devfs do devpts on 2.6? Didn't for me.

Clemens Schwaighofer wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Greg KH wrote:
>
> |
> | I don't think that all 4 users of devfs on 2.6 are all that vocal :)
> | Either way, I haven't been paying attention, as I really don't care.
>
> well ... I think there are more devfs users out there. eg, all the
> Gentoo freaks (me included) are sort of forced into devfs. If they want
> or not. And they will stick to it, until sysfs/udev/hotplug/foobarfs is
> so solid it can replace devfs. 

I'm using devfs on 2.6.0-test11. I have never run into the
impossible to fix problems. I run devfs with very little
old compatible naming. I edited /etc/devfs/compat_symlinks
to give me /dev/sd* /dev/hd* and weirdly ln -s /dev/dsp2 /dev/dsp
since all sound apps only seem to look for /dev/dsp which is only
a dummy with nforce2.

In 2.6 devfs would not do devpts for X so I put devpts back in the
kernel and instantly got on with my work. I'm not sure if that means
devfs can't do devpts in 2.6. I don't care.

I see no devfs devices for a 32-bit cardbus pcmcia controller pci card
which is id'd by yenta and cardmgr(pcmcia-cs v3.2.5), so I am switching
to sysfs udev hotplug to see if that helps. Actually I can mount sysfs
to /sys now and look around first but proc and var agree there is nada
but there are two cards in slots.

In the cdrecord thread Linus said some things about target/bus/lun
naming and I must admit that it is nice to get back where ls /dev
shows what drives there are without having to tree out into
/dev/scsi/host/bus/target/lun/* to see how drives are recognized.
That can be improved in most configurations by using compat
symlinks instructions for /dev/sd* in /etc/devfs/compat_symlinks
but as Linus explained iscsi handled better by sysfs udev /dev/s??
and not 0,0,0 targbuslun cdrecord-style.

I like devfs and haven't ever had an error burning cd's with ide-scsi
but I'm switching to udev and ide-cd to suck up to Linus before
I start plaguing him about my pcmcia controller and yenta not
working together--udev might work better with hotplug than
devfs so I should try that first.

It seems dubious that Gooch isn't maintaining devfs and syfs
could be moving away from compatibility with devfs, and
there are proven impossibilities about the devfs way. Devfs
is a lot less broken than windows, though. Devfs might
be good enough to Walmart-Microsoft pretty good alright
rip the guts out of userland, but that's not good enough for the
os that runs the internet.

-Bob
