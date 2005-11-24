Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030591AbVKXERi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030591AbVKXERi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 23:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030593AbVKXERh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 23:17:37 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:24986
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030591AbVKXERh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 23:17:37 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Christmas list for the kernel
Date: Wed, 23 Nov 2005 22:17:24 -0600
User-Agent: KMail/1.8
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <4383979F.6070608@tmr.com>
In-Reply-To: <4383979F.6070608@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511232217.25198.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 November 2005 16:11, Bill Davidsen wrote:
> Serious question, when/if xen is in the kernel, is there a reason for
> UML? If so, why would I use UML instead of xen, and where?

Xen requires support in the host kernel.  UML (skas0 mode) does not.

I have a build system that uses UML as a better fakeroot.  I can't use qemu 
for this because I want to boot borrowing the hosts's filesystem (so the 
build doesn't need a huge binary blob of precompiled stuff to start 
doing ./configure;make;make install with...  At that point I might as well 
just distribute the final binaries and be done with it).

I don't want the thing to require root access, yet the build needs to drop a 
symlink into /, wants to mknod, chown, chroot, and perform --bind and --move 
mounts.

Fakeroot wouldn't be sufficient because there's no guarantee the host system 
is running a 2.6 kernel (no --bind or --move mounts) and worse, I'm building 
uClibc against the most recent Mazur headers I can find which means the 
resulting uClibc may not run on an older kernel (even running against a 
sufficiently old 2.6 kernel means segfaults due to missing features the new 
headers describe).

I find UML a very convenient way to get a virtual environment borrowing 
resources from the host without having to set up the host.  This means I can 
deploy it to relatively unknown systems, without requiring somebody with root 
access on those systems to replace the kernel and reboot, which generally 
isn't an option.

Rob
