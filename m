Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266859AbSKHRlp>; Fri, 8 Nov 2002 12:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266860AbSKHRlp>; Fri, 8 Nov 2002 12:41:45 -0500
Received: from air-2.osdl.org ([65.172.181.6]:33408 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266859AbSKHRln>;
	Fri, 8 Nov 2002 12:41:43 -0500
Date: Fri, 8 Nov 2002 09:48:41 -0800
From: Dave Olien <dmo@osdl.org>
To: Kevin Brosius <cobra@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46 DAC960 :)
Message-ID: <20021108094841.A18641@acpi.pdx.osdl.net>
References: <3DC88907.70290D3C@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC88907.70290D3C@compuserve.com>; from cobra@compuserve.com on Tue, Nov 05, 2002 at 10:14:15PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've posted yet another new patch for the DAC960 driver for 2.5.46.
It's in

	http://www.osdl.org/archive/dmo/DAC960_2.5.46_V1/

This one uses the new pci_register_driver() interface.  I've restructured
the code to use the new device probe method.  This make the
new sysfs file system work.

This uncovered one bug in sysfs.  The DAC960 driver puts its
devices into a subdirectory "/dev/rd".  So the names constructed
in sysfs need to reflect this.  At the top level, it does OK, creating
names like "rd!c0d0".  The "!" in the name does cause some problems
for shells, so you need to put the name in single quotes to cd
into those directories.

But, the substitution of "!" for "/" isn't carried through to the lower
levels of the tree.  So, you end of with names containing the "/" character.
There's no way the kernel can ever parse such a name properly.
But I'm sure that'll be fixed soon.

Dave Olien

