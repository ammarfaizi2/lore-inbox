Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWC0AF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWC0AF0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 19:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWC0AF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 19:05:26 -0500
Received: from c-67-177-57-20.hsd1.co.comcast.net ([67.177.57.20]:16879 "EHLO
	sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S932228AbWC0AFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 19:05:25 -0500
Date: Sun, 26 Mar 2006 17:05:22 -0700
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: Michael Halcrow <lkml@halcrow.us>
Cc: Phillip Susi <psusi@cfl.rr.com>, Michael Halcrow <mhalcrow@us.ibm.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk,
       mcthomps@us.ibm.com, yoder1@us.ibm.com, toml@us.ibm.com,
       emilyr@us.ibm.com, daw@cs.ber
Subject: Re: eCryptfs Design Document
Message-ID: <20060327000522.GA11655@hellewell.homeip.net>
References: <20060324222517.GA13688@us.ibm.com> <442599D5.806@cfl.rr.com> <20060325195015.GA8174@halcrow.us> <4426CB05.2070604@cfl.rr.com> <20060326180458.GA10056@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326180458.GA10056@halcrow.us>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The salt in eCryptfs is 64 bits (8 octets, per the spec of the
> iterated and salted S2K; see Section 3.6.1.3 RFC 2440). Without the
> iterated hashing, the raw dictionary generation will require storage
> on the scale of 2^64 multiplied by the size of the dictionary. I think
> this is big enough to address any attacks that involve pre-computed
> dictionaries, as you have already pointed out.

I concur with Mike.  The salt is long enough to effectively thwart any
possibility of a pre-computed dictionary attack.

> The dictionary attack that I have in mind that I would like to make a
> ``bit'' harder is the dedicated attack against one particular file. If
> an attacker just wants to attack the passphrase on that file, then
> without iterated hashing, the difficulty is roughly proportional (in
> aggregate) to half size of the dictionary. If the passphrase is weak,
> then the file will likely be compromised anyway, but at least an
> iterated hash multiplies the amount of work that the dictionary
> attacker needs to do by the number of iterations.

Again I concur with Mike.  Iterative hashing is a very common technique,
and is very effective against this type of dictionary attack.  If you
hash 1000 times, then an attack that normally could check 1 million
passwords per second would now only be able to check 1000 passwords per
second.

Without iterative hashing, as computers get faster, so would dictionary
attacks, and then people would have to keep using longer and longer
passwords to be as effective.  Iterative hashing "levels the playing
field" in a way.

> Keep in mind that, for the current release of eCryptfs, the iterated
> hashing only happens once per mount, not once per file, and so there
> is very little cost to the user, and it has at least some security

Again, I agree with Mike.  The cost is extremely small, especially since
the hashing only happens once per mount.  As long as we make sure that
on an average computer it takes less than a second, or make it
configurable so the user can keep it as small as they want, then I can't
see anything but good coming from an iterative hash.

Now what would be really cool is if we could auto-configure the number
of iterations so that it always ends up taking 1/10 of a second to
perform a hash.  Then it will always hash a reasonable number of times
regardless of your computer speed.

Remeber, a user is not going to notice a 1/10 of a second pause when
they type in their password, but an attacker will definitely notice that
they are only able to guess 10 passwords per second!

Phillip

-- 
Phillip Hellewell <phillip AT hellewell.homeip.net>
