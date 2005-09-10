Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVIJI2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVIJI2I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 04:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVIJI2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 04:28:07 -0400
Received: from cantor.suse.de ([195.135.220.2]:37791 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932272AbVIJI2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 04:28:06 -0400
To: Jim Gifford <maillist@jg555.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
References: <43228E4E.4050103@jg555.com>
From: Andi Kleen <ak@suse.de>
Date: 10 Sep 2005 10:28:04 +0200
In-Reply-To: <43228E4E.4050103@jg555.com>
Message-ID: <p73k6hp2up7.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Gifford <maillist@jg555.com> writes:

> I have been working on a project to create a Pure 64 bit distro of
> linux, nothing 32 bit in the system. I can accomplish that with no

Hopefully you're using /lib64 for that, otherwise your
packages will be incompatible to everybody else and not 
FHS compliant. If you don't please don't submit any 
patches to hardcode this to upstream packages.

> issues pretty much on all platforms, with the exception of the
> bootloaders. It just seems odd, that all the bootloaders seem to have
> gcc -m32 in their makefiles.

Not only the boot loaders, but the kernel needs a -m32
compilers/toolset to build the bzImage unpacker. There were some plans
to change that, but it hasn't happened so far.
> 
> Silo on the Sparc has gcc -m32
> Grub on the x86 platforms has gcc -m32
>  The only one that builds and works is Lilo, which most people are
> moving away from.
> 
> So for my question, why does a bootloader have to be 32bit?
> Anyone got 64 bit bootloaders for Sparc or x86_64 machines?

kexec is essentially a 64bit boot loader, but you need
linux running before so it has a little bootstrap problem.

I believe the folks at http://www.codegen.com got one too, but
it's proprietary.

The problem is that there is currently no defined protocol
for passing data to the 64bit part of the kernel, so while
it would be possible to write a boot loader that starts
a 64bit kernel it would be very kernel version dependent.

-Andi
