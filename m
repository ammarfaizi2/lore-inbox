Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130374AbRACKKo>; Wed, 3 Jan 2001 05:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130427AbRACKKd>; Wed, 3 Jan 2001 05:10:33 -0500
Received: from pump3.york.ac.uk ([144.32.128.131]:58023 "EHLO pump3.york.ac.uk")
	by vger.kernel.org with ESMTP id <S130374AbRACKKY>;
	Wed, 3 Jan 2001 05:10:24 -0500
Message-ID: <3A52F33D.2050105@demeter.cs.york.ac.uk>
Date: Wed, 03 Jan 2001 09:39:09 +0000
From: Michel Salim <mas118@demeter.cs.york.ac.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.13 i686; en-US; 0.6) Gecko/20001205
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: LKML <linux-kernel@vger.kernel.org>, dhinds@valinux.com
Subject: Re: i82365 PCI-PCMCIA bridge still not working in 2.4.0-test11
In-Reply-To: <3A1C6D4C.7060306@demeter.cs.york.ac.uk>  <3A1AC075.4020506@cs.york.ac.uk> <4186.974889923@redhat.com> <11299.974975638@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manually inputting i365_base=0x1030 when loading the module results in 
the same freeze - nothing works at all, had to do a full hardware reset. 
This is on the latest 2.4.0-prerelease...

David, any luck on your side? Sorry for the long absence, been a bit 
busy and then I went on holiday.

Any chance it's due to IRQ sharing? Since I've been struggling to use my 
PCMCIA modem under kernel 2.2.x too... pcmcia-cs detects it and minicom 
can dial using it but nothing else... :( the PCMCIA controller is on IRQ 
11, same as my video card. Haven't tried swapping it since the cables 
are a mess to reattach :p

A belated Happy New Year,

Michel
David Woodhouse wrote:

> mas118@demeter.cs.york.ac.uk said:
> 
>> Thanks for the patch... but it does not quite work. It applies
>> cleanly,  but upon booting the patched kernel, the machine freezes
>> completely upon  PCMCIA initialisation (it got to the point where the
>> init script said  'Loading modules' then nothing). CTRL+ALT+DEL does
>> not work, either. 
> 
> 
> Hmmm.
> 
> mas118@demeter.cs.york.ac.uk said:
> 
>>  Anyone got a clue? Would love to help debug this if someone would
>> just  walk me through it.
> 
> 
> I think you may have to wait until I next get left alone in the house with 
> the opportunity to gut my girlfriend's machine and stick a PCMCIA 
> controller in it, unless you're willing to work on this yourself.
> 
> What I've done so far is to refer to the current i82365 code from David 
> Hinds' standalone package, and put back into Linus' version all the 
> non-CardBus CONFIG_PCI code which deals with PCI-PCMCIA bridges. As some 
> changes have been made to the pcmcia core in David's version since the 
> merge, that's not trivial, although it's quite simple.
> 
> I probably missed something - probably a change which isn't in CONFIG_PCI 
> ifdefs. Did it print anything before dying? Does it die if you haven't got 
> any cards present when it initialises? Does it die if you ensure it's 
> polling the socket for status changes and doesn't register the interrupt?
> 
> Does it work with the standard driver in -test11 if you specify the correct
> i365_base= parameter as obtained from lspci?
> 
> If it does work with the current driver, I'm half inclined to leave it 
> alone until 2.5 when we can re-sync the pcmcia core and hopefully then 
> it'll 'just work' if we drop in the standalone driver, perhaps with the 
> cardbus-specific parts stripped out.
> 
> --
> dwmw2



-- 
Michèl Alexandre Salim

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
