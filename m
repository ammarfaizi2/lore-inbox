Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266849AbTAORs1>; Wed, 15 Jan 2003 12:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266859AbTAORs1>; Wed, 15 Jan 2003 12:48:27 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:55813 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266849AbTAORrd>; Wed, 15 Jan 2003 12:47:33 -0500
Message-ID: <3E259489.2CFCAAA@linux-m68k.org>
Date: Wed, 15 Jan 2003 18:04:09 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Werner Almesberger <wa@almesberger.net>, kuznet@ms2.inr.ac.ru,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
References: <20030115082444.062EF2C0F0@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rusty Russell wrote:

> 2) It's bad enough to force the interfaces to change: at least the
>    primitive they are to use is one many of them are already using,
>    and is very simple to understand.

They are indeed simple, but only because it's impossible to implement
anything more complex.
An example: A "rmmod -w loop" will currently deadlock on a busy loop
module. Could you please explain, how it will be possible to force a
safe removal of the loop module?

> PS.  The *implementation* flaw in your scheme: someone starts using a
>      module as you try to deregister it.  Either you re-register the
>      module (ie. you can never unload security modules), or you leave
>      it half unloaded (even worse).

What is the problem with a half unloaded module? Only the module knows
which interfaces it can safely remove to prevent new users, afterwards
it only has to wait for remaining user to leave to complete the cleanup.
BTW this also solves nicely the module init race.

bye, Roman

