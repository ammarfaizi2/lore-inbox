Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132367AbRCZHPV>; Mon, 26 Mar 2001 02:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132368AbRCZHPL>; Mon, 26 Mar 2001 02:15:11 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:18957 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132367AbRCZHPA>;
	Mon, 26 Mar 2001 02:15:00 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Hinds <dhinds@sonic.net>
cc: linux-kernel@vger.kernel.org
Subject: 2.2.19 aic7xxx breaks pcmcia
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Mar 2001 17:14:13 +1000
Message-ID: <22779.985590853@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.2.19 Documentation/Changes says pcmcia-cs 3.0.14.  I am using 3.1.21
and it breaks if you compile the kernel with scsi support then try to
compile pcmcia.  clients/apa1480_stub.c in 3.1.21 has
  #include <../drivers/scsi/aic7xxx.h>
but in 2.2.19 that file is drivers/scsi/aic7xxx/aic7xxx.h.  You need at
least pcmcia-cs 3.1.25 for kernel 2.2.19 with scsi support.

In the kernel and associated utilities I want to remove lines like
  #include <../drivers/scsi/aic7xxx.h>
and replace them with
  #include "aic7xxx.h"
with the Makefile specifying -I $(TOPDIR)/drivers/scsi (2.2.18) or -I
$(TOPDIR)/drivers/scsi/aic7xxx (2.2.19).  Hard coding long path names
for #include is bad, especially when they contain '..'.  It stops
kernel developers moving code around and makes it difficult to do some
of the things I plan for the 2.5 Makefile rewrite.  David, how easy
would it be to change pcmcia to this style of include?

