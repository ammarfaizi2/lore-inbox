Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbUCaXmz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 18:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbUCaXmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 18:42:54 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:13218 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262108AbUCaXmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 18:42:15 -0500
Subject: Re: finding out the value of HZ from userspace
From: Albert Cahalan <albert@users.sf.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Peter Williams <peterw@aurema.com>, albert@users.sourceforge.net,
       arjanv@redhat.com, ak@muc.de, Richard.Curnow@superh.com, aeb@cwi.nl,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040331134009.76ca3b6d.rddunlap@osdl.org>
References: <1079453698.2255.661.camel@cube>
	 <20040320095627.GC2803@devserv.devel.redhat.com>
	 <1079794457.2255.745.camel@cube> <405CDA9C.6090109@aurema.com>
	 <20040331134009.76ca3b6d.rddunlap@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1080776817.2233.2326.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 31 Mar 2004 18:46:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> | >>>>there is one. Nothing uses it
> | >>>>(sysconf() provides this info)
> | >>>
> | >>>If you have a recent glibc on a recent kernel, it might.
> | >>>You could also get a -1 or a supposed ABI value that
> | >>>has nothing to do with the kernel currently running.
> | >>>The most reliable way is to first look around on the
> | >>>stack in search of ELF notes, and then fall back to
> | >>>some horribly gross hacks as needed.
> | >>
> | >>eh sysconf() is the nice way to get to the ELF notes
> | >>instead of having to grovel yourself.
> | > 
> | > 
> | > Unless there is some hidden feature that lets
> | > me specify the ELF note number directly, no way.
> | > 
> | > The sysconf(_SC_CLK_TCK) call does not return an
> | > error code when used on a 2.2.xx i386 kernel.
> | > You get an arbitrary value that fails for ARM,
> | > Alpha, and any system with modified HZ.
> | 
> | As Linux is supposed to be POSIX compliant this is a bug and should be 
> | fixed.
> 
> 
> My understanding (from a few years back) is that Linux is POSIX
> if/when/where it makes sense, but not necessarily POSIX-just-to-be-POSIX.

The fixing has been done.

This is not yet helpful for app developers, because
old kernels and old libraries are still in use.

If you rely on sysconf(_SC_CLK_TCK) to work, then
your software will support:

* all systems with a 2.6.xx kernel
* all systems with a 2.4.xx kernel and recent glibc
* all i386 systems running with the default HZ

That's quite a bit I suppose. Maybe you have no
interest in supporting a 1200 HZ Alpha with an old
kernel or glibc. Maybe you don't care about somebody
running a 2.2.xx kernel with modified HZ.

For the moment, I still care. I won't for long.


