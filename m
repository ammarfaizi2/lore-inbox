Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318370AbSGYIZK>; Thu, 25 Jul 2002 04:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318371AbSGYIZK>; Thu, 25 Jul 2002 04:25:10 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:53452 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S318370AbSGYIZJ>; Thu, 25 Jul 2002 04:25:09 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Russell King <rmk@arm.linux.org.uk>
Subject: kernel ABI [was something about Compile Bogons...]
Date: Thu, 25 Jul 2002 18:23:55 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
References: <20020724082557Z318273-685+17059@vger.kernel.org> <200207251432.52687.bhards@bigpond.net.au> <20020725085702.C7336@flint.arm.linux.org.uk>
In-Reply-To: <20020725085702.C7336@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207251823.55466.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2002 17:57, Russell King wrote:
> On Thu, Jul 25, 2002 at 02:32:52PM +1000, Brad Hards wrote:
> > Some applications talk to the kernel (eg via ioctl()). This is related to
> > the kernel version that is running (not anything to do with the libs).
>
> And ioctl() is an evil interface, and anything which changes in an
> already defined ioctl is an ABI change, which aren't allowed in stable
> kernel series.
ioctl() is a damn evil interface that we are stuck with.
Changing an already defined ioctl isn't a sufficient condition.
If you have a program that is testing for a certain kernel
capability (ioctl, socket, whatever), and it is present in the
headers, then it needs to be present in the kernel that the
program will run under. So you can't add anything to the
ABI (as described by the headers) in a stable series either.

> > 3. Things that are related to the kernel that is running.
> > This is probably /usr/include/linux
>
> No.  Search the lkml archives.  You'll find several people, including
> Linus telling people otherwise.
I didn't express it well. My point is that the include files should be
refactored to provide only the kernel ABI in /usr/include/linux.
If it isn't part of the kernel ABI, then it isn't strictly part of Linux,
and the naming should support that.

Then /usr/include/linux (or linux-abi, whatever) really _should_ be
a symlink to the currently running kernel headers describing the
ABI.

But certainly not the way it is now, where symlinking /usr/include/linux
to /usr/src/kernels/linux-2.x.y.z-rcA/include is the path to madness.


-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
