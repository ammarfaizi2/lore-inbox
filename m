Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276860AbRJCEg0>; Wed, 3 Oct 2001 00:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276861AbRJCEgH>; Wed, 3 Oct 2001 00:36:07 -0400
Received: from rj.SGI.COM ([204.94.215.100]:56235 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S276860AbRJCEgD>;
	Wed, 3 Oct 2001 00:36:03 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Modutils 2.5 change, start running this command now
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Oct 2001 14:36:24 +1000
Message-ID: <31135.1002083784@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In current modutils, a module that does not export symbols and does not
say EXPORT_NO_SYMBOLS defaults to exporting all symbols.  This is a
hangover from kernel 2.0 and will be removed when modutils 2.5 appears,
shortly after the kernel 2.5 branch is created.

Starting with modutils 2.5, modules must explicitly say what their
intention is for symbols.  That will break a lot of existing modules.
The command below lists the modules on your system that will be
affected.  All code maintainers need to run this against their 2.4
modules and do one of two things.  Either export the required symbols
(remember to add the .o file to export-objs in the Makefile) or add
EXPORT_NO_SYMBOLS; somewhere in the module (no change to Makefile).

 objdump -h `modprobe -l` | \
 awk '/file format/{file = $1}/__ksymtab/{file = ""}/\.comment/ && file != "" {print file}'

