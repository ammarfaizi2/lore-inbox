Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVAZOjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVAZOjT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 09:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVAZOjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 09:39:19 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:30460 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262312AbVAZOjE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 09:39:04 -0500
Date: Wed, 26 Jan 2005 15:34:14 +0100 (CET)
To: johnpol@2ka.mipt.ru
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <waZNwjBp.1106750054.2006670.khali@localhost>
In-Reply-To: <1106736907.5257.134.camel@uganda>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Greg KH" <greg@kroah.com>, "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Evgeniy,

> I presented the code.
> Several times in special mail list.

That's true. Except that the second time (at least) you didn't find
anyone to review it. Also note that your patches are about superio, gpio
and now access bus. The list is dedicated to hardware monitoring. This
is no exact match, although it happens that some superio chips include
hardware monitoring logical devices. So I reviewed the part I think I
could help with, and skipped the rest (and I did tell the you, and the
list, that I had).

> Only problem that it was not sent to lkml, where there are 
> too many noise and flood. That is why while digging through it several 
> years ago I decided to drop this mail list.

I agree that there is a heavy traffic on LKML - I am not subscribed
myself just because of that. However, when one introduces a completely
new subsystem, it definitely needs review by folks that have way more
knowledge about the kernel internals than I do - expecially about the
(bus) driver model.

> I do not understand you, what are you trying to say? Waht is wrong?
> I wrote the code.
> I presented it.
> I presented it again.
> I presented it yeat another again.
>
> First time people answered, then - not.

OK, blame me for having a day job, a girlfriend and a family. Blame me
for not having the necessary time and knowledge to review your code.

And then think about it again. Maybe you did not present it to the right
person(s). Maybe you did not present it in the correct form. Maybe you
didn't properly explain what problem you were trying to solve - and
failed to catch people's attention because of that. And maybe you
should not have ignored some of my comments - and others'. I would
invite you to read your own recent posts to the LKML again. Most
objections you have received about your code - some of which were so
blantantly valid (several drivers with the same name is fine, no
kidding) - you first denied that there were any problem, then grumbled,
then accepted to change but just not to make any trouble - not because
you were wrong. You are not going anywhere here with this attitude.

Sure, we, kernel developers as a whole, lack time to properly review all
the code that is sent to us. Even me, and I probably receive one
hundredth of what Greg, Andrew or Linus receive. And now what? That's
the way it is and we (and you) have to live with it. If you want the
situation to improve, you can volunteer to review some code. Andrew's
broken-out directories and LKML are full of patches that need review. Or
pick one subsystem and track the patches applied to it. Really, do not
hesitate to help. You certainly will learn much about kernel code review
by doing so, and your own submissions are likely to be significantly
better thanks to that. My story exactly.

> I ask for inclusion. It is included, and ohh now people recall, 
> that they wanted to complain.

What other choice do they have at this point? Ignore or complain. I
definitely prefer them to complain if they have a reason to - and the
same would apply if it was my code and not yours.

Note that I don't blame Greg for pushing the code into Andrew's tree.
This is what this tree is for, and now your patches got some exposure
and you have objections to work on, to say the least. I also admit that
some people here are being a little harsh, but I believe that each one
of us is doing his/her best to improve the kernel. It just happens that
our best isn't always as good as one would want.

> Ok, I want to listen what technical problems do you see?

As I explained before, I would like to see your superio subsystem
integrate properly with existing drivers that need it before you attempt
to add more functions on top of it. And I want a full documentation of
your superio subsystem to be part of the patchset. It seems that most
people here didn't get what you were doing and why you were doing it
(at least I wasn't alone ;)), so obviously a complete documentation
would be more than welcome - needed would in fact be the appropriate
term.


> Jean, it looks like you forget how superio is designed.
> Your pc87360 driver is all in one big piese of code, superio
> is splitted into absolutely separated modules - _one_ for superio chip,
> and _several_ for logical devices.
>
> I need to split your driver into at least 5 parts - pc8736x 
> initialisation(superio has it), i2c part(should be removed from superio
> code), fan logical device(separate part), voltage monitor logical device
> (separate part) and temperature monitor logical device (separate part).

The whole thing is a single driver because it achieves one goal. The fact
that National Semiconductor decided to use three different logical
devices for temperatures, voltages and fans is an implementation detail.
This alone doesn't justify a split of the source code. The "superio
chip" part is what you have been working on and I agree it was needed.
And I agree that the superio access has to be moved from my pc87360
driver (and other similar drivers) to your superio driver.

You do not *have* to separate all the parts. One single driver can
request several logical devices, and this is precisely what I want us to
do here. I agree that it could make sense to separate the logical
devices on a per device (and driver) basis, if it allows us to reuse the
code more easily. It is however not a requirement, that I can see.

> They are just separate modules, it is design feature to use _the_ _same_,
> for example, voltage monitor module with _any_ number of existent superio
> chips.

It isn't the first time you say that, and I have to say I don't much
get where you want to go. The hardware monitoring logical devices are
completely different between PC8736x, IT87xxF, W836x7(T)HF and 47M1xx
superio devices, just like the various other hardware monitoring chips
are different. There is no code to be shared here, so nothing is
duplicated.

Maybe it is different with gpio or access bus? Is there some standard
register organization among the various chip makers? I don't know
these, so I cannot tell.

> And that will end up having tons of duplicated code in each driver:
> temp monitor in A, temp monitor in B and so on...
> volt monitor in A, volt monitor in B and so on...

There is no logical device-based duplicated code in the superio hardware
monitoring drivers at the moment, unless you see things I do not (if you
do please let me know). The only thing that is duplicated accross the
drivers is the superio accesses, agreed, and I am glad that your unified
superio driver will put an end to this.

> Jean, we already discussed it a bit in lm_sensors mail list AFAR...

Yes, 5 months ago, and we did not exactly agree. And we obviously still
do not agree.

Don't get me wrong, I am not saying that I don't want your code in the
kernel. I am actually interested in it (the base superio part, in fact).
All I am asking for is that you put some efforts in presenting your code
correctly, splitting it the way it has to be, and getting it into the
kernel step by step. You are not going to get any support from me by
pretending that the superio hardware monitoring drivers need a full
rewrite to accomodate with your unified superio driver - because I know
it cannot be true. If you can provide a first patchset with core superio
driver, documentation of it, and *minimum* updates of the pc87360 driver
to make use of it, you can be sure I will review it with great care.

Thanks,
--
Jean Delvare
