Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276069AbRJKLqD>; Thu, 11 Oct 2001 07:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276135AbRJKLpx>; Thu, 11 Oct 2001 07:45:53 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:50695 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S276069AbRJKLpk>;
	Thu, 11 Oct 2001 07:45:40 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Modutils 2.5 change, start running this command now 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Oct 2001 21:45:58 +1000
Message-ID: <25612.1002800758@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Repeat for anybody who ignored this request the first time.

In current modutils, a module that does not export symbols and does not
say EXPORT_NO_SYMBOLS will default to exporting all symbols.  This is a
hangover from kernel 2.0 and will be removed when modutils 2.5 appears,
shortly after the kernel 2.5 branch is created.

Starting with modutils 2.5, modules must explicitly say what their
intention is for symbols.  That will break a lot of existing modules.

The command below lists the modules that are compiled on your system
and will be affected.  All code maintainers need to run this against
their 2.4 modules and do one of two things.  Either export the required
symbols (remember to add the .o file to export-objs in the Makefile) or
add EXPORT_NO_SYMBOLS; somewhere in the module (no change to Makefile).

objdump -h `modprobe -l` | sed -ne '/__ksym/h;$b1;\:^/:!d;:1;x;s/:.*//p;'

