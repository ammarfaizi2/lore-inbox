Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267965AbTBSECA>; Tue, 18 Feb 2003 23:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267969AbTBSECA>; Tue, 18 Feb 2003 23:02:00 -0500
Received: from almesberger.net ([63.105.73.239]:5132 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267965AbTBSEB7>; Tue, 18 Feb 2003 23:01:59 -0500
Date: Wed, 19 Feb 2003 01:11:54 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Roman Zippel <zippel@linux-m68k.org>, kuznet@ms2.inr.ac.ru,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Is an alternative module interface needed/possible?
Message-ID: <20030219011154.X2092@almesberger.net>
References: <20030218142257.A10210@almesberger.net> <20030219033429.9DA592C0CC@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219033429.9DA592C0CC@lists.samba.org>; from rusty@rustcorp.com.au on Wed, Feb 19, 2003 at 02:30:46PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Of course, if you wanted to remove the entry at any other time
> (eg. hotplug), this doesn't help you one damn bit (which is kind of
> your point).

Yep, try_module_get solves the general synchronization problem for
the special but interesting case of modules, but not for the general
case.

> This is what network devices do, and what the sockopt registration
> code does, too, so this is already in the kernel, too.  It's not
> great, but it becomes a noop for the module deregistration stuff.

Yes, I think just sleeping isn't so bad at all. First of all,
we already have the module use count as a kind of "don't unload
now" advice (not sure if you plan to phase out MOD_INC_USE_COUNT ?),
and second, it's not exactly without precedent anyway. E.g. umount
will have little qualms of letting you sleep "forever". (And,
naturally, every once in a while, people hate it for this :-)

Anyway, I'll write more about this tomorrow. For tonight, I
have my advanced insanity 101 to finish, topic "ptracing
more than one UML/TT at the same time".

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
