Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264466AbTDPRJb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 13:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264467AbTDPRJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 13:09:31 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:22790 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264466AbTDPRJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 13:09:28 -0400
Date: Wed, 16 Apr 2003 13:20:56 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Stephen Cameron <steve.cameron@hp.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to identify contents of /lib/modules/*
In-Reply-To: <20030416020059.GA27314@zuul.cca.cpqcorp.net>
Message-ID: <Pine.LNX.4.10.10304161231360.642-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Apr 2003, Stephen Cameron wrote:

> A certain major linux distribution distributes a number of binary 
> kernels, errata kernels, which all report the exact same thing 
> via "uname -r".  These kernels may differ by only a little
> (only the .config file is different in some small way) or by 
> a lot (binary drivers for one don't work (panic) on another).

We've run into the same problems here, with this *unnamed* major Linux distro ;) We distribute pre-compiled versions of open source 
drivers that contain additional features or bug fixes that aren't in the standard/included drivers...

 
> The task for the binary driver distributor becomes to figure out which
> of these multiple errata kernels found in /boot corresponds to the 
> /lib/modules directory, so we can drop the binary driver that was
> made for that errata kernel in there, and not a driver made for the
> wrong kernel.

I think you just have to assume that the running kernel is the one that gets its module upgraded (or installed). And that the /lib/modules directory that is in the standard location for that kernel (i.e., it hasn't been moved somewhere else in preparation for installing another kernel) is the one corresponding to the running kernel. This is what we do in our installation process... no one has complained about this behavior as far as I know. I don't know that there's any other sane way to handle this... :/

The truth is, the kernel rpms for this distro are not designed to be installed side by side, they really ought to be upgraded (meaning the old stuff gets removed, so there's no ambiguity). Do you actually have customers that are installing multiple kernels and moving /lib/modules dirs around? (I know we do this in our labs, and you may too, but I can't imagine too many customers doing this...)

 
> This seems like a lot of contortions to go through and I'm wondering
> if there's a simpler way to identify the contents of /lib/modules, 
> aside from the 'uname -r' type string, and I just missed it.

Have you tried "cat /proc/version" ? It's got the build date of the kernel in it...

 
> Also note, I can't just figure out which is the _running_ kernel
> (by checksumming /boot/vmlinuz, cross-checked against /etc/lilo.conf
> or grub conf file, because in certain situations the running kernel
> is only there to install another kernel.  And we want to provide
> the option to install the driver for all the kernels on the system
> that we can (reliably) find.)

Hmm... I'm not sure how feasible that's going to be... Maybe you could just ask customers to run the setup script (or whatever you install with) once they're booted on the kernel that they intend to run the system on? Either that or maybe they just have to tell the setup which kernels they want modules installed for (maybe you give them a proposed list, based upon checking the system)?

Is there any chance that SuSE (oops, let the cat out of the bag ;) would accept your driver(s) into their distribution, or
is this proprietary HP stuff? They've been very helpful in accepting various patches from us...


Anyway, I don't know if any of that helped... this really is a nasty situation to have to deal with... I'm not sure there's any perfect solution... you're probably just going to have to make some assumptions and intelligent guesses and hope for the best!

Good luck...

--
Paul

