Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbUDAQNb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 11:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbUDAQNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 11:13:31 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:61620 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262948AbUDAQN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 11:13:29 -0500
Subject: Re: finding out the value of HZ from userspace
From: Albert Cahalan <albert@users.sf.net>
To: Jamie Lokier <jamie@shareable.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Peter Williams <peterw@aurema.com>,
       arjanv@redhat.com, ak@muc.de, Richard.Curnow@superh.com, aeb@cwi.nl,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040401155420.GB25502@mail.shareable.org>
References: <1079453698.2255.661.camel@cube>
	 <20040320095627.GC2803@devserv.devel.redhat.com>
	 <1079794457.2255.745.camel@cube> <405CDA9C.6090109@aurema.com>
	 <20040331134009.76ca3b6d.rddunlap@osdl.org>
	 <1080776817.2233.2326.camel@cube>
	 <20040401155420.GB25502@mail.shareable.org>
Content-Type: text/plain
Organization: 
Message-Id: <1080835938.1587.14.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 Apr 2004 11:12:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-01 at 10:54, Jamie Lokier wrote:
> Albert Cahalan wrote:
> > If you rely on sysconf(_SC_CLK_TCK) to work, then
> > your software will support:
> > 
> > * all systems with a 2.6.xx kernel
> > * all systems with a 2.4.xx kernel and recent glibc
> > * all i386 systems running with the default HZ
> > 
> > That's quite a bit I suppose. Maybe you have no
> > interest in supporting a 1200 HZ Alpha with an old
> > kernel or glibc. Maybe you don't care about somebody
> > running a 2.2.xx kernel with modified HZ.
> 
> I'm still unclear.  Does sysconf(_SC_CLK_TCK), when it is reliable,
> return HZ or USER_HZ?

I consider "reliable" to mean it returns whatever is
used by /proc and other kernel interfaces. Prior to the
2.6.xx (and late 2.5.xx) kernels USER_HZ did not exist.

On a 2.6.xx kernel, you get back USER_HZ.

On a 2.4.xx kernel with recent glibc, you get
back HZ, which works OK since there isn't any
HZ to USER_HZ conversion.

On any i386 system with the default HZ, you
will get back 100. On older systems, glibc is
just giving you a constant value -- so it is
correct if your system is an i386 without any
non-Linus modifications. An old glibc can only
do sysconf(_SC_CLK_TCK) this way.


