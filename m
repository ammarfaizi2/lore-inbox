Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVAMTDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVAMTDA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVAMTCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:02:43 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:62122 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261362AbVAMS7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 13:59:11 -0500
Message-ID: <41E6C507.5050302@comcast.net>
Date: Thu, 13 Jan 2005 13:59:19 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>  <20050112185133.GA10687@kroah.com>  <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>  <20050112161227.GF32024@logos.cnet>  <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>  <20050112205350.GM24518@redhat.com>  <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>  <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com>  <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>  <20050113082320.GB18685@infradead.org>  <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105632757.4624.59.camel@localhost.localdomain> <Pine.LNX.4.58.0501130926260.2310@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501130926260.2310@ppc970.osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Linus Torvalds wrote:
> 
> On Thu, 13 Jan 2005, Alan Cox wrote:
> 
>>On Iau, 2005-01-13 at 16:38, Linus Torvalds wrote:
>>

[...]

> Am I claiming that disallowing self-written ELF binaries gets rid of all 
> security holes? Obviously not. I'm claiming that there are things that 
> people can do that make it harder, and that _real_ security is not about 
> trusting one subsystem, but in making it hard enough in many independent 
> ways that it's just too effort-intensive to attack.
> 

I think you can make it non-guaranteeable.

> It's the same thing with passwords. Clearly any password protected system
> can be broken into: you just have to guess the password. It then becomes a
> matter of how hard it is to "guess" - at some point you say a password is
> secure not because it is a password, but because it's too _expensive_ to
> guess/break.
> 

You can't guarantee you can guess a password.  You could for example
write a pam module that mandates a 3 second delay on failed
authentication for a user (it does it for the console currently; use 3
separate consoles and you can do the attack 3 times faster).  Now you
have to guess the password with one try every 3 seconds.

aA1# 96 possible values per character, 8 characters.  7.2139x10^15
combinations.  It takes 686253404.7 years to go through all those at one
every 3 seconds.  You've got a good chance at half that.

This isn't "hard," it's "infeasible."  I think the idea is to make it so
an attacker doesn't have to put lavish amounts of work into creating an
exploit that reliably re-exploits a hole over and over again; but to
make it so he can't make an exploit that actually works, unless it works
only by rediculously remote chance.

> So all security issues are about balancing cost vs gain. I'm convinced
> that the gain from openness is higher than the cost. Others will disagree.  
> 

Yes.  Nobody code audits your binaries.  You need source code to do
source code auditing.  :)

> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5sUGhDd4aOud5P8RAtL7AJ45IkplC/ArkSykOPdkwrXknhpgdwCgjLHJ
H8I593lQ0EuESMpriE6UIy0=
=kcas
-----END PGP SIGNATURE-----
