Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265598AbSJSNVA>; Sat, 19 Oct 2002 09:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265600AbSJSNVA>; Sat, 19 Oct 2002 09:21:00 -0400
Received: from a169250.upc-a.chello.nl ([62.163.169.250]:3844 "EHLO
	walton.kettenis.dyndns.org") by vger.kernel.org with ESMTP
	id <S265598AbSJSNVA>; Sat, 19 Oct 2002 09:21:00 -0400
Date: Sat, 19 Oct 2002 15:26:01 +0200 (CEST)
Message-Id: <200210191326.g9JDQ19e001214@elgar.kettenis.dyndns.org>
From: Mark Kettenis <kettenis@chello.nl>
To: mark@thegnar.org
CC: phil-list@redhat.com, dan@debian.org, mgross@unix-os.sc.intel.com,
       linux-kernel@vger.kernel.org, phil-list@redhat.com
In-reply-to: <200210180657.38291.mark@thegnar.org> (message from Mark Gross on
	Fri, 18 Oct 2002 06:57:38 -0700)
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
References: <Pine.LNX.4.44.0210171009240.12653-100000@localhost.localdomain> <200210180004.g9I04OP17510@unix-os.sc.intel.com> <20021018004847.GA27817@nevyn.them.org> <200210180657.38291.mark@thegnar.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mark Gross <mark@thegnar.org>
   Date: Fri, 18 Oct 2002 06:57:38 -0700

   I think I fixed it to set namesz to 5, with the +1 it was making it 6.  My 
   patch is supposed to remove the +1.

The System V ABI (which is the specification that defines ELF) says
that the namesz should include the terminating 0 of the note name,
therefore we should have the +1, and namesz should be 6 for notes with
the name "LINUX".  The Linux kernel has been doing the wrong thing for
ages, and somehow BFD picked this up for the particular note we're
discussing here.  For other notes this doesn't matter since BFD
doesn't look at the name at all.  The bottom-line is that the kernel
is doing the right thing now and we should fix BFD, which I'm going to
do shortly.

Mark
