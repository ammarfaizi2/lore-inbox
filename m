Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271828AbRHUTVM>; Tue, 21 Aug 2001 15:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271827AbRHUTVB>; Tue, 21 Aug 2001 15:21:01 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:23017 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271828AbRHUTUm>;
	Tue, 21 Aug 2001 15:20:42 -0400
Date: Tue, 21 Aug 2001 20:20:50 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: /dev/random in 2.4.6
Message-ID: <2354423401.998425250@[10.132.112.53]>
In-Reply-To: <Pine.LNX.4.30.0108211258080.13373-100000@waste.org>
In-Reply-To: <Pine.LNX.4.30.0108211258080.13373-100000@waste.org>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver,

> Ok, you're going to assume that the 160-bit SHA hash with lots and lots
> and lots of mixing is more vulnerable than the IDEA or Blowfish or 3DES
> that you're using for your actual encryption?

Only because if not, this argument is irrelevant, in that if SHA-1
is not broken and can never be, then there is no point in the entropy
measurement and blocking behaviour at all, and in this case, Robert's
patch does no harm whatsoever.

> How about simply adding possible entropy from the network but not
> accounting for it? /dev/urandom then becomes as strong as the proposed
> /dev/random (up to the load that /dev/random would allow), while
> /dev/random isn't weakened.

Perhaps I'm missing something, but /dev/urandom is only weaker than
/dev/random NOW if SHA-1 is cracked (if not, the two are identical
in 'strength'). And, in the extremely theoretical case that
SHA-1 is crackable (perhaps with an attack that takes many days),
then wanting to have gathered entropy before reading is useful.

As you point out (above), and as did David, SHA-1 being cracked
is a remote possibility in the extreme. But this scenario is the
only one where Robert's patch could make a conceivable difference.
If SHA-1 is invulnerable, then why argue against Robert's patch
which merely stops some applications from not working on some machines.

But people obviously do have concerns about the reversibility of SHA-1,
even if only at a very theoretical level, or they wouldn't be
spending all this time arguing about the importance of metering entropy.

Adding entropy from the network and not accounting for it is probably
better than nothing (as it makes the seeding problem better).

>> Correct, and it's quite possible it should be contributing less bits
>> than 12 if the option is turned on. However, a better response would
>> be to fix the timers to be more accurate :-)
>
> We're already using cycle counters - do you propose being more accurate
> than that?

I propose not using Jiffies on machines other than some i386's, and
not exposing /proc/interrupts 644 which reduces the attack space
hugely.

>> I agree with your point that Robert's patch /could/ taint /dev/random,
>> but only if you switch it on!
>
> As it stands, it does. Assuming a 1GHz processor and hitting the maximum
> 12 bits of entropy per interrupt, we only need to guess the interrupt
> timing to within 4us - probably not hard. As I've pointed out, it's not
> hard to send our own apparently random packets to open up that window.

IF you can observe packets, and IF you turn the config option
on against advice [1] THEN the strength of /dev/random
will be tainted IF and ONLY IF SHA-1 is breakable (in which
case, as you point out, all sorts of other things break anyway).
I consider this an acceptable risk.

[1] against the advice of a config option which should read
'DO NOT SWITCH THIS ON IF YOU BELIEVE THERE IS ANY CHANCE OF
YOUR NETWORK PACKETS BEING OBSERVABLE AND YOU ARE WORRIED
ABOUT THE SECURITY OF SHA-1' (but the same applies btw using k/b
interrupts with wireless keyboards).

--
Alex Bligh
