Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270121AbRHGHdQ>; Tue, 7 Aug 2001 03:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270122AbRHGHc4>; Tue, 7 Aug 2001 03:32:56 -0400
Received: from [195.157.147.30] ([195.157.147.30]:8201 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S270121AbRHGHcx>; Tue, 7 Aug 2001 03:32:53 -0400
Date: Tue, 7 Aug 2001 08:23:24 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Evgeny Polyakov <johnpol@2ka.mipt.ru>
Cc: Ryan Mack <rmack@mackman.net>, linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
Message-ID: <20010807082324.C9202@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Evgeny Polyakov <johnpol@2ka.mipt.ru>,
	Ryan Mack <rmack@mackman.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200108070624.f776Ofl21096@www.2ka.mipt.ru> <Pine.LNX.4.33.0108062338130.5491-100000@mackman.net> <200108070705.f7775xl27094@www.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108070705.f7775xl27094@www.2ka.mipt.ru>; from johnpol@2ka.mipt.ru on Tue, Aug 07, 2001 at 11:08:38AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2001 at 11:08:38AM +0400, Evgeny Polyakov wrote:
> Hello.
> 
> On Mon, 6 Aug 2001 23:45:33 -0700 (PDT)
> Ryan Mack <rmack@mackman.net> wrote:
> 
> >> Hmmm, let us suppose, that i copy your crypted partition per bit to my
> >> disk.
> >> After it I will disassemble your decrypt programm and will find a key....
> >>
> >> In any case, if anyone have crypted data, he MUST decrypt them.
> >> And for it he MUST have some key.
> >> If this is a software key, it MUST NOT be encrypted( it's obviously,
> >> becouse in other case, what will decrypt this key?) and anyone, who have
> >> PHYSICAL access to the machine, can get this key.
> >> Am I wrong?
> 
> RM> I think the point you are missing is that encrypted swap only needs to be
> RM> accessible for one power cycle.  Thus the computer can generate a key at
> No, computer can not do this.

This is nonsense.  Of course the computer can do this.  This is exactly what we
already do for TCP sequence numbers, disk UUIDS, and many other things.
Granted, we need a little more initial entropy, but the principle has already
been established.

Remember that this is not the same as a crypted filesystem in that no user
(even root) need ever have any access to the key.  That's important.  Because
the swapspace is essentially wiped at powerup, the system can happily gen a new
key every boot, crypt away and never let the users know the key at all.

> This will do some program,and this program is not crypted.
> Yes?

So what?  The program can utilise entropy present in the system by reading from
/dev/random and generate a cryptographically-strong key.  Just because you know
my algorithm doesn't mean you've broken my code.  That is the essense of proper
cryptography- that knowlege of the algo doesn't break it.

> We disassemle this program, get algorithm and regenerate a key in evil machine?
> Am i wrong?

Of course you are wrong.  Try this pseudo-code:

1)READ X BYTES FROM STRONG RANDOM SOURCE
2)KEEP IT IN MEMORY AND USE IT AS KEY
3)USE STRONG SYMMETRICAL CYPHER TO ENCRYPT WRITES TO SWAP AND DECRYPT WRITES FROM 
SWAP

Right, now you, (as black hat) have physically stolen my machine.  Remember
that in order to do that you need to turn the power off.  You know my
algorithim for key generation: how do you recover the key?

You can't, because the key only ever lived in RAM and that RAM has been
discharged.

Can you get my key by looking at the algorithm?  No, of course you can't.

Can you get the key by looking at the swap space?  No you can't unless he can
reverse the encryption algorithm.  I assuming we're not going to use ROT13 here.

Can you recover the contents of the swap without the key?  No you can't unless
the encryption algo is broken.

> 
> P.S. off-topic What algorithm do you want to use to regenerate a key for once crypted data?
> I don't know anyone, or i can't understand your point of view.

You don't.  Swap is only good for one power-cycle anyway, regardless of
encryption.  As such, the legitimate user won't ever need to regenerate the
key.  Since black hat can't root, they can't get the key (assuming physical
security is OK), and after reboot they can't recover the contents of the swap
space because it is encrypted.  So even if they nick the machine/drive/whatever
they can't get the swap contents after the power has been cycled and the key
lost.

Sean
