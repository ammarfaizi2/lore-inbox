Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290423AbSBNG6Y>; Thu, 14 Feb 2002 01:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290470AbSBNG6O>; Thu, 14 Feb 2002 01:58:14 -0500
Received: from vitelus.com ([64.81.243.207]:40197 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S290423AbSBNG56>;
	Thu, 14 Feb 2002 01:57:58 -0500
Date: Wed, 13 Feb 2002 22:57:39 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Rob Landley <landley@trommello.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: ssh primer (was Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4))
Message-ID: <20020214065739.GA26224@vitelus.com>
In-Reply-To: <E16ZhzF-0000ST-00@gondolin.me.apana.org.au> <3C65CBDE.A9B60BBD@mandrakesoft.com> <20020213171306.GA15924@vitelus.com> <20020214002205.VBHJ21911.femail34.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020214002205.VBHJ21911.femail34.sdc1.sfba.home.com@there>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 07:22:57PM -0500, Rob Landley wrote:
> In terms of brute forcing the key, the passphrase adds a fairly trivial 
> number of bits to the key.  It's not "far" easer, an 8 character mixed case 
> nonsense password with numbers and punctuation mixed in is still less than 6 
> bits per character, or at best an extra 48 bits.  You can select a 1024 bit 
> key if you want to be really really paranoid.

I agree that it isn't worth it.

I assume that Jeff didn't understand the principles behind public key
cryptography that SSH uses which keep communications secure unless the
private key is compromised (and the private key should never leave
client machine). When you have a passphrase, you encrypt this private
key with a hash of it. Not having a passphrase removes this layer of
security, but if you include the passphrase in a script for automatic
use you're undoing any advantage that a passphrase gives you in the
first place.

In short, to compromise a private key without access to that key
(which presumably only you would have if the key was on your system,
and you must assume that if someone could access your private key they
could access any passphrase you were storing in a script to facilitate
automatic use of it), you'd have to either have unheard of amounts of
computational power and a few millenia on your hands, or come across a
mathematical breakthrough. I certainly hope that Mr. Garzik has not
broken public key cryptography!

Note that you can't compare public key bits to passphrase bits (which
are more like symmetric key bits). You probably know this.

> Not that it's worth it.  Keys get exponentially more difficult to brute force 
> as the key length increases.  I read part of a book a long time ago (might 
> have been called "applied cryptography") that figured out that if you could 
> build a perfectly efficient computer that could do 1 bit's worth of 
> calculation with the the amount of energy in the minimal electron state 
> transition in a hydrogen atom, and you built a dyson sphere around the sun to 
> capture its entire energy output for the however many billion years its 
> expected to last, you wouldn't even brute-force exhaust a relatively small 
> keyspace (128 bits?  256 bits?  Something like that).

That was Applied Cryptography. I believe he said that the energy
output of a supernova was insufficient to cycle a counter through
about 2^190, based on accepted thermodynamic principles and data. Of
course, this makes brute force of something like a 256 bit symmetric
key completely infeasible and bounded by physical law. Not that 128
bits is very shabby, but it only takes a few billion years of all the
current computing power on earth to brute force something like that.
