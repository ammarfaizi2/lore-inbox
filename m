Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265200AbUD3Ni1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbUD3Ni1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 09:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265199AbUD3Ni0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 09:38:26 -0400
Received: from mail2.webmessenger.it ([193.70.193.55]:63690 "EHLO
	mail1a.webmessenger.it") by vger.kernel.org with ESMTP
	id S265200AbUD3NiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 09:38:12 -0400
Message-ID: <409256A4.5080607@copeca.dsnet.it>
Date: Fri, 30 Apr 2004 15:37:40 +0200
From: Giuliano Colla <copeca@copeca.dsnet.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; it-IT; rv:1.5) Gecko/20031007
X-Accept-Language: it, en, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       hsflinux@lists.mbsi.ca, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [hsflinux] [PATCH] Blacklist binary-only modules lying about
 their license
References: <408DC0E0.7090500@gmx.net> <40914C35.1030802@copeca.dsnet.it> <Pine.LNX.4.58.0404291404100.1629@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0404291404100.1629@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds ha scritto:

>On Thu, 29 Apr 2004, Giuliano Colla wrote:
>  
>
>>Let's try not to be ridiculous, please.
>>    
>>
>
>It's not abotu being ridiculous. It's about honoring peoples copyrights.
>
>  
>
On that ground you're correct.

>>As an end user, if I buy a full fledged modem, I get some amount of 
>>proprietary, non GPL, code  which executes within the board or the 
>>PCMCIA card of the modem. The GPL driver may even support the 
>>functionality of downloading a new version of *proprietary* code into 
>>the flash Eprom of the device. The GPL linux driver interfaces with it, 
>>and all is kosher.
>>    
>>
>
>Indeed. Everything is kosher, because the other piece of hardware and 
>software has _nothing_ to do with the kernel. It's not linked into it, it 
>cannot reasonably corrupt internal kernel data structures with random 
>pointer bugs, and in general you can think of firmware as part of the 
>_hardware_, not the software of the machine.
>
>  
>
>>On the other hand, I have the misfortune of being stuck with a 
>>soft-modem, roughly the *same* proprietary code is provided as a binary 
>>file, and a linux driver (source provided) interfaces with it. In that 
>>case the kernel is flagged as "tainted".
>>    
>>
>
>It is flagged as tainted, because your argument that it is "the same code" 
>is totally BOGUS AND UNTRUE!
>
>In the binary kernel module case, a bug in the code corrupts random data 
>structures, or accesses kernel internals without holding the proper locks, 
>or does a million other things wrong, BECAUSE A KERNEL MODULE IS VERY 
>INTIMATELY LINKED WITH THE KERNEL.
>
>A kernel module is _not_ a separate work, and can in _no_ way be seen as 
>"part of the hardware". It's very much a part of the _kernel_. And the 
>kernel developers require that such code be GPL'd so that it can be fixed, 
>or if there's a valid argument that it's not a derived work and not GPL'd, 
>then the kernel developers who have to support the end result mess most 
>definitely do need to know about the taint.
>
>You are not the first (and sadly, you likely won't be the last) person to 
>equate binary kernel modules with binary firmware. And I tell you that 
>such a comparison is ABSOLUTE CRAPOLA. There's a damn big difference 
>between running firmware on another chip behind a PCI bus, and linking 
>into the kernel directly.
>
>And if you don't see that difference, then you are either terminally 
>stupid, or you have some ulterior reason to claim that they are the same 
>case even though they clearly are NOT.
>
>  
>
O.K. you're right. By a strictly technical point of view I goofed.

But please do consider a different perspective.

I'm an end user.
I download a damn Linuxant driver because the manufacturer of the laptop 
I own has seen fit to use a Conexant chipset.
In order to do that I must:
a) Pay a (small) sum.
b) Accept a Microsoft-like license agreement.
If at that point I haven't realized that I'm not getting a fully GPL'd 
software I'm really terminally stupid as you kindly suggest.

If I'm not technically skilled, I don't know how much of the stuff I 
downloaded executes in kernel space and how much in user's space. But, 
as an end user, I don't care too much, because bogus code executing in 
user space (with root privileges) cannot affect kernel stability, but 
can make my system completely unusable as far as I'm concerned (as an 
end user, I stress).

The big difference you mention exist when you *debug* the damn thing 
(which of course is your concern), but the difference fades out when you 
*use* it (which is my concern).

However, if I'm not terminally stupid, I will never think of addressing 
to kernel people in order to fix problems arising from or after loading 
the driver, and associated utilities, even if lsmod doesn't show 
"tainted" modules. Kernel people shouldn't even consider supporting the 
resulting mess.

That said, I'd like to explain what made me react to the announcement 
posted.

Linuxant have figured a Microsoft-like brute force hardware detection 
mechanism: they attempt to load *all* drivers, and only the one which 
fits with actual hardware gets loaded. Of course the user gets tons of 
error messages. They've tried to reduce the amount of error message by 
using the pathetic workaround of a \0 after the GPL string. All of that 
is much on Microsoft style, i.e. to find a workaround instead of a solution.

But I didn't appreciate that the reaction to that mess has been also on 
Microsoft style.
The reaction has been:

a) a workaround of the workaround (if you put a \0, I'll detect the 
Linuxant string)

b) a lie (the /GPL directory is empty).

This appears to me the beginning of a process which may lead to further 
workarounds, and which will waste time and energies which may be 
addressed to more useful issues.

A more relaxed reaction of the sort:
"Dear Linuxant people, if you're unable to work out an acceptable 
hardware detection mechanism, why don't you address your line toward 
interesting opportunities in the agriculture field, instead of messing 
up with GPL license strings?"
would have been in my opinion much more appropriate.

But if you really insist on your policy, try at least to avoid Microsoft 
style, and upon recognition of the Linuxant/Conexant string, flag the 
module not as "tainted" but rather as "crappy", or "brain-damaged".

<..>

>It has absolutely nothing to do with religion.
>
>  
>
It shouldn't. But it's not good to convey even remotely this feeling.  
I'm proud of being, in my limited capacities, a member of the Open 
Source community. I want to continue to be proud of it. If I detect 
something that doesn't sound right, I feel it necessary to point it out. 
Nothing makes me happier than being proved wrong.

-- 
Ing. Giuliano Colla
Direttore Tecnico
Copeca srl
Bologna Italy




