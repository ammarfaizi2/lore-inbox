Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbTBBIOu>; Sun, 2 Feb 2003 03:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbTBBIOu>; Sun, 2 Feb 2003 03:14:50 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:34958 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S264940AbTBBIOt>;
	Sun, 2 Feb 2003 03:14:49 -0500
Date: Sun, 2 Feb 2003 09:23:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Hiroshi Miura <miura@da-cha.org>
Cc: tomita@cinet.co.jp, vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.59] support japanese JP106 keyboard on new console.
Message-ID: <20030202092346.A32354@ucw.cz>
References: <20030124031453.0A29F11775F@triton2> <3E31752A.92C47F90@cinet.co.jp> <20030201015429.EB85D11775F@triton2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030201015429.EB85D11775F@triton2>; from miura@da-cha.org on Sat, Feb 01, 2003 at 10:54:29AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 01, 2003 at 10:54:29AM +0900, Hiroshi Miura wrote:
> Hi, Mr. Tomita,
> 
> 
> In message "Re: [PATCH 2.5.59] support japanese JP106 keyboard on new console."
>     on 03/01/25, Osamu Tomita <tomita@cinet.co.jp> writes:
> > I have a question.
> > 
> > > +       if (atkbd->set == 5) {
> > > +               atkbd->keycode[0x13] = 0x70;  /* Hiragana/Katakana */
> > I'm interesting in the reason to use keycode 0x70 for 'Hiragana/Katakana' key.
> > Please clarify.
> 
> This is answer for your question.
> 
> I have two point of view about this.
> these are my try and error process.
> 
> First, I press Katakana_Hiragana key on console with 2.4.19, it warns
> 
> keyboard: unrecognized scancode (70) - ignored
> 
> Two, in a  2.4.20's pc_keyb.c,  there is a comment,
> /*
>  * The keycodes below are randomly located in 89-95,112-118,120-127.
>  * They could be thrown away (and all occurrences below replaced by 0),
>  * but that would force many users to use the `setkeycodes' utility, where
>  * they needed not before. It does not matter that there are duplicates, as
>  * long as no duplication occurs for any single keyboard.
>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^            
>  */
> 
> Hiragana_Katakana was not defined before and I want to define a  keycode point.
> When I saw 2.4.20 pc_keyb.c source, I found all keycode below 127 was used,
> then there is no room. But the comment tell me I can use 120-123, 125-127 with 
> Japanese keyboard because these are not used on JP89/109 keyboards.
> (124 is, as you know, Yen key)  THese are defined for a latin keyboards.
> So I use 120. 
> 
> How do you think about it?

In 2.4 you can, in 2.5 the 'as long as no duplication occurs for any
single keyboard' is not valid anymore, and the keycode for
hiragana/katakana is defined to be 183 I think.

-- 
Vojtech Pavlik
SuSE Labs
