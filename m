Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422918AbWBIR2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422918AbWBIR2E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWBIR2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:28:03 -0500
Received: from mail.timesys.com ([65.117.135.102]:748 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP id S932513AbWBIR2C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:28:02 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] kconfig: detect if -lintl is needed when linking conf,mconf
Date: Thu, 9 Feb 2006 12:24:12 -0500
Message-ID: <3D848382FB72E249812901444C6BDB1D03E051E7@exchange.timesys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] kconfig: detect if -lintl is needed when linking conf,mconf
Thread-Index: AcYtO9lkLM6/W9CvSYqU4wi4Xl+yYQAX6ucA
From: "Robb, Sam" <sam.robb@timesys.com>
To: "Kyle McMartin" <kyle@parisc-linux.org>
Cc: <akpm@osdl.org>, "Sam Ravnborg" <sam@ravnborg.org>,
       <zippel@linux-m68k.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kyle McMartin <kyle@parisc-linux.org> wrote:
> On Mon, Jan 30, 2006 at 01:26:47PM -0500, Robb, Sam wrote:
> >   This patch attempts to correct the problem by detecting whether or not
> > NLS support requires linking with libintl.
> >
> 
> Sigh. Can everyone please stop assuming gcc can output to /dev/null? On 
> several platforms, ld tries to lseek in the output file, and fails if it 
> can't.

Ouch.  Out of curiosity - what is the reason for this behavior in ld?
 
> Is there any reason this problem can't be solved the same way it is
> for libcurses in menuconfig, by using gcc -print-filename? Or perhaps
> using tempfile?

Using -print-file-name may cause problems if a system has libintl installed,
and the C library provides libintl support as well - you end up detecting
libintl, but linking to it isn't a good idea in that case.  Not to mention
figuring out which libintl to link to - static lib?  .so?  .dll (cygwin)?

Using a tempfile sounds like the right solution - you want to detect if
linking with -lintl is absolutely required, not just if the library exists.

Sam Ravenborg mentioned reimplementing this using check-lxdialog.sh.  I'll
wait and see what comes of that.

BTW - many thanks to all the folks who looked at this (admittedly trivial)
patch.  There's a level of professionalism and attention to detail in the
Linux community that's very refrehing.

-Samrobb
