Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266797AbRHSRb1>; Sun, 19 Aug 2001 13:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266921AbRHSRbH>; Sun, 19 Aug 2001 13:31:07 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:51977 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S266797AbRHSRbD>;
	Sun, 19 Aug 2001 13:31:03 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: /dev/random in 2.4.6
Date: 19 Aug 2001 17:27:51 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9losun$pmg$1@abraham.cs.berkeley.edu>
In-Reply-To: <Pine.LNX.3.95.1010815111856.28263A-100000@chaos.analogic.com> <Pine.LNX.4.21.0108151622570.2107-100000@sorbus.navaho>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 998242071 26320 128.32.45.153 (19 Aug 2001 17:27:51 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 19 Aug 2001 17:27:51 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Hill  wrote:
>Hmm...  Well, ATM I've kludged a fix by using /dev/urandom instead, but
>it's not ideal because it's being used to generate cryptographic keys, and
>urandom isn't cryptographically secure.

I think you may want to check again.  /dev/urandom *is* cryptographically
secure, and should be fine to use for generating crypto keys [1].

This seems to be a common point of confusion.


[1] Well, if SHA isn't secure, then /dev/urandom might not be any good.
    But if SHA isn't secure, then the rest of your crypto might not be
    any good either, so you might as well trust /dev/urandom.

    There *is* a subtle difference between the two.  When you want
    forward secrecy, /dev/urandom might be insufficient: If your machine
    is broken into, an attacker can learn the state of the pool, and
    then if you kick off the attacker without rebooting or refreshing
    the /dev/urandom pool, the attacker might be able to predict your
    crypto keys for some time after he's lost access to your machine.
    However, I would imagine that in many settings this may not be a
    major concern, and it is easily remedied by rebooting or by
    otherwise re-seeding the /dev/urandom pool.
