Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbSK1F0I>; Thu, 28 Nov 2002 00:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265197AbSK1F0I>; Thu, 28 Nov 2002 00:26:08 -0500
Received: from pizda.ninka.net ([216.101.162.242]:34721 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265196AbSK1F0G>;
	Thu, 28 Nov 2002 00:26:06 -0500
Date: Wed, 27 Nov 2002 21:31:48 -0800 (PST)
Message-Id: <20021127.213148.94755458.davem@redhat.com>
To: torvalds@transmeta.com
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, anton@samba.org,
       ak@muc.de, davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0211270913480.7657-100000@home.transmeta.com>
References: <20021127184228.2f2e87fd.sfr@canb.auug.org.au>
	<Pine.LNX.4.44.0211270913480.7657-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Wed, 27 Nov 2002 09:18:06 -0800 (PST)

   May I just suggest doing a
   
   	kernel/compat32.c
   
   and doing most everything there? I think we're better off that way, even 
   if it means that "do_nanosleep()" etc cannot be static.

Please not this, this will continue the current problem we have
wherein overhauls of things like VFS infrastructure don't propagate to
the compat syscall implementations.

Putting the compat stuff right next to the "normal" version has
several advantages, one of which is that it is kept in sync with
things almost automatically.  You have no choice but to notice
it, it's right there.

This isn't a "oh well we have to export some things" issue, it's a
long term maintainence issue.  It is the main reason we want to move
this into a common area rather than deep within the arch code.
