Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275685AbRJAWvB>; Mon, 1 Oct 2001 18:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275684AbRJAWuw>; Mon, 1 Oct 2001 18:50:52 -0400
Received: from smtp3.libero.it ([193.70.192.53]:56810 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S275685AbRJAWuq>;
	Mon, 1 Oct 2001 18:50:46 -0400
Date: Tue, 2 Oct 2001 00:43:16 +0200
From: antirez <antirez@invece.org>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Andreas Dilger <adilger@turbolabs.com>,
        Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>,
        linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: /dev/random entropy calculations broken?
Message-ID: <20011002004316.D2155@blu>
Reply-To: antirez <antirez@invece.org>
In-Reply-To: <20011001105927.A22795@turbolinux.com> <45266246.1001976925@[195.224.237.69]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <45266246.1001976925@[195.224.237.69]>; from linux-kernel@alex.org.uk on Mon, Oct 01, 2001 at 10:55:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2001 at 10:55:26PM +0100, Alex Bligh - linux-kernel wrote:
> However, unless one is worried about someone having broken
> SHA-1 OR one is worried about annoying blocking behavour
> on read(), I'm not convinced the entropy calculation is
> doing anything useful anyway.

I think the /dev/random /dev/urandom solution is perfect
from this point of view. Using /dev/random you can get
random number that are secure _even_ if tomorrow SHA1 will
be broken at the cost of a very slow generation.
Or you may trust SHA1 (or some other crypto primitive) to
avoid to collect too much entropy to generate the output.
Probably real world applications should use
/dev/urandom, assuming it's properly designed, i.e. the
internal state is changed once there is enough entropy
to create a new unguessable key, the entropy isn't
overstimated, and so on.

BTW I agree, instead to create a key being paranoid about
the SHA1 security it's better to double check if the
entropy source is ok. For example the linux PRNG used
to collect a lot of entropy bits from the keyboard
auto-repeat aaaaaaaaaaaaaa ...
It's useless to try to collect enough entropy (and maybe
overstimating it) to produce an output secure against
SHA1 possible weakness (i.e. totally generated with
entropy bits). It's probably better a more conservative
approach in the entropy collection and to use a belived secure
crypto primitive to produce the PRNG output.

After all, unless you are using a one-time pad probably
the key generated with /dev/random will be used with
the crypto algorithms you refused to trust.

-- 
Salvatore Sanfilippo <antirez@invece.org>
http://www.kyuzz.org/antirez
finger antirez@tella.alicom.com for PGP key
28 52 F5 4A 49 65 34 29 - 1D 1B F6 DA 24 C7 12 BF
