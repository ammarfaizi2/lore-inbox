Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267032AbTAPEkq>; Wed, 15 Jan 2003 23:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbTAPEkq>; Wed, 15 Jan 2003 23:40:46 -0500
Received: from almesberger.net ([63.105.73.239]:18450 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267032AbTAPEkp>; Wed, 15 Jan 2003 23:40:45 -0500
Date: Thu, 16 Jan 2003 01:49:32 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "David S. Miller" <davem@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       "Alexey N. Kuznetsov" <kuznet@ms2.inr.ac.ru>,
       Roman Zippel <zippel@linux-m68k.org>, kronos@kronoz.cjb.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
Message-ID: <20030116014932.G1521@almesberger.net>
References: <20030116033343.C87CF2C33D@lists.samba.org> <1042691130.13364.1.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042691130.13364.1.camel@rth.ninka.net>; from davem@redhat.com on Wed, Jan 15, 2003 at 08:25:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> I totally agree with Rusty.  If you don't understand this fundamental
> difference between module unloading vs. arbitrary kernel objects
> going away,

I think I understand that part. What I'm saying is that any
interface that will still call you after deregistration will
also cause problems with normal data accesses, even if no
modules are involved.

So, if interfaces with this kind of bug are fixed, all of a
sudden the second (1) synchronization mechanism for module
unloads - returning from the cleanup function (2) - becomes
a viable alternative to try_module_get.

(1) The first mechanism being the use count.
(2) Or, in the case of initialization failure, returning
    from the init function.

And that's what I think we should build upon. Rusty doesn't
see things this way, and I'd like to find out where exactly
we disagree.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
