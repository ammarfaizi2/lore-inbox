Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268133AbRHSRer>; Sun, 19 Aug 2001 13:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267534AbRHSReh>; Sun, 19 Aug 2001 13:34:37 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:53513 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S268133AbRHSReb>;
	Sun, 19 Aug 2001 13:34:31 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: /dev/random in 2.4.6
Date: 19 Aug 2001 17:31:19 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9lot57$pmg$3@abraham.cs.berkeley.edu>
In-Reply-To: <Pine.LNX.4.21.0108151622570.2107-100000@sorbus.navaho> <200108151713.f7FHDg0n013420@webber.adilger.int> <20010817171834.A24850@thunk.org>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 998242279 26320 128.32.45.153 (19 Aug 2001 17:31:19 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 19 Aug 2001 17:31:19 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso  wrote:
>On Wed, Aug 15, 2001 at 11:13:41AM -0600, Andreas Dilger wrote:
>> Note that network interrupts do NOT normally contribute to the entropy
>> pool.  This is because of the _very_theoretical_ possibility that an
>> attacker can "control" the network traffic to such a precise extent as
>> to flush or otherwise contaminate the entropy from the pool [...]
>
>That's not the only attack, actually.  The much simpler attack pathis
>for an attack to **observe** the network traffic to such a precise
>extent as to be able to guess what the entropy numbers are that are
>going into the pool.  (Think: FBI's Carnivore).

Right.  Ted's observation says that network traffic should not
contribute to the entropy *count*.  However, it is probably still
useful to add network traffic timings to the pool (without bumping
up the count).  Adding extra traffic to the pool should not hurt,
unless the cryptographic hash function is insecure (in which case
you've probably got worse problems than chosen-timing attacks).
