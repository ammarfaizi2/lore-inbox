Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbUFBXmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUFBXmJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 19:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUFBXmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 19:42:07 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:25985 "EHLO cloud.ucw.cz")
	by vger.kernel.org with ESMTP id S262488AbUFBXlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 19:41:05 -0400
Date: Thu, 3 Jun 2004 01:42:33 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Benoit Plessis <benoit@plessis.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Input system and keycodes > 256
Message-ID: <20040602234233.GC1366@ucw.cz>
References: <1082938686.21842.50.camel@osiris.localnet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082938686.21842.50.camel@osiris.localnet.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 02:18:07AM +0200, Benoit Plessis wrote:
> Hi,
> 
> I've digged into the kernel source/tools since i do own a new logitech
> USB keyboard MX with a great number a keys.
> 
> There are two kind of addons keys, some works (scancode in the e0 XX
> form): Email, Prev, Next, Play/Pause, Vol+/-, Mute, ...
>  + some of thoses generate a simple keycode eg 
>      Vol+: 0x73 | 0xf3 (scancodes: 0xe0 0x30 | 0xe0 0xb0)
>  + some doesn't eg:
>      play: 0x00 0x81 0xa4 | 0x80 0x81 0xa4  (scancodes: 0xe0 0x22 | 0xe0
> 0xa2)
>  _   but all thoses key work quite well under X.
> 
> The pb come from the new 'Function' keys with replace F1-F12 when the
> Flock mod isn't active (it's an hardware mod) and some other (Messenger,
> Webcam, iTouch and Buy).
> 
> When grabbing with 'showkey -s' nothing appear
> When grabbing with 'showkey' i got keycodes like '0x00 0x82 0xd0 | 0x80
> 0x82 0xd0' (i got same keycodes when pressing mouse buttons except those
> are in 0x82 0x90 -> 0x82 0x97 range)
> 
> When using the evbug module see that those keys generates > 255
> keycodes. (see attached file)
> And strangely all thoses keys generates the sames strings than keys with
> keycode2 = keycode - 256.
> 
> Eg: the 'New' function key (shared with F1) reported by evbug as 336
> keycode as the same effect as keycode 80 (keypad 2).
> 
> So i'm a little lost :(
> And i wanted some direction on how make thoses keys work correctly on
> the console (and X eventually. Actually under X some keys generate mouse
> button event, some doesn't generate anything).
> 
> I am wondering if a good start would not be to extend the kbentry
> structure, to use unsigned short at least for the index so whe can acces
> a fully 512 entry keymap.

I'm sorry, but X only understands the RAW PS/2 protocol, and that one
can only transport keycodes up to 240.

For keycodes above 240, XFree86 would either need to use the MediumRAW
mode, or use event devices for parsing the keyboard.

-- 
