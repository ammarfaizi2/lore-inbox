Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318816AbSHRDrw>; Sat, 17 Aug 2002 23:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318818AbSHRDrw>; Sat, 17 Aug 2002 23:47:52 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:28176
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318816AbSHRDrv>; Sat, 17 Aug 2002 23:47:51 -0400
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Oliver Xymoron <oxymoron@waste.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208172001530.1491-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208172001530.1491-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Aug 2002 23:51:52 -0400
Message-Id: <1029642713.863.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-17 at 23:05, Linus Torvalds wrote:

> This is particularly true on things like embedded routers, where the 
> machine usually doesn't actually _run_ much user-level software, but is 
> just shuffling packets back and forth. Your logic seems to make it not add 
> any entropy from those packets, which can be _deadly_ if then the router 
> is also used for occasionally generating some random numbers for other 
> things.

Agreed.  Further, embedded routers - since they are headless/diskless -
have problems even with the _current_ /dev/random code.  They simply do
not generate enough entropy to fulfill sshd requests [1].

Saying "use /dev/urandom" in this case means we may as well not have a
/dev/random.  There is a difference between incorrect accounting (which
it seems you have identified) and just too strict gathering behavior.

	Robert Love

[1] this is why I wrote my netdev-random patches.  some machines just
    have to take the entropy from the network card... there is nothing
    else.

