Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270124AbRHGHe4>; Tue, 7 Aug 2001 03:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270126AbRHGHex>; Tue, 7 Aug 2001 03:34:53 -0400
Received: from CS.BU.EDU ([128.197.10.2]:8360 "EHLO cs.bu.edu")
	by vger.kernel.org with ESMTP id <S270124AbRHGHeo>;
	Tue, 7 Aug 2001 03:34:44 -0400
From: Jeffrey Considine <jconsidi@cs.bu.edu>
Message-Id: <200108070734.f777YpE08994@csb.bu.edu>
Subject: Re: Encrypted Swap
To: johnpol@2ka.mipt.ru
Date: Tue, 7 Aug 2001 03:34:51 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200108070705.f7775xl27094@www.2ka.mipt.ru> from "Evgeny Polyakov" at Aug 07, 2001 11:08:38 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

The key can be locked into memory. Locking just the key is better than
running setuid root to lock the whole application.

> RM> I think the point you are missing is that encrypted swap only needs to be
> RM> accessible for one power cycle.  Thus the computer can generate a key at
> No, computer can not do this.
> This will do some program,and this program is not crypted.
> Yes?
> We disassemle this program, get algorithm and regenerate a key in evil machine?
> Am i wrong?

Waiting for entropy (mentionned by RM I think) would take care of
this. However, I imagine it takes a while to build up enough random
bits, especially if no users are logged on and the network isn't
up. Stalling for entropy before setting up the swap partition is
probably not a good idea. Switching keys from predictable to really
random or delaying encryption sounds expensive and/or messy and would
leave a small window right after booting where the swap file could be
decrypted relatively easily.

Perhaps a cheaper alternative that wouldn't really slow down most
applications would be to add a flag set by a system call toggling
whether the page was encrypted in the swap file. That way most
applications don't see a performance difference. If the flag was
inheritable, the security paranoid could use a shell or wrapper to set
it and run everything through that.

jef
