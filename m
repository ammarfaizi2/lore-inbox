Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbQLRJxM>; Mon, 18 Dec 2000 04:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbQLRJxB>; Mon, 18 Dec 2000 04:53:01 -0500
Received: from jabberwock.ucw.cz ([62.168.0.131]:57862 "EHLO jabberwock.ucw.cz")
	by vger.kernel.org with ESMTP id <S129737AbQLRJwu>;
	Mon, 18 Dec 2000 04:52:50 -0500
Date: Mon, 18 Dec 2000 10:22:18 +0100
From: Martin Mares <mj@suse.cz>
To: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/random: really secure?
Message-ID: <20001218102218.A428@albireo.ucw.cz>
In-Reply-To: <20001217225057.A8897@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001217225057.A8897@atrey.karlin.mff.cuni.cz>; from clock@atrey.karlin.mff.cuni.cz on Sun, Dec 17, 2000 at 10:50:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I noticed peculiarities in the behaviour of the delta-delta-3 system for
> entropy estimation in the random.c code./ When I hold right alt or control, I
> get about 8 bits of entropy per repeat fro the /dev/random which is
> overestimated. I think the real entropy is 0 bits because it is absolutely
> deterministic when the interrupt comes. Am I right or is there any hidden
> magic source of entropy in this case?

It isn't _absolutely_ deterministic (see the other replies about clock skew), but
I agree it isn't a reliable source of entropy. This is the reason why
add_keyboard_randomness() tries not to count autorepeated keys, but unfortunately
it's buggy since it doesn't work with keys producing multiple scan codes per
repeat. It would be probably better to make it work with key codes instead
of scan codes.
 
> Right shift, left alt, ctrl and shift make 4 bits per repeat.

Did you really test it?  I bet they don't.

> When I have a server where n blobk read, keyboard and mouse events occur
> (everything is cached within huge amount of semiconductor RAM), the /dev/random
> depends solely on the network packets. These can be manipulated and their
> leading edge precisely sniffed.

How precisely? Remember that at least on the ia32, you need to guess the timing
down to one CPU clock cycle.

> I think here exists a severe risk of compromise. Am I right?

Even if you were able to predict all entropy sources, to predict the generated
random numbers you would need to invert the cryptographic hash used there.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
You can't do that in horizontal mode!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
