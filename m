Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbTABRGt>; Thu, 2 Jan 2003 12:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265508AbTABRGs>; Thu, 2 Jan 2003 12:06:48 -0500
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:8360 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id <S265424AbTABRGs>; Thu, 2 Jan 2003 12:06:48 -0500
Subject: Re: [PATCH] Deprecate exec_usermodehelper, fix request_module.
From: Marcel Holtmann <marcel@holtmann.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       akpm@zip.com.au, Thomas Sailer <sailer@ife.ee.ethz.ch>,
       Jose Orlando Pereira <jop@di.uminho.pt>,
       J.E.J.Bottomley@HansenPartnership.com
In-Reply-To: <20030102093637.8C6892C2FB@lists.samba.org>
References: <20030102093637.8C6892C2FB@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 02 Jan 2003 18:14:17 +0100
Message-Id: <1041527666.16046.18.camel@pegasus.local>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

> I got a report from Urban Widmark that modprobe dropped its privs on
> executing an install command: turns out request_module
> (ie. exec_usermodehelper) doesn't set the real uid or gid (so bash
> drops privs).
> 
> These efforts to "clean" the current process are *always* going to be
> buggy: we should use the event thread all the time, rather than
> forking a random thread and trying to clean it.  This fixes
> request_module to do that (kevent threads can't block, so we
> double-fork).
> 
> There are still three
> (obscure) users of exec_usermodehelper in the tree:
> 
> 	drivers/net/hamradio/baycom_epp.c
> 	drivers/bluetooth/bt3c_cs.c
> 	arch/i386/mach-voyager/voyager_thread.c

for the bt3c_cs driver I need to run a user space program that downloads
the firmware into the card and the kernel part have to wait until this
program has finished. So what is the best way to do this now?

Regards

Marcel


