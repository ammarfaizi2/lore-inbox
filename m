Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316951AbSHGL0s>; Wed, 7 Aug 2002 07:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSHGL0r>; Wed, 7 Aug 2002 07:26:47 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:32519 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S316951AbSHGL0r>; Wed, 7 Aug 2002 07:26:47 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15697.1225.84051.277799@laputa.namesys.com>
Date: Wed, 7 Aug 2002 15:30:17 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: kernel thread exit race
In-Reply-To: <1028722283.18156.274.camel@irongate.swansea.linux.org.uk>
References: <15696.59115.395706.489896@laputa.namesys.com>
	<1028719111.18156.227.camel@irongate.swansea.linux.org.uk>
	<15696.61666.452460.264138@laputa.namesys.com>
	<1028722283.18156.274.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Tom-Swifty: "You pinhead," Tom said pointedly.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > On Wed, 2002-08-07 at 11:05, Nikita Danilov wrote:
 > > Ah I see, thank you and Russell. But this depends on no architecture
 > > ever accessing spinlock data after letting waiters to run, otherwise
 > > there still is (tiny) window for race at the end of complete() call,
 > > right?
 > 
 > complete() as opposed to spinlocks/semaphores is defined to be safe to
 > free the object once the complete finishes

So, complete() is not-arch dependent because spinlocks are "good" in all
architectures? complete() ends with spin_unlock_irqrestore() so it
cannot be any better than spinlocks, until there is some hidden magic.

Let me clarify this. Suppose there is some obscure architecture that
maintains in spinlocks some additional data for debugging. Then,

complete_and_exit()->complete()->spin_unlock_irqrestore() 

"wakes up" thread on another CPU and proceeds to access spin-lock data
(to check/update debugging information, for example), but by this time
woken up thread manages to unload module and to un-map page containing
spin-lock data.

 > 

Nikita.
