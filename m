Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTJHJUJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 05:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTJHJUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 05:20:09 -0400
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:7828 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S261311AbTJHJUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 05:20:03 -0400
Subject: 2.6.0-test6 drivers/pci/devlist.h and classlist.h appear hideously
	corrupt
From: david nicol <whatever@davidnicol.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1065604797.30213.53.camel@plaza.davidnicol.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 Oct 2003 04:19:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It appears that the second doublequote in
each line has been replaced with CLASS(%s%s, "%s")
and the names of the macros have also been altered.

This is a generated file, and it appears
that the classlist.h file is the corrupt one;
the first four letters on every line get
lopped during the build.  That seems very weird,
but it is what is happening:

S(0c03, "USB Controller")
S(0c04, "Fibre Channel")
S(0c05, "SMBus")

here is what make clean && make gives me:

  CC      drivers/pci/pool.o
  CC      drivers/pci/quirks.o
  HOSTCC  drivers/pci/gen-devlist
  DEVLIST drivers/pci/devlist.h
  CC      drivers/pci/names.o
In file included from drivers/pci/names.c:38:
drivers/pci/devlist.h:7576:11: missing terminating ' character
drivers/pci/devlist.h:7696:30: missing terminating ' character
drivers/pci/devlist.h:7704:30: missing terminating ' character
drivers/pci/devlist.h:7710:34: missing terminating ' character


It appears that the first four chars of each line are getting
lopped from devlist.h as well:

$ head drivers/pci/devlist.h
OR(0000,"Gammagraphx, Inc.CLASS(%s%s, "%s")
ENDOR()

OR(001a,"Ascend Communications, Inc.CLASS(%s%s, "%s")
ENDOR()



What is going on here?  There isn't any significant difference between
the test4and test6 in this directory that I can find, and
it happens even with the test4 pci.ids file.



-- 
david nicol / in 1310 the Dutch invented insurance

