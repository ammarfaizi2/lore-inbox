Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVBJNnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVBJNnq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 08:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVBJNnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 08:43:45 -0500
Received: from mx1.elte.hu ([157.181.1.137]:60324 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262120AbVBJNnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 08:43:33 -0500
Date: Thu, 10 Feb 2005 14:43:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: pageexec@freemail.hu
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: the "Turing Attack" (was: Sabotaged PaXtest)
Message-ID: <20050210134314.GA4146@elte.hu>
References: <42080689.15768.1B0C5E5F@localhost> <42093CC7.5086.1FC83D3E@localhost> <20050208164815.GA9903@elte.hu> <20050208220851.GA23687@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208220851.GA23687@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* pageexec@freemail.hu <pageexec@freemail.hu> wrote:

> the bigger problem is however that you're once again fixing the
> symptoms, instead of the underlying problem - not the correct
> approach/mindset.

i'll change my approach/mindset when it is proven that "the underlying
problem" can be solved. (in a deterministic fashion)

in case you dont accept the threat model i outlined (the
[almost-Universal] Turing Machine approach), here are the same
fundamental arguments, applied to the PaX threat model.

first about the basic threat itself: it comes from some sort of memory
overwrite condition that an attacker can control - we assume the
worst-case, that the attacker has arbitrary read/write access to the
writable portions of the attacked task's address space. [this threat
arises out of some sort of memory overwrite flaw most of the time.]

you are splitting the possible effects of a given specific threat into 3
categories:

   (1) introduce/execute arbitrary [native] code
   (2) execute existing code out of original program order
   (3) execute existing code in original program order with arbitrary data

then you are building defenses against each category. You say that PaX
covers (1) deterministically, while exec-shield only adds probabilistic
defenses (which i agree with). You furthermore say (in your docs) that
PaX (currently) offers probabilistic defenses against (2) and (3). You
furthermore document it that (2) and (3) can likely only be
probabilistically defended against.

i hope we are in agreement so far, and here comes the point where i
believe our opinion diverges: i say that if _any_ aspect of a given
specific threat is handled in a probabilistic way, the whole defense
mechanism is still only probabilistic!

in other words: unless you have a clear plan to turn PaX into a
deterministic defense, for a specific threat outlined above, it is just
as probabilistic (clearly with a better entropy) as exec-shield.

PaX cannot be a 'little bit pregnant'. (you might argue that exec-shield
is in the 6th month, but that does not change the fundamental
end-result: a child will be born ;-)

you cannot just isolate a given attack type ('exploit class') and call
PaX deterministic and trumpet a security guarantee - since what makes
sense from a security guarantee point of view is the actions of the
*attacker*: _can_ the attacker mount a successful attack or not, given a
specific threat? If he can never mount a successful attack (using a
specific flaw) then the defense is deterministic. If there is an exploit
class that can be successful then the defense is probabilistic. (or
nonexistent)

Defending only against a class of exploits (applied to the specific
threat) will force attackers towards the remaining areas - but if those
remaining areas cannot be defended against for sure, then you cannot say
that PaX offers a security guarantee against that specific threat.
Talking about security guarantees against 'sub-threats' does not make
sense because attackers dont do us the favor of using only one class of
attacks.

and once we are in the land of probabilistic defenses, it's the weakest
link that matters. It might make sense to handle the 'native code
injection' portion of the threat in a deterministic way, but only as a
tool to drive attackers towards vectors that are less probable, and it
is not in any way giving any security guarantee.

	Ingo
