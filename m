Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbTJ0PRW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 10:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTJ0PRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 10:17:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41045 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263273AbTJ0PQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 10:16:14 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Egbert Eich <eich@xfree86.org>, Jon Smirl <jonsmirl@yahoo.com>,
       <kronos@kronoz.cjb.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-fbdev-devel@lists.sourceforge.net>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
References: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 27 Oct 2003 08:10:16 -0700
In-Reply-To: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org>
Message-ID: <m1isma67jb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 25 Oct 2003, Egbert Eich wrote:
> > 
> > Speaking of XFree86: when I developed the PCI resource stuff in 
> > XFree86 I was trying to get support from kernel folks to get the 
> > appropriate user space interfaces into the kernel. When I got 
> > nowhere I decided to do everything myself. 
> 
> There won't be any "user space interfaces". There are perfectly good 
> in-kernel interfaces, and anybody who needs them needs to be in kernel 
> space. Ie the kernel interfaces are for kernel modules, not for user space 
> accesses.

Well almost.    There is still one significant flaw in the kernel space stuff.

The BIOS can specify arbitrary regions as reserved in the E820 map and then
a kernel driver can't use that region itself.  This shows up in corner
cases where the resource on the PCI device is a boolean rather than
a general purpose thing.  Particularly for mtd map drivers to allow
flashing your ROM from linux this is a problem.

This is not required for 2.6.0 but it would be nice to actually be able
to reliably reserve resources in kernel drivers.

Eric
