Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267190AbTAPSdX>; Thu, 16 Jan 2003 13:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267191AbTAPSdX>; Thu, 16 Jan 2003 13:33:23 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:35600 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267190AbTAPSdU>; Thu, 16 Jan 2003 13:33:20 -0500
Message-ID: <3E26D82E.35A57506@linux-m68k.org>
Date: Thu, 16 Jan 2003 17:05:02 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       Werner Almesberger <wa@almesberger.net>,
       "Alexey N. Kuznetsov" <kuznet@ms2.inr.ac.ru>, kronos@kronoz.cjb.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
References: <20030116033343.C87CF2C33D@lists.samba.org> <1042691130.13364.1.camel@rth.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"David S. Miller" wrote:

> On Wed, 2003-01-15 at 19:31, Rusty Russell wrote:
> > The ONLY time that FUNCTIONS vanish is when MODULES get UNLOADED (or
> > fail to LOAD).
> 
> I totally agree with Rusty.  If you don't understand this fundamental
> difference between module unloading vs. arbitrary kernel objects
> going away, then you really need to apply some gray matter to it
> before you continue in this conversation :)

Above is not really not wrong, but there is still no fundamental
difference to other kernel objects. We will get this wrong as long as we
see functions as some kind of very special case, this is simply not
true.
Module functions are nothing else than readonly data structures, which
are allocated and initialized in module.c, by calling init_module() the
ownership is transferred to the module. How the ownership is transferred
back is now (hopefully) the point of the discussion. The only thing
special here is that the data possibly needs to be flushed out of the
data cache, before it can be used as a function. Besides of this there
is not a single technical difference to other reference counted data
structures, just the implementations differ.
Functions are not the only thing that vanish when modules get unloaded.
It's a lot more common to register functions via data structures and it
would be very foolish to think that only the functions need protecting.
In the first place one has to get access to the data structure, only
then the functions can be safely used. Again, how these data structures
are allocated doesn't matter, but at any time we have to know, who owns
these data structures, so that we can safely remove and deallocate them.

bye, Roman


