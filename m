Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283311AbRLME0P>; Wed, 12 Dec 2001 23:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283314AbRLME0E>; Wed, 12 Dec 2001 23:26:04 -0500
Received: from acolyte.thorsen.se ([193.14.93.247]:16645 "HELO
	acolyte.hack.org") by vger.kernel.org with SMTP id <S283311AbRLMEZ4>;
	Wed, 12 Dec 2001 23:25:56 -0500
From: Christer Weinigel <wingel@acolyte.hack.org>
To: linux-kernel@vger.kernel.org
Subject: Asking for opinions on GPIO API
Message-Id: <20011213042553.5C6E0F5B@acolyte.hack.org>
Date: Thu, 13 Dec 2001 05:25:53 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working on a small embedded computer based on the National
Semiconductor SC2200 CPU.  This CPU has a lot of GPIO pins and I'm
wondering how to design a good API to control these pins.

Right now I have a few functions looking like this:

/* read the input from the GPIO and return 1/0 */
unsigned sc2200_gpio_get(unsigned index);

/* set and clear the pin */
void sc2200_gpio_set(unsigned index);
void sc2200_gpio_clr(unsigned index);

would it be better to have a function which takes the desired state of
the pin as an argument instead?

void sc2200_gpio_set(unsigned index, unsigned state);

Second, I have a pure implementation question, right now the set
function looks like this:

void sc2200_gpio_set(unsigned index) {
        unsigned flags;
        spin_lock_irqsave(&sc2200_gpio_lock, flags);
        outl(inl(gpio_base) | (1 << (index & 31)), gpio_base);
        spin_unlock_irqrestore(&sc2200_gpio_lock, flags);
}

which is safe, but clearing the interrupts is a rather expensive
operation, so I'd like to avoid it if possible.  Is it possible to do
something like the atomic set_bit function but with outl/inl?  Are
there any tricks that can be done?  Since the SC2200 is an ix86 CPU I
can use assembly language if neccesary and at least for this design, I
know that the system is a uniprocessor system and thus I won't have to
consider possible races between two CPU's.

    /Christer


