Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266346AbUAIAcS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 19:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUAIAcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 19:32:18 -0500
Received: from as1-5-2.lk.bonet.se ([194.236.93.33]:50050 "EHLO
	maggie.bluppfisk.org") by vger.kernel.org with ESMTP
	id S266346AbUAIAcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 19:32:12 -0500
Message-ID: <3FFDF67A.5060807@olaussons.net>
Date: Fri, 09 Jan 2004 01:31:54 +0100
From: Fredrik Olausson <fredrik@olaussons.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernardo Innocenti <bernie@develer.com>
CC: linux-kernel@vger.kernel.org, aeb@cwi.nl
Subject: Re: bad scancode for USB keyboard
References: <3FF6EFE0.9030109@develer.com> <3FFB6A5D.9030606@olaussons.net> <3FFB6E9E.6040500@develer.com> <20040107085104.GA14771@ucw.cz> <3FFC5F68.2090009@develer.com>
In-Reply-To: <3FFC5F68.2090009@develer.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have found a solution to the problem.
XFree86 has 2 keyboard drivers, the default one named "keyboard" and an 
alternative one named "kbd" which according to documentation on the 
XFree86 website is a new keyboard driver mostly written from scratch. 
With the kbd-driver the print-screen key and the |\-key got different 
keycodes and thus I could make the |\-key give me the proper characters.

So, to summarize. Simply changing the line:
Driver      "keyboard"
to
Driver      "kbd"
in the input-device section in the XF86Config file and fiddling a bit 
with xmodmap solved the problem for me.

Bernardo Innocenti wrote:
> Vojtech Pavlik wrote:
> 
>> On Wed, Jan 07, 2004 at 03:27:42AM +0100, Bernardo Innocenti wrote:
>>
>>>> I have the same problem with a Logitech cordless desktop.
>>>> I can easily change the keycode to generate the right characters 
>>>> when in console-mode, but XFree gives that key and the Print Screen 
>>>> key the same keycode.
>>>> After changing the xmodmap I can get the unmodified character, but 
>>>> modifiers doesn't work, it just gives me the same character not 
>>>> matter what modifier I use (shift, alt, alt_gr etc.)
>>>
>>>
>>> I had fixed my console keymap too, but I've not been able to
>>> figure out how to change the X keymap.  I've been looking in
>>> the /usr/X11R6/lib/X11/xkb/ directory, but perhaps XKB is not
>>> being used for old-style keyboard mapping?
>>>
>>> Could you provide detailed instructions?  C coding with missing
>>> backslash and bar keys is quite hard :-)
>>>
>>> Of course, I still thing its' a 2.6 kernel bug and it should be
>>> fixed.  Vojtech, do you have an idea why it's happening?
>>
>>
>> The reason is that this key is not the ordinary backslash-bar key, it's
>> the so-called 103rd key on some european keyboards. It generates a
>> different scancode.
> 
> 
> Yes, I've found out it's 84 for the key besides/below the enter key.
> 
>> 2.4 used the same keycode for both the scancodes, 2.6 does not, so that
>> it's possible to differentiate between the keys on keyboards that have
>> both this one and also the standard backslash-bar.
> 
> 
> I see...  So it appears the fix has to be done in the kbd package and in
> XFree86.
> 
> The default console keymap should be changed like this:
> 
> < keycode  84 = Last_Console
>  > keycode  84 = backslash        bar
> 
> Andries Brouwer appears to be the current maintainer of kbd, so I've
> pulled him into our thread.  This is also being cross-postied to
> the devel@XFree86.org list.
> 
> In addition, I'm going to open two PRs for these packages in RedHat's
> bugzilla to make sure the issue gets properly fixed before it hits the
> masses.
> 
> fyi, this thread was started here:
> 
>  http://www.ussg.iu.edu/hypermail/linux/kernel/0401.0/0485.html
> 

