Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbTKTPXa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 10:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbTKTPXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 10:23:30 -0500
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:33747 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP id S261930AbTKTPX3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 10:23:29 -0500
Date: Thu, 20 Nov 2003 16:23:26 +0100
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.x parport_serial link order bug (only works as a module)
Message-ID: <20031120152326.GA26003@amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've just looked at the 2.4.x changelog (up to 2.4.23-rc2) and still
don't see any fix for the parport_serial link order bug fix.  Without
it, the driver (which handles various PCI multi I/O serial+parallel
cards) only works as a module (broken when compiled into the kernel,
because parport_serial must be initialised after serial).

I've tried to submit the fix a few times since 2.4.19 or so, with
no success so far.  Is there any hope that it would go into 2.4.23?

The patch is here (can be updated to 2.4.23-rc if you are interested):

http://www.amelek.gda.pl/linux-patches/2.4.21/00_parport_serial

Quite big, but the largest part of it simply moves parport_serial.c
from drivers/parport/ to drivers/char/ without changing a single line
inside the file.  Really, no 2-line local root backdoors inserted ;-)

In the same directory, you can also find the NetMos patch, which should
be applied after the parport_serial link order bugfix patch.  Yes, I'm
still using a few NM9835 cards, no problems except having to patch each
kernel version forever.  This boring task would be easier for me if at
least the simple parport_serial link order fix would be accepted...

Thanks,
Marek

