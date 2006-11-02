Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWKBVzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWKBVzt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbWKBVzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:55:49 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47799 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750991AbWKBVzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:55:48 -0500
Subject: Re: 2.6.19-rc4: known unfixed regressions
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Auke Kok <auke-jan.h.kok@intel.com>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>,
       Adrian Bunk <bunk@stusta.de>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Rajesh Shah <rajesh.shah@intel.com>, toralf.foerster@gmx.de,
       Jeff Garzik <jeff@garzik.org>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20061102121027.676db964.akpm@osdl.org>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
	 <20061031195654.GV27968@stusta.de> <200611022102.02302.rjw@sisk.pl>
	 <20061102121027.676db964.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Nov 2006 21:55:36 +0000
Message-Id: <1162504537.11965.238.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-11-02 am 12:10 -0800, ysgrifennodd Andrew Morton:
> Balls are being dropped.
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=7082
> 
> So this was a good patch but because of a bug in ne2k-pci which nobody is
> fixing we need to drop it?

I believe the patch is fundamentally wrong. We don't *need* to drop the
IO decode in this case. We don't want to drop it when the BIOS lacks the
brains to put it back. We will also kill some machines doing it as they
have devices we attach drivers to which are not just managing the
function Linux knows about but also many other things. Take the CS5520
for example, generically disable the I/O on that because we have an IDE
driver attached to it and you kill the box stone dead, as its also the
video and a few other things behind the scenes. That is not atypical.

IFF someone has a device that actually needs to disable I/O cycles, well
they can do it themselves.

Alan

