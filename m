Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133107AbRDRNLq>; Wed, 18 Apr 2001 09:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135170AbRDRNL0>; Wed, 18 Apr 2001 09:11:26 -0400
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:48399 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S133119AbRDRNLY>; Wed, 18 Apr 2001 09:11:24 -0400
Date: Wed, 18 Apr 2001 14:11:20 +0100 (BST)
From: Chris Evans <chris@scary.beasts.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: David Schleef <ds@schleef.org>, Dawson Engler <engler@csl.Stanford.EDU>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] copy_*_user length bugs?
In-Reply-To: <20010418140059.A442@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.30.0104181405200.21092-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Apr 2001, Russell King wrote:

> > Now, providing the malicious user passes a low user space pointer (e.g.
> > just above 0), the kernel's virtual address space wrap check will not
> > trigger because ~0 + ~2Gb does not exceed 4G. And the result is the user
> > being able to read kernel memory.
>
> But ~0 + ~2GB = ~2GB.  Last time I checked, ~2GB is less than 3GB, and 3GB
> is the start of kernel memory on x86.  Therefore, I don't see that the
> user will be able to read kernel memory.

The problem is that (up to) a 2Gb copy is attempted into userspace. The
source is a kernel object which is not 2Gb large! So, we read off the end
of some kernel object, and there is often something very interesting after
it ;-)

For a good real-world example, please see my Bugtraq post regarding
sysctl():

http://www.securityfocus.com/archive/1/161764

Cheers
Chris

