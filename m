Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVCMVjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVCMVjS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 16:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVCMViw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 16:38:52 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:26068 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261466AbVCMVih convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 16:38:37 -0500
Date: Sun, 13 Mar 2005 13:37:02 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: pluto@pld-linux.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [2.6.11.3] gcc4 / psmouse.h - compilation fix.
Message-Id: <20050313133702.081001e9.pj@engr.sgi.com>
In-Reply-To: <200503131230.03938.dtor_core@ameritech.net>
References: <200503131420.12554.pluto@pld-linux.org>
	<200503131148.46417.dtor_core@ameritech.net>
	<200503131754.31244.pluto@pld-linux.org>
	<200503131230.03938.dtor_core@ameritech.net>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry, responding to Pawe__:
> > IMHO each header (e.g. psmouse.h) should include headers for types it uses.
> > 
> 
> Hmm, I thought it was other way around 

I tend to agree with Pawe__ here.

There are two extremes here that I would avoid.  Do not try to include
in source files every header that is directly or indirectly needed, nor
try to minimize inclusions in header files by relying on every possible
prerequisite inclusion by the includers of that header.

Rather - think about the interface presented and used.

A source file should include headers for everything that it manifestly
makes use of (even if that means it happened to include something that
was also indirectly included elsewhere).  And no more.

A header file should provide all the inclusions that its users
(includers) will need to make use of what is in that header file,
without presuming that any user will already have included something
else.  And no less.

In this case, it seems that the header drivers/input/mouse/psmouse.h
requires the size of a struct ps2dev.  So I would think that psmouse.h
should include linux/libps2.h, as this patch provides for.  The users
of psmouse.h should not have to know of this dependency.

Respect the interfaces.  They are one of the means whereby we partial
out responsibility for keeping code sane, in the face of rapid,
conflicting changes from many developers across many architectures and
drivers, where no one individual can test all possible configurations.

A user of psmouse.h should not be required to include the libps2.h
header, because someday a user of psmouse.h that didn't do this, but was
working anyway because it happened to get libps2.h from some other
indirect inclusion, will get broken when someone working in a quite
different area happens to deprive our hapless psmouse.h user of its
libps2.h.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
