Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317582AbSIIRKy>; Mon, 9 Sep 2002 13:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317590AbSIIRKy>; Mon, 9 Sep 2002 13:10:54 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:51210 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S317582AbSIIRKx>; Mon, 9 Sep 2002 13:10:53 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Date: 9 Sep 2002 16:58:50 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <alik0a$70c$1@abraham.cs.berkeley.edu>
References: <1029760150.19376.14.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0209072328240.21724-100000@redshift.mimosa.com> <alg3ct$pru$1@abraham.cs.berkeley.edu> <20020909165303.GA31597@waste.org>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1031590730 7180 128.32.153.211 (9 Sep 2002 16:58:50 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 9 Sep 2002 16:58:50 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron  wrote:
>This argument assumes you have knowledge of the inner workings of this
>step. To the best of my knowledge no one outside of Intel has cracked
>open this chip and actually tested that this black box _does what it
>says its doing_. This is what is meant by auditing.

Yes, I agree.  The tests are only useful if you trust that Intel is
not maliciously out to get you.  For instance, they are useful if you
believe that Intel is well-intentioned but fallible (which strikes me
as likely to be the right threat model for most ordinary Linux users).

Whether you like it or not, you're already trusting Intel, if you're
using an Intel chip.  If Intel were malicious and out to get you, they
could have put a backdoor in the chip.  And a RNG is *much* easier to
reverse-engineer and audit than an entire CPU, so it would probably be
riskier for Intel to hide a backdoor in the RNG than in, say, the CPU.

>What right-thinking paranoid would place any faith in an analysis with
>an Intel copyright? This is practically marketing fluff anyway.

Marketing fluff?  I take it that's a joke: I wish the marketing fluff
I get had this much technical content and documented its experimental
procedure like this.

Anyway, I place some trust in the analysis not because of who owns its
copyright (I mean, come on) but because it has Paul Kocher's name on it.
His reputation is excellent.  He is one of the top two or three in the
business.  I know him personally, and I don't believe he would place
his stamp of approval on a RNG he knows to be broken.

Obviously Intel paid for this analysis to be performed -- that's how the
security consulting business works -- but that doesn't mean Intel paid
for preferential, biased treatment.  Frankly, Intel probably couldn't
afford it.  I trust Paul Kocher to do an impartial, independent analysis,
because I've seen him do it before.  Intel probably couldn't pay him
enough to make up for the amount of money he'd lose if he were caught
"cheating".

Again, this review is no guarantee.  There are still lots of things that
could go wrong.  Maybe there is a flaw that Paul Kocher overlooked.
Maybe there is a secret backdoor.  Maybe Intel changed the design
of their RNG since the review and inadvertently introduced a defect.
But Kocher's review raises the level of assurance we can have.

Bottom line: I claim that the Intel RNG is better studied than most
other entropy sources available on the typical PC.  I challenge you to
find a review like this for, say, soundcard entropy.

>But we can actually audit the former and decided whether to trust it.

I'm not sure what makes a soundcard any easier to audit than the Intel
RNG.  Our soundcards could have a secret hardware backdoor hidden in
them, too.

Anyway, as I said in my previous email, you shouldn't be using only
a single entropy source in any case.  Use both the soundcard and the
Intel RNG.  They have different failure modes, and the risk that they
both fail is smaller than the risk that just one will fail.

And, if you're a government agency protecting classified information,
you probably have other RNG sources at your disposal and would be unlikely
to use the Linux RNG in any case.
