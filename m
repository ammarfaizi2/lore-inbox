Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269225AbUIYEHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269225AbUIYEHm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 00:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269226AbUIYEHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 00:07:42 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:22191 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S269225AbUIYEHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 00:07:40 -0400
Date: Sat, 25 Sep 2004 06:07:10 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Valdis.Kletnieks@vt.edu
Cc: David Lang <david.lang@digitalinsight.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040925040710.GH3309@dualathlon.random>
References: <20040924225900.GY3309@dualathlon.random> <1096069581.3591.23.camel@desktop.cunninghams> <20040925010759.GA3309@dualathlon.random> <Pine.LNX.4.60.0409241819580.1341@dlang.diginsite.com> <20040925013013.GD3309@dualathlon.random> <200409250147.i8P1kxtm016914@turing-police.cc.vt.edu> <20040925021501.GF3309@dualathlon.random> <200409250246.i8P2kWwx027390@turing-police.cc.vt.edu> <20040925025848.GG3309@dualathlon.random> <200409250329.i8P3TwJY002358@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409250329.i8P3TwJY002358@turing-police.cc.vt.edu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 11:29:58PM -0400, Valdis.Kletnieks@vt.edu wrote:
> loop-AES stuff does and forces a minimim 20-char passphrase) - there's going to
> be all too many blocks in the swsusp area that are "known plaintext" and easily

well, it's not a filesystem with superblock at fixed location for
example, the data location and contents is mostly random, or certainly
not a "known plaintext". Brute forcing cryptoloop is probably a joke
compared to brute forcing cryptoswap. But I sure agree a more secure
method is welcome (if it exists ;)

My point is simply that if the hashed key is stored in a known location
(and it has to, or the resume procedure couldn't find it either), the
same brute force plaintext attack would work on the hashed key too
(perhaps slower). Or am I missing something about crypto here? Is it the
induced slowdown what provides higher protection? the algorithm is one
way anyways, so it's not that the hash is the one that prevents
reversing it from the plaintext. Brute force is still against the
passphrase and nothing else, hence the same complexity (though slower
with an additional hash to compute plus lots more bits of key for each
brute-force try).

with GPG and SSH the real powerful thing is that the attacker has no
access to your .gnupg and .ssh directory with the private secret keys,
but if he had access, brute forcing it shouldn't be more difficult than
brute forcing a single passphrase, if the private key is known the only
unknown bits that provides security are the ones of your passphrase.
But again, I may be missing something about crypto here, corrections
welcome so I can learn too ;).

> So in order to make it at all secure, we really need to save on the disk
> a key with O(128 bits) of entropy, perturbed by enough bits that are *not*
> to be found anywhere on the machine so that it isn't a slam-dunk for an attacker.

if they're "not to be found anywhere", how can resume find them? ;)

> Do any of the crypto experts lurking have ideas/opinions on just how many
> bits we need to store externally (be it in a USB dongle, a thumbprint, a
> passphrase, whatever)?

I think as many as we can, since I'm afraid it's the only protection we
get. But here we've the huge advantage of not having known plaintext in
known places on disk.
