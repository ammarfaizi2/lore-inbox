Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318012AbSGRL7i>; Thu, 18 Jul 2002 07:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318013AbSGRL7i>; Thu, 18 Jul 2002 07:59:38 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:20745 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318012AbSGRL7h>; Thu, 18 Jul 2002 07:59:37 -0400
Date: Thu, 18 Jul 2002 14:02:13 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Daniel Phillips <phillips@arcor.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] new module format
In-Reply-To: <E17V9A1-0004ml-00@starship>
Message-ID: <Pine.LNX.4.44.0207181350020.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 18 Jul 2002, Daniel Phillips wrote:

> To add a new user, the active bit has to be set, as shown in this skeleton,
> which is pretty much the existing try_inc_mod_count scheme:
>
>        spin_lock(&some_spinlock);
>        if (<mod_active_bit>)
>                <inc_mod_user_count>
>        spin_unlock(&some_spinlock);
>
>        if <users>, do the mount
>
> In other words, the module has some state, the transitions of which are
> protected by a spinlock.

This means you still need another lock to protect the data structures and
you still have module pointers everywhere. I want to get rid of that
"same_spinlock" (aka unload_lock), because it's not needed.
I suggest we continue this discussion when I post the new patches in a few
days, then it should become more clear.

bye, Roman

