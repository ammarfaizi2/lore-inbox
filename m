Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVCUNPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVCUNPe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 08:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVCUNPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 08:15:34 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:61877 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261784AbVCUNPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 08:15:08 -0500
Message-ID: <423E94FF.9000603@suse.de>
Date: Mon, 21 Mar 2005 10:33:51 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@cyclades.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mgarrett@chiark.greenend.org.uk
Subject: Re: Suspend-to-disk woes
References: <423B01A3.8090501@gmail.com>	 <20050319132612.GA1504@openzaurus.ucw.cz>	 <200503191220.35207.rmiller@duskglow.com>	 <20050319212922.GA1835@elf.ucw.cz> <20050319212922.GA1835@elf.ucw.cz>	 <1111364066.9720.2.camel@desktop.cunningham.myip.net.au>	 <E1DDAcH-0002n5-00@chiark.greenend.org.uk> <1111384766.9720.144.camel@desktop.cunningham.myip.net.au>
In-Reply-To: <1111384766.9720.144.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Nigel Cunningham wrote:

> On Mon, 2005-03-21 at 11:17, Matthew Garrett wrote:

>> It's trivial to do this in userspace - just have an app in initramfs

> It's not that trivial.

> - Your image might not be stored in a swap partition. For Suspend2, it
> can potentially in a swap file or (soon) an ordinary file;
> - Finding which partition to look in for the signature might be non
> trivial (labels in fstab). You'd want to hard code it or (perferably)
> copy a config file from the root (or other) partition;
> - Having addressed the above issues, you still need to add code to read
> the swap header, parse it to find the header, read the header from the
> image, parse it and obtain the kernel version of the saved image.

Well, and you want to compile all this into the kernel? Just to hold the
hands of users who have not read the fine manual?
And you'd need to compile this into all kernels, especially those that
_don't_ support suspend to disk. Or you are back at the place where the
thread started.

> If your image is not stored in a swap partition, you probably can't
> mount the fs the image is stored on, because doing so will replay the
> image and make resuming unsafe, so this approach is less trivial without
> knowing exactly which disk blocks and device IDs to use (and using dd to
> access them).

GRUB reads kernel and initramfs from a dirty reiserfs partition on
resume (although this is a bad idea if you want a fast resume, but
that's another problem). It is possible.

> On top of these, we have two implementations, so you'll want to check
> for the signatures of both.

This is the final argument for doing it in userspace :-).

> That said, I am considering making something like what you're saying:
> exposing methods of testing whether an image exists and an entry through
> which you can get Suspend to erase an image via a proc (eventually
> sysfs) entry. This will allow something like what you're saying to be
> controlled from userspace.

It does not help if the next kernel i boot is not suspend2 patched. This
work should rather go into a library that exports this functions to
userspace programs, for all known suspend implementations.

Regards,

   Stefan

