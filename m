Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUH1Cyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUH1Cyd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 22:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUH1Cya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 22:54:30 -0400
Received: from [61.49.235.67] ([61.49.235.67]:18942 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S266386AbUH1Cy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 22:54:28 -0400
Date: Sat, 28 Aug 2004 10:50:05 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200408281750.i7SHo5C05936@freya.yggdrasil.com>
To: steve@steve-parker.org
Subject: Re: PWC issue
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>How does the Philips WebCam (pwc/pwcx) issue affect the speedtch 
>project? AIUI, that project requires additional proprietary microcode to 
>work.
>
>The ramifications are potentially huge...
>
>Steve
>steve@steve-parker.org
>sparkz@users.sourceforge.net
>(current maintainer of speedtouchconf.sf.net; hoping to resign soon as 
>the speedtouch.sf.net project gains more steam, or the speedtch module 
>becomes more popular - either way, reducing the importance of my 
>project, and allowing me to resign ;-)

	I am not a lawyer, so please do not use this as legal advice.

	You should keep the proprietary module in a file loaded by
a user space utility that should be invoked by hot plug, and not
just for the legal reason that loading a module with proprietary
firmware would have the user illegally create a GPL-infringing work
in memory (there are US court decisions that copying into RAM is
copying for the purposes of copyright infringement).  There are
also several technical reasons.

	The amount of unswappable kernel memory is reduced, at least
in the case of a kernel that supports USB hot plugging, since the
kernel will keep that blob around in case another Speedtouch USB
device is plugged in.  Even on system that have no swap, this still
means that a page or two more of disk files will be cached into
memory, and every once in a blue moon, the user will save 10
milliseconds by not having to reread that page from disk.

	The user can upgrade or modify the microcode without needing
to recompile and unload and reload the module.

	Unusual customizations are possible, such as having
two devices plugged in running different "microcode", for example
one unit running stable software on an actual internet connection
and the other running a version for, say, turning the unit into
an answering machine, or for debugging or for performance profiling.

	By the way, I have a long running dispute with Greg K-H
about his refusal so far to remove replace the GPL incompatible
firmware in certain USB serial drivers with such a user level
loading mechanism.  Go figure.

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
