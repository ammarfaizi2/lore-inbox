Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132018AbQLQCt2>; Sat, 16 Dec 2000 21:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131971AbQLQCtR>; Sat, 16 Dec 2000 21:49:17 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:30222 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131936AbQLQCtH>; Sat, 16 Dec 2000 21:49:07 -0500
Date: Sat, 16 Dec 2000 20:18:37 -0600
To: Miquel van Smoorenburg <miquels@traveler.cistron-office.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linus's include file strategy redux
Message-ID: <20001216201837.P3199@cadcamlab.org>
In-Reply-To: <20001215152137.K599@almesberger.net> <NBBBJGOOMDFADJDGDCPHAENMCJAA.law@sgi.com> <91e0so$9bn$1@enterprise.cistron.net> <20001216171000.L3199@cadcamlab.org> <91h43e$cec$1@enterprise.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <91h43e$cec$1@enterprise.cistron.net>; from miquels@traveler.cistron-office.nl on Sun, Dec 17, 2000 at 01:15:26AM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Peter Samuelson]
> >  make -C /lib/modules/`uname -r`/build modules SUBDIRS=$(pwd)

[Miquel van Smoorenburg]
> Excellent. Is there any way to put his in a Makefile?

I don't know why not.  Here's what I would start with:

  PWD := $(shell pwd)
  KERNEL := /lib/modules/$(shell uname -r)/build
  CALLMAKE = $(MAKE) -C $(KERNEL) SUBDIRS=$(PWD)

  all:
  	# ...other stuff...
  	$(CALLMAKE) modules

  install:
  	# ...other stuff...
  	$(CALLMAKE) modules_install

  # ...other stuff...
  include $(TOPDIR)/Rules.make

Not *quite* that simple, but it's a start.  Note that with this
construction you let the savvy user override $(KERNEL) at the command
line.  (I, for one, would insist.)

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
