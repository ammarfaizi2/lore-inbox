Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272792AbTHENu4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 09:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272793AbTHENu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 09:50:56 -0400
Received: from [24.241.190.29] ([24.241.190.29]:58515 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S272792AbTHENuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 09:50:51 -0400
Date: Tue, 5 Aug 2003 09:50:46 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: FINALLY caught a panic
Message-ID: <20030805135046.GO13456@rdlg.net>
Mail-Followup-To: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030805122354.GL13456@rdlg.net> <Pine.LNX.4.53.0308050818130.7244@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y6PvmTFIYclVmRST"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308050818130.7244@montezuma.mastecende.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y6PvmTFIYclVmRST
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thus spake Zwane Mwaikambo (zwane@arm.linux.org.uk):

> On Tue, 5 Aug 2003, Robert L. Harris wrote:
>
> > Unable to handle kernel paging request at virtual address 8011c560
> >  printing eip:
> > 8011c560
> > *pde = 00000000
> > Oops: 0000
> > CPU:    1
> > EIP:    0010:[<8011c560>]    Not tainted
> > EFLAGS: 00010286
> > eax: 8011c560   ebx: c037f754   ecx: 00000040   edx: c0357980
> > esi: 00000040   edi: c037f740   ebp: c037ef40   esp: c1e19f28
> > ds: 0018   es: 0018   ss: 0018
> > Process swapper (pid: 0, stackpage=c1e19000)
> > Stack: c011c47d 00000001 c0358180 00000001 fffffffe 00000040 c011c1ff c0358180
> >        c037ef40 c0351800 00000000 c1e19f74 00000046 c0108bdb c0105400 c1e18000
> >        c0105400 00000040 c02f5b44 00000000 c010ae78 c0105400 c1e18000 c1e18000
> > Call Trace: [<c011c47d>] [<c011c1ff>] [<c0108bdb>] [<c0105400>] [<c0105400>]
> >    [<c010ae78>] [<c0105400>] [<c0105400>] [<c010542c>] [<c01054a2>] [<c0117e7f>]
> >    [<c0117d8e>]
> >
> > Code:  Bad EIP value.
> >  <0>Kernel panic: Aiee, killing interrupt handler!
> > In interrupt handler - not syncing
>


Running the above through ksymoops on an identicle machine with the same
kernel, etc I get this:

8011c560
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<8011c560>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 8011c560   ebx: c037f754   ecx: 00000040   edx: c0357980
esi: 00000040   edi: c037f740   ebp: c037ef40   esp: c1e19f28
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c1e19000)
Stack: c011c47d 00000001 c0358180 00000001 fffffffe 00000040 c011c1ff c0358180
       c037ef40 c0351800 00000000 c1e19f74 00000046 c0108bdb c0105400 c1e18000
       c0105400 00000040 c02f5b44 00000000 c010ae78 c0105400 c1e18000 c1e18000
Call Trace: [<c011c47d>] [<c011c1ff>] [<c0108bdb>] [<c0105400>] [<c0105400>]
   [<c010ae78>] [<c0105400>] [<c0105400>] [<c010542c>] [<c01054a2>] [<c0117e7f>]
   [<c0117d8e>]
Code:  Bad EIP value.

>>EIP; 8011c560 Before first symbol   <=====
Trace; c011c47d <tasklet_hi_action+5d/90>
Trace; c011c1ff <do_softirq+6f/d0>
Trace; c0108bdb <do_IRQ+db/f0>
Trace; c0105400 <default_idle+0/40>
Trace; c0105400 <default_idle+0/40>
Trace; c010ae78 <call_do_IRQ+5/d>
Trace; c0105400 <default_idle+0/40>
Trace; c0105400 <default_idle+0/40>
Trace; c010542c <default_idle+2c/40>
Trace; c01054a2 <cpu_idle+42/60>
Trace; c0117e7f <release_console_sem+8f/a0>
Trace; c0117d8e <printk+11e/140>

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.




This is a dual 1.5Ghz AMD, 1Gig of ram, kernel 2.4.18 with i2c version
2.6.5.  Everything but the i2c is compiled in staticly.  Out of 35ish
machins which are identicle this is the only one leading me to believe
something hardware related, any reliable guesses as to what/why?

And thanks for those taking the time to help,
  Robert





:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--y6PvmTFIYclVmRST
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/L7Y28+1vMONE2jsRAvPwAJ0c23gy0UuQZzoTDFtxGw32DOXPlACg0xt8
3iJllSbRcEnJuZzc4lrq8UM=
=KOGm
-----END PGP SIGNATURE-----

--y6PvmTFIYclVmRST--
