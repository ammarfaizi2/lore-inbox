Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUCTOtk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 09:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263430AbUCTOtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 09:49:40 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:15560 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263429AbUCTOtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 09:49:36 -0500
Subject: Re: finding out the value of HZ from userspace
From: Albert Cahalan <albert@users.sf.net>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       peterw@aurema.com, aeb@cwi.nl, ak@muc.de, Richard.Curnow@superh.com
In-Reply-To: <20040320095627.GC2803@devserv.devel.redhat.com>
References: <1079453698.2255.661.camel@cube>
	 <20040320095627.GC2803@devserv.devel.redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1079794457.2255.745.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Mar 2004 09:54:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-20 at 04:56, Arjan van de Ven wrote:
> On Tue, Mar 16, 2004 at 11:14:59AM -0500, Albert Cahalan wrote:
> > > there is one. Nothing uses it
> > > (sysconf() provides this info)
> > 
> > If you have a recent glibc on a recent kernel, it might.
> > You could also get a -1 or a supposed ABI value that
> > has nothing to do with the kernel currently running.
> > The most reliable way is to first look around on the
> > stack in search of ELF notes, and then fall back to
> > some horribly gross hacks as needed.
> 
> eh sysconf() is the nice way to get to the ELF notes
> instead of having to grovel yourself.

Unless there is some hidden feature that lets
me specify the ELF note number directly, no way.

The sysconf(_SC_CLK_TCK) call does not return an
error code when used on a 2.2.xx i386 kernel.
You get an arbitrary value that fails for ARM,
Alpha, and any system with modified HZ.

You can't rely on sysconf(_SC_NPROCESSORS_CONF)
or sysconf(_SC_NPROCESSORS_ONLN) either. You'll
get back a 0 from the SPARC glibc, which really
means 0 processors since -1 is the error code.

Whatever the question, "use sysconf" is most
likely not the answer.

The man page ought to mention this.


