Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSLIH2V>; Mon, 9 Dec 2002 02:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbSLIH2V>; Mon, 9 Dec 2002 02:28:21 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:5644 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262838AbSLIH2U>; Mon, 9 Dec 2002 02:28:20 -0500
Date: Mon, 9 Dec 2002 05:35:56 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bit testing nervousness...
Message-ID: <20021209073555.GA17067@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <20021209035400.GA20470@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021209035400.GA20470@gtf.org>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Dec 08, 2002 at 10:54:00PM -0500, Jeff Garzik escreveu:
> Hey...
> 
> WRT all these test_bit()/set_bit() cleanups.   I am a bit nervous about
> these changes that are coming in...

lets try to calm you then 8)
 
> When I see types change from "u8" or "u32" to "long" just to make
> <foo>_bit() work, that really makes me think that cleanup is wrong.  I
> haven't looked closely at the recent set_bit() cleanups yet, but I am
> willing to bet that at least some of them are wrongly changing the size
> of a variable's type.
> 
> My preference would be to _eliminate_ the set_bit call and simply
> open-code the bitop, i.e.
> 	set_bit(bitnum, &foo);
> become
> 	foo |= (1 << bitnum);

I think this can be a good idea, but in some cases, like the set_rx_mode
routines (multicast) it depends on the conversion to long, so those ones
should be dealt with in a different fashion, BTW, I haven't touched those
ones.
 	
> Really, for each cleanup, you need to look hard at the change and
> see if <foo>_bit() is being used for atomicity reasons or simply
> programmer preference.  (and other issues like endian issues)  The
> latter can easily be changed to open-coding.
> 
> Disclaimer, my argument is null and void if each change has been closely
> studied and is really correct :)  However I'm guessing we all are only
> glancing at the changes :)

Lets see:

o drivers/atm/ambassador.c (ChangeSet@1.797.108.1)
o drivers/atm/horizon.c (ChangeSet@1.797.108.2)
o drivers/char/sx.c (ChangeSet@1.797.108.3)
o drivers/net/lance.c (ChangeSet@1.831.1.15)
o drivers/net/ni65.c (ChangeSet@1.797.108.8)
o drivers/net/dl2k.c (ChangeSet@1.831.1.34, ChangeSet@1.831.1.32)
o drivers/net/wan/sdla_fr.c (ChangeSet@1.831.1.41)
o include/linux/if_wanpipe_common.h (ChangeSet@1.831.1.42)

only sets/resets/tests a few bits, safe, no code depends on it changing
its size from 32 to 64 bits.

Humm, I was expecting a second type of changes, but I think all are safe,
even on a second glance. :-)

- Arnaldo
