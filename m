Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUBKBKj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 20:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUBKBKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 20:10:39 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:39565 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S261967AbUBKBK1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 20:10:27 -0500
Date: Tue, 10 Feb 2004 17:10:56 -0800
From: Mike Bell <kernel@mikebell.org>
To: Matthew Reppert <repp0017@tc.umn.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040211011055.GA4867@tinyvaio.nome.ca>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <20040210172552.GB27779@kroah.com> <20040210174603.GL4421@tinyvaio.nome.ca> <20040210181242.GH28111@kroah.com> <20040210182943.GO4421@tinyvaio.nome.ca> <1076451567.21725.21.camel@minerva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076451567.21725.21.camel@minerva>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 04:19:28PM -0600, Matthew Reppert wrote:
> At the very least, sysfs' and devfs' approaches to devices differ in
> philosophy. devfs says "here's a device node, you can tell where it is
> in the bus hierarchy by looking at its filename". sysfs, on the other
> hand, says "here's the device hierarchy", and gives you enough information
> to create device nodes for each point in the hierarchy if you wish to do
> so.

I don't see how that is the case. devfs doesn't do anywhere near as good
a job exporting info about the system's state as sysfs, wouldn't dream
of disputing that. But to me, /dev/scsi/host0/bus0/target0/lun0/disc and
/sys/bus/scsi/drivers/sd/0:0:0:0/block/dev are the same philosophy.

> This is kind of like saying "bzImage sets root partition location policy
> because it uses whatever was the root partition when you made the image".
> Which is bogus, that's what root= is for.

No, that's not what I mean at all.

> sysfs is in no way setting naming policy by exporting the LSB naming scheme.
> First of all, sysfs isn't even creating the device nodes - that, of course,
> is udev's (or whatever else you might want to use) job. You're right,
> actually - if you're using udev, files the sysfs static names *don't* exist -
> *unless* your udev is configured to use them. If not, then obviously the
> sysfs names don't matter at all.

No no, I'm not saying sysfs is setting /dev's naming policy. I'm saying
that no one is ranting and raving about how userspace should be able to
change the names of sysfs files using a userspace daemon. devfs
specifies a path in the kernel, 

> This is like arguing that a file named foo with an accompanying file named
> foo.acl is "very nearly" a file with an ACL. Or, more dramatically, like
> equating a nuclear warhead with instructions on making U-238. The information
> is there in sysfs, granted, but it's not in a directly usable form by itself.

So how is that better? :) Not that I'm suggesting sysfs should have
device files in it, but why is it a winning point for sysfs to be able
to say "hey, look, I don't export a device file, but a file which
carries exactly the same information but with less utility, since you
have to use that information to create ANOTHER file".

My point was that both filesystems are exporting that information to
userspace, at least devfs does it in a way where the product is useful
with or without a userspace daemon.

> The difference between sysfs and devfs, in this regard, is fairly simple. By
> just turning on devfs support, you've suddenly changed the behaviour of the
> system (device node creation and naming) once /dev is mounted. By turning on
> sysfs, the behaviour of the system doesn't change at all, even when /sys is
> mounted.

But I wasn't arguing they weren't different, I was arguing that they
both have naming policy in the kernel. As long as the user can specify
their own names as well, why is it "naming policy in the kernel" to
specify a hardcoded path in /dev, but not if you specify a hardcoded
path in /sys?

> Why should the kernel create the device nodes? Sure, it's "just an extra
> step", but the general Linux philosophy is that "just extra steps" don't
> belong inside the kernel. Why should the kernel do more work?

Not even an extra step, more a different step. Not "more" work, the same
work in a different way. And it should because then you have a working
/dev with guaranteed names.
