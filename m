Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268007AbUHKJN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268007AbUHKJN4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 05:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268008AbUHKJN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 05:13:56 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:52627 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S268007AbUHKJNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 05:13:52 -0400
From: Benno <benjl@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Wed, 11 Aug 2004 19:13:49 +1000
Subject: Building on platforms other than Linux
Message-ID: <20040811091349.GX862@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was wondering if there were any, in priniciple, objections
to making the Linux kernel buildable on different Unix-like 
platforms?

I am currently compiling on MacOSX and this, for the most part was
fairly straightforward and simple. The biggest gotcha I had was
that libkconfig is compiled as a shared library, and unfortunately shared
libraries are done quite different on different systems. Specifically MacOSX
doesn't support gcc -shared.

libkconfig.so appears to be the only shared library created in the
build system, and given that it is only about 95K, and that you don't
often run two copies of conf at once, it doesn't seem to buy much.

The only other reason for doing it this way is to provide a plugin
style architecture but this doesn't appear evident. gconf and qconf
appear to manually load libkconfig.so (rather than linking against
it), but in both cases it appears to be the very first thing they
do is explicitly load libconfig.

It would seem that using static libraries would enhance portability,
and produce a simpler build system, however I expect I am missing some
other reasons.

In summary two questions:

1: Is portability of the build system a desirable property?

2: If so, is moving to static libraries a valid way of achieving this?

Thanks,

Benno
