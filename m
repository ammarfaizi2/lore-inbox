Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbVEGD6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbVEGD6K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 23:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVEGD6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 23:58:10 -0400
Received: from 1-1-10-11a.has.sth.bostream.se ([82.182.131.18]:54194 "EHLO
	DeepSpaceNine.stesmi.com") by vger.kernel.org with ESMTP
	id S262644AbVEGD6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 23:58:01 -0400
Message-ID: <427C3D8A.9080600@stesmi.com>
Date: Sat, 07 May 2005 06:01:14 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ricky Beam <jfbeam@bluetronic.net>
CC: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
References: <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net>
In-Reply-To: <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>When I wrote schwanz3(*) for fun, I noticed /proc/cpuinfo
>>varies very much on different architectures.
> 
> Yep, and it has been this way since the begining of time.
> 
>>So that one at least can count the cpus on every system the same way.
> 
> Hah.  Give me a minute to stop laughing...  I argued the same point almost
> a decade ago.  Linus decided to be an ass and flat refused to ever export
> numcpu (or any of the current day derivatives) which brought us to the
> bullshit of parsing the arch dependant /proc/cpuinfo.

Hey Ricky.

Not to be a pain but how exactly would that interface look today
in your eyes?

Single AthlonXP system - 1 cpu right?
Dual Opteron - 2 cpu right?

Now come the interesting things :

Single P4 w/ HT enabled - 1 or 2?

even more interesting :

DualCore P4 w/ HT disabled - 1 or 2 ?

And to top it off :

DualCore P4 w/ HT enabled - 1, 2 or 4 ?

Show me a scalable interface that can account
for all cases here.

One software might want to count each virtual
CPU as 1 hence the DC P4 w/ HT it would want
to count as 4.
Another software might want to only count
the cores, hence count them as 2.
Yet another software might want to count it as
1.

Then of course we might have a system with 4
DualCore whatever with HT with 4 CPU boards
in some kind of NUMA. Do you want to count
4 CPU's (4 boards) or do you want 16 CPU's
(4 boards * 4 CPU's per board) or 32 CPU's
(4 boards * 4 CPU's per board * 2 cores per CPU)
or .. or .. or ..

It quickly gets out of hand.

And everybody will want to count it differently.

If you set a standard "only count physical CPUs"
then the next guy will think differently.

Same as if you set the standard to "only count
physical cores".

Today we have dualcore, HT, other kinds of SMT, etc,
add multiple CPU's per board in a NUMA or some kind
of clustering ...

So yes, I do agree that it would be good to have an
easy way to get it but the question is .. what is
a person after..

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFCfD2KBrn2kJu9P78RAr5sAKC4StnvHWvKvf2IljbEhHDpEDs11ACgiy4W
RCa9q9OanAS0LcYhdnz3TE0=
=g0Y7
-----END PGP SIGNATURE-----
