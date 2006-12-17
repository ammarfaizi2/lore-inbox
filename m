Return-Path: <linux-kernel-owner+w=401wt.eu-S932342AbWLQSaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWLQSaA (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 13:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWLQSaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 13:30:00 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:44704 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932342AbWLQS37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 13:29:59 -0500
X-Originating-Ip: 24.148.236.183
Date: Sun, 17 Dec 2006 13:25:16 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Zach Brown <zach.brown@oracle.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lots of code could be simplified by using ARRAY_SIZE()
In-Reply-To: <20061217102741.58d2c425.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.64.0612171324350.30593@localhost.localdomain>
References: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain>
 <2F8F687E-C5E5-4F7D-9585-97DA97AE1376@oracle.com>
 <Pine.LNX.4.64.0612141721580.10217@localhost.localdomain>
 <4581DAB0.2060505@s5r6.in-berlin.de> <Pine.LNX.4.61.0612151135330.22867@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0612151547290.6136@localhost.localdomain>
 <Pine.LNX.4.63.0612152351360.16895@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.64.0612171301020.24836@localhost.localdomain>
 <20061217102741.58d2c425.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.754, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Dec 2006, Randy Dunlap wrote:

> On Sun, 17 Dec 2006 13:13:59 -0500 (EST) Robert P. J. Day wrote:
>
> >
> >   so here's the end result of my experiment to replace unnecessary
> > code snippets with an invocation of the ARRAY_SIZE() macro from
> > include/linux/kernel.h.  i've attached the script that i ran on the
> > entire tree, then (after adding al viro's connector patch), did:
> >
> >   $ make allyesconfig	# for the stress factor
> >   $ make
> >
> > to see what would happen.
> >
> >   amazingly, the compile worked all the way down to:
> >
> >   AS      arch/i386/boot/bootsect.o
> >   LD      arch/i386/boot/bootsect
> >   AS      arch/i386/boot/setup.o
> >   LD      arch/i386/boot/setup
> >   AS      arch/i386/boot/compressed/head.o
> >   CC      arch/i386/boot/compressed/misc.o
> >   OBJCOPY arch/i386/boot/compressed/vmlinux.bin
> >   HOSTCC  arch/i386/boot/compressed/relocs
> > arch/i386/boot/compressed/relocs.c: In function 'sym_type':
> > arch/i386/boot/compressed/relocs.c:72: warning: implicit declaration of function 'ARRAY_SIZE'
>
> That's a userspace program and shouldn't use kernel.h.

ah, quite right, my bad.  eggnog hangover.

rday
