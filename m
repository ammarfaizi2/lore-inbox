Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267002AbUAXUNZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 15:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267003AbUAXUMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 15:12:47 -0500
Received: from [213.4.129.129] ([213.4.129.129]:52421 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S267002AbUAXUMm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 15:12:42 -0500
Date: Sat, 24 Jan 2004 21:11:56 +0100
From: Diego Calleja <grundig@teleline.es>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Request: I/O request recording
Message-Id: <20040124211156.042a4ff2.grundig@teleline.es>
In-Reply-To: <20040124181026.GA22100@codeblau.de>
References: <20040124181026.GA22100@codeblau.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 24 Jan 2004 19:10:27 +0100 Felix von Leitner <felix-kernel@fefe.de> escribió:

> I would like to have a user space program that I could run while I cold
> start KDE.  The program would then record which I/O pages were read in
> which order.  The output of that program could then be used to pre-cache
> all those pages, but in an order that reduces disk head movement.
> Demand Loading unfortunately produces lots of random page I/O scattered
> all over the disk.
> 
> Having a way to know which pages are accessed in which order at a
> typical cold start would be very benefitial, not only for the purpose
> described above but it could also be used as input for a linker code
> reordering optimization.
> 
> What do you think?

That's exactly what XP does (and Mac OS X, for that matter).
And it really works (ie: you can notice it)

XP records what the OS does in the first 2 minutes (or so). The next
time it boots, it tries to load the files that he knows that are going
to be used. The same for an app that is frecuently used: it records
what the app does, and it optimizes the startup of that app. 
Take a look at: (search prefetch)
http://msdn.microsoft.com/library/default.asp?url=/library/en-us/appendix/hh/appendix/enhancements5_0qhx.asp
http://msdn.microsoft.com/msdnmag/issues/01/12/xpkernel/default.aspx

Andrew Morton wrote a patch some time ago for 2.5.64-mm6 which achieves a
similar effect, I think:

" To test the nonlinear mapping code more thoroughly I have arranged for all
  executable file-backed mmaps to be treated as nonlinear.

  This means that when an executable is first mapped in, the kernel will
  slurp the whole thing off disk in one hit. Some IO changes were made to
  speed this up.

  This means that large cache-cold executables start significantly faster.
  Launching X11+KDE+mozilla goes from 23 seconds to 16. Starting OpenOffice
  seems to be 2x to 3x faster, and starting Konqueror maybe 3x faster too.
  Interesting."
(see: http://www.ussg.iu.edu/hypermail/linux/kernel/0303.1/1296.html)

The patches are still available. IIRC, they were dropped "because it should be
done in userspace". It'd very interesting to write userspace program
that does what XP does (it looks like a good idea for desktops)





http://www.ussg.iu.edu/hypermail/linux/kernel/0303.1/1296.html



