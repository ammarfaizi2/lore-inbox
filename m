Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267043AbUBGSMo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 13:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267058AbUBGSMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 13:12:44 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:5131 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267043AbUBGSMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 13:12:42 -0500
Subject: Re: Unknown symbol _exit when compiling VMware vmmon.o module
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Valdis.Kletnieks@vt.edu
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <200402071748.i17HmIBw023631@turing-police.cc.vt.edu>
References: <1076175615.798.9.camel@teapot.felipe-alfaro.com>
	 <200402071748.i17HmIBw023631@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1076177542.798.13.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sat, 07 Feb 2004 19:12:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-07 at 18:48, Valdis.Kletnieks@vt.edu wrote:
> On Sat, 07 Feb 2004 18:40:16 +0100, Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>  said:
> > Hi!
> > 
> > After installing VMware Workstation 4.5.0-7174 and running
> > vmware-config.pl, I get the following error when trying to insert
> > vmmon.ko into the kernel:
> > 
> > vmmon: Unknown symbol _exit
> > 
> > What can I use instead of _exit(code) inside a module?
> 
> panic()? (Where would the kernel _exit() *TO*?)
> 
> I think you misbuilt the kernel module...

No, I don't think so... look at this code:

#ifdef MODULE_X86_64
	exit(1);
#else
	_exit(1);
#endif
	for (;;);	/* To suppress warning. */

This is a snippet from driver.c.

Bah! I've simply removed the #ifdef...#endif code and it seems to work,
but I was really curious why VMware was using _exit() for i386 and
exit() for x86_64.

