Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269006AbUIXVmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269006AbUIXVmd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 17:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269010AbUIXVmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 17:42:32 -0400
Received: from science.horizon.com ([192.35.100.1]:31788 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S269006AbUIXVmb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 17:42:31 -0400
Date: 24 Sep 2004 21:42:30 -0000
Message-ID: <20040924214230.3926.qmail@science.horizon.com>
From: linux@horizon.com
To: jlcooke@certainkey.com
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Cc: cryptoapi@lists.logix.cz, jmorris@redhat.com, linux-kernel@vger.kernel.org,
       tytso@mit.edu
In-Reply-To: <20040924023413.GH28317@certainkey.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What if I told the SHA-1 implementation in random.c right now is weaker
> than those hashs in terms of collisions?  The lack of padding in the
> implementation is the cause.  HASH("a\0\0\0\0...") == HASH("a") There
> are billions of other examples.

EXCUSE me?  You're a little unclear, so I don't want to be attacking strawmen
of my own devising, but are you claiming the failure to do Merkle-Damgaard
padding in the output mixing operation of /dev/random is a WEAKNESS?

If true, this is a level of cluelessness incompatible with being trusted
to design decent crypto.

The entire purpose of Merkle-Damgaard padding (also know as
Merkle-Damgaard strengthening) is to include the length in the data
hashed, to make hashing variable-sized messages as secure as fixed-size
messages.  If what you are hashing is, by design, always fixed-length,
this is completely unnecessary.

If I were designing a protocol for message interchange, I might add
the padding anyway, just to use pre-existing primitives easily, but
for a 100% internal use like a PRNG, let's see... I can reduce code
size AND implementation complexity AND run time without ANY security
consequences, and there are no interoperability issues...

I could argue it's a design flaw to *include* the padding.
