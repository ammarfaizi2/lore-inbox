Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRDJRFS>; Tue, 10 Apr 2001 13:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRDJRFH>; Tue, 10 Apr 2001 13:05:07 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:10249 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129051AbRDJREv>;
	Tue, 10 Apr 2001 13:04:51 -0400
Date: Tue, 10 Apr 2001 19:04:44 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: richard offer <offer@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: build -->/usr/src/linux
Message-ID: <20010410190444.A21024@pcep-jamie.cern.ch>
In-Reply-To: <20010408161620.A21660@flint.arm.linux.org.uk> <3AD0A029.C17C3EFC@rcn.com> <9aqmgo$8f6ol$1@fido.engr.sgi.com> <10104091601.ZM401478@sgi.com> <20010410160825.A20555@pcep-jamie.cern.ch> <lk@tantalophile.demon.co.uk> <1010410093615.ZM1231@sgi.com> <20010410184237.A20969@pcep-jamie.cern.ch> <lk@tantalophile.demon.co.uk> <1010410095237.ZM1290@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1010410095237.ZM1290@sgi.com>; from offer@sgi.com on Tue, Apr 10, 2001 at 09:52:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

richard offer wrote:
> What if your application contains some user code and a kernel module ?
> Want an obvious example ? X.

VMware is another.  In such cases, they have to do the same as any other
system-specific packages: guess, or ask the user.  Autoconf apps prefer
guessing; X uses Imake and would probably have the kernel source path
hard-coded in an Imake template :-)

The discussions here have suggested ways for a third-party module
package to guess how to install themselves, so that they will just work
on most systems.  /lib/modules/`uname -r`/build is the best anyone's
come up with so far, and it does just work on "plain old" 2.4 systems.
/usr/src/linux-`uname -r` is the next best.

This fails in certain cases such as cross-compiling, when the kernel
isn't living in /usr/src or its not configured, and when it's not the
running kernel.

But then, this is true of userspace too.  Build an app on a Red Hat
system, don't be surprised to find it fails to run on a Debian.

When cross-compiling a userspace app, you have to explicitly tell the
package how to build, libraries to use etc. whether by command line
flags or editing the source.  That's the joy of
cross-compiling.  /usr/lib doesn't contain the right libraries, but it's
ok for apps to look there _unless_ you say otherwise.

Same goes for kernel modules.  /lib/modules/`uname -r`/build doesn't
contain the right files when cross-compiling, but it's ok for module
packages to look there _unless_ you say otherwise.

-- Jamie
