Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286501AbRL0S6S>; Thu, 27 Dec 2001 13:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286482AbRL0S6I>; Thu, 27 Dec 2001 13:58:08 -0500
Received: from mons.uio.no ([129.240.130.14]:24021 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S286477AbRL0S54>;
	Thu, 27 Dec 2001 13:57:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15403.28458.153083.961800@charged.uio.no>
Date: Thu, 27 Dec 2001 19:57:46 +0100
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: Amber Palekar <amber_palekar@yahoo.com>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Again:syscall from modules
In-Reply-To: <1009468465.15846.0.camel@eggis1>
In-Reply-To: <20011225131441.60811.qmail@web20306.mail.yahoo.com>
	<1009468465.15846.0.camel@eggis1>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Terje Eggestad <terje.eggestad@scali.com> writes:

     > Yes, the sys_* funcs are declared asmlinkage int sys_*. where
     > the asmlinkage differ from platform to platform. It's used to
     > tell the compiler if a non standared calling convertion is
     > used, typically if params are passed by registers instead of
     > stack. The asmlinkage define must be sett according to the
     > syscall dispatcher (entry.S on ia32), and may be changed
     > accordingly.

     > In short, if you want to use sys_* you must understand the
     > interaction between the sys_* funcs and the dispatcher on
     > *every* platform, and the interaction may change without
     > notice.

     > In short short, don't don't don't don't use the sys_*
     > functions.

You are scaremongering a bit here. Several of the sys_* functions
*are* generic, and could be called by quite safely by the kernel. Look
for instance at the use of sys_close() by the binfmt stuff.

Normally, though, there will be a price to pay in terms of an
overhead.
Furthermore, if you find that you absolutely *have* to use the sys_*
interface, from userspace you will probably want to rethink your
design: after all you can call all those sys_* functions from user
space, and the rule of thumb is that if you *can* do something in user
space, you ought to do it there...

Cheers,
  Trond
