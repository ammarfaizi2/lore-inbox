Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVA0Kgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVA0Kgy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVA0Kgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:36:53 -0500
Received: from marshall-cpe-34-bgd.sbb.co.yu ([82.117.197.34]:53122 "EHLO
	82.117.197.34") by vger.kernel.org with ESMTP id S262547AbVA0KPd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:15:33 -0500
Date: Thu, 27 Jan 2005 11:16:27 +0100 (CET)
From: Sasa Stevanovic <mg94c18@alas.matf.bg.ac.yu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Possible bug in keyboard.c (2.6.10)
In-Reply-To: <200501262350.11896.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.61.0501271102490.4545@82.117.197.34>
References: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34>
 <200501262350.11896.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Jan 2005, Dmitry Torokhov wrote:

> On Wednesday 26 January 2005 22:16, Sasa Stevanovic wrote:
>> Hi,
>>
>> I had some problems with my laptop's onetouch keys and it eventually led me to
>> keyboard.c file from 2.6.10 kernel (Vojtech Pavlik and others).  There may be
>> a bug in the file, please read below.
>>
>> Well, actually, when all omnibook/messages/setkeycodes/hotkeys/xev/showkey etc
>> stuff is stripped off, what remains is that x86_keycodes array has only first
>> 240 members initialized, while remaining 16 are set to 0 due to [256]:
>>
>> static unsigned short x86_keycodes[256] = { <only 240 here> };
>>
>> (For my scenario, workaround was possible.)
>>
>> I am not sure if this is a bug or not; it worked in 2.4.18 without workaround.
>> Might be that someone wanted to prevent reading invalid memory.  There are
>> many versions of the file/array definition found on the web, none of which has
>> a comment about this.
>>
>
> From Vojetch Pavilk:
>> I'm sorry, but X only understands the RAW PS/2 protocol, and that one
>>  can only transport keycodes up to 240.
>>
>>  For keycodes above 240, XFree86 would either need to use the MediumRAW
>>  mode, or use event devices for parsing the keyboard.
> http://www.ussg.iu.edu/hypermail/linux/kernel/0406.0/0544.html
>
> You still did not describe what kind of problems you are having with your
> keys.
>
> -- 
> Dmitry
>

That's ok, I did not post the message to solve my problem, I posted because I 
though it was a possible bug.  I already worked around the problem by using 
setkeycodes to use keycodes (say) 233 and 234 instead of 243 and 244, then I 
also changed the upper-layer software to expect 233 and 234 and execute 
actions that would normally be executed if 243 or 244 was pressed.

Thank you for the information and the useful link.

P.S.  The problem was

atkbd.c: Unknown key pressed (translated set 2, code 0xf4 on isa0060/serio0). 
atkbd.c: Use 'setkeycodes e074 <keycode>' to make it known

Then after using setkeycodes e074 244 that's correct code for my computer 
(Omnibook XE3 GF), I had

keyboard.c: can't emulate rawmode for keycode 244

Sasa
