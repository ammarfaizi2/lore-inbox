Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265906AbUBJOqJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 09:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265908AbUBJOqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 09:46:09 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:5260 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S265906AbUBJOqC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 09:46:02 -0500
Date: Tue, 10 Feb 2004 06:46:30 -0800
From: Mike Bell <kernel@mikebell.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040210144629.GH4421@tinyvaio.nome.ca>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <4028DA93.9060107@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4028DA93.9060107@aitel.hist.no>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 02:20:19PM +0100, Helge Hafting wrote:
> No matter what virtues devfs may have - arguments are useless unless
> someone volunteers to maintain it.

I completely agree. But who would volunteer to spend their time fixing
devfs if no one said they wanted devfs, if all evidence says everyone is
happy with udev? I just wanted to get out that I'm not, I think devfs
(as a concept, not neccessarily the implementation in the kernel right
now) has merits udev does not and never will possess, and to see if anyone
else agrees.

> Interesting idea.

I didn't mean it as an idea, hence the bit about not advocating it. I'm
just trying to show that they're basically the same thing. The kernel is
exporting in file form three pieces of information, character/block,
major, and minor whether it's done as an actual device file or not.
Trying to show how both are doing the same thing.

> Devfs can do this, but it is not necessarily a good thing.
> I tried it - and it only works if someone tries to look up
> a particluar name, such as /dev/dsp.  It doesn't work when someone
> does a "ls /dev" to see what devices is there.
> A "ls /dev/dsp*" didn't find the multiple soundcards for which
> modules weren't yet loaded.

Nor would you want it to... Although, it might be handy for something
like a SCSI controller. An opendir() in its directory would trigger the
kernel to see what's attached to it. Postponing the probing of every LUN
until someone goes looking could speed up boot times quite a bit.

> I worried about this too, but notice which way the kernel is going.
> "Essential" stuff like parsing the disk partition tables (or getting
> a nfs root via dhcp) is being moved out of the kernel and into a
> early userspace in initramfs.  Such a thing _must not_ break, so it
> is the perfect place to put udev too.  It won't break from mere
> misconfiguration because the initramfs isn't on disk but stuffed into
> the kernel image where it is safe.  Someone who actually disrupts the kernel
> loose anyway.

That's a point, and one I had thought of. But on the other hand, the
kernel also seems to be moving toward exporting information to userspace
through simple RAM based filesystems. And while I don't know enough
about the internals of these things to say for sure, I wouldn't be
surprised if /dev as a special exported filesystem actually took less
RAM than /dev on tmpfs, since tmpfs has to be so much more generic
(supporting files that can be up to ssize_t long, the sendfile() method
so they can be mounted loopback, etc) while a devfs-alike would just be
storing small files: devices, symlinks, fifos, etc. Nothing with actual
data.

> It is fixable, but nobody wants to do it.  They have another solution 
> they like better.  Feel free to fix devfs though, then we'll get
> choice . . .

Well, as I said, no sense in fixing devfs if nobody wants it. udev's
author is giving that impression, but I don't feel that way myself and
wanted to see if anyone else agreed.
