Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267292AbTBDRgW>; Tue, 4 Feb 2003 12:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbTBDRgW>; Tue, 4 Feb 2003 12:36:22 -0500
Received: from h-64-105-35-85.SNVACAID.covad.net ([64.105.35.85]:12712 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267292AbTBDRgU>; Tue, 4 Feb 2003 12:36:20 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 4 Feb 2003 09:45:48 -0800
Message-Id: <200302041745.JAA16796@adam.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: [PATCH] Module alias and device table support.
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell responded to someone else (whom Rusty didn't name, and
whom I didn't immediately find in the archives):
>"insmod foo" will *always* get foo.  The only exception is when "foo"
>doesn't exist, in which case modprobe looks for another module which
>explicitly says it can serve in the place of foo.

	I think perhaps we should separate the name spaces so that the
kernel never modprobes for an actual module file name.  In other
words, there would only be three ways in which a module would
"automatically" be loaded:

	(1) it exports an alias like "fs-ext3", for the level helper that
	    request_module calls (devfs could also use these aliases),
	(2) it exports a device ID table for hotplug et al (probably
	    should not be the same name space as module "aliases" because
	    of device ID extensibility issues argued by David Brownell),
	(3) it exports a symbol needed by some other module.

	This would reduce the security attacks based on getting the
kernel to load arbitrary module names.

	It would also be straightfoward to add a flaag to depmod to
ask it to detect any modules that export no aliases, device ID tables
or symbols (perhaps they could have flag that says "yes, I really only
want to be loaded manually").

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
