Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTFOPd2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 11:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTFOPd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 11:33:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37642 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262312AbTFOPd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 11:33:27 -0400
Date: Sun, 15 Jun 2003 16:47:16 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-pcmcia@infradead.org,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: PCMCIA PATCHES: rsrc_mgr.c
Message-ID: <20030615164716.C5417@flint.arm.linux.org.uk>
Mail-Followup-To: linux-pcmcia@infradead.org,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have three patches which I'm intending pushing to Linus tonight.  They
are:

http://patches.arm.linux.org.uk/pcmcia/pcmcia-20030615-1.diff

  Remove the racy check_mem_resource() function.  Instead, claim
  the region while we check it, passing a resource structure to
  the core validation functions.

http://patches.arm.linux.org.uk/pcmcia/pcmcia-20030615-2.diff

  We must always allocate windows below 1MB when a socket driver indicates
  that it does not have "page registers".  Handle this case in rsrc_mgr.c
  within find_mem_region rather than each use of find_mem_region().

http://patches.arm.linux.org.uk/pcmcia/pcmcia-20030615-3.diff

  Turn the resource management on its head.  Rather than using PCMCIA's
  resource database as the primary object to allocate resources, use
  Linux's standard resource allocation instead.

  When we have a socket on a PCI bus, we always use the PCI resource
  allocation functions rather than the kernels core resource allocation,
  so that we can take account of any bridges.

The first two should be mostly harmless.  The third patch needs greater
testing.  Unfortunately, the PCI groundwork for this patch was recently
reversed, so I just can't be bothered to separate out that change again
from the other PCI changes I have.  You basically need to make the
function non-static, add a declaration to include/linux/pci.h and
re-export it.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

