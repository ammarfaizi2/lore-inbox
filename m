Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVBIQC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVBIQC5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 11:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVBIQC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 11:02:57 -0500
Received: from styx.suse.cz ([82.119.242.94]:22413 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261817AbVBIQCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 11:02:42 -0500
Date: Wed, 9 Feb 2005 17:03:45 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Jirka Bohac <jbohac@suse.cz>, lkml <linux-kernel@vger.kernel.org>,
       roman@augan.com, hch@nl.linux.org
Subject: Re: [rfc] keytables - the new keycode->keysym mapping
Message-ID: <20050209160345.GA16487@ucw.cz>
References: <20050209132654.GB8343@dwarf.suse.cz> <20050209152740.GD12100@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050209152740.GD12100@apps.cwi.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 04:27:40PM +0100, Andries Brouwer wrote:

> > The keycodes are mapped into keysyms using so-called keymaps. A keymap is
> > an array (of 255 elements per default) of keysyms, and there is one such
> > keymap for each modifier combination. There are 9 modifiers (such as Alt,
> > Ctrl, ....), so one would need to allocate 2^9 = 512 such keymaps to make
> > use of all modifier combinations. However, there is a limit of 256 keymaps
> > to prevent them eating too much memory. In short, you need a whole keymap
> > to add a new modifier combination to a single key -- bad.
> > 
> > The problem is, that not all keyboard modifiers can actually be assigned a
> > keyboard map - CapsLock and NumLock simply aren't on the list.
> 
> The current keyboard code is far more powerful than you seem to think.
> 
> Keymaps are allocated dynamically, and only few people use more than 16.
> You can have 256 keymaps, but they are not necessarily the 2^8 maps
> belonging to all 2^8 combinations of simultaneously pressed modifier keys.
> 
> You can assign the "modifier" property to any key you like.
> You can assign the effect of each modifier key as you like.
> There are modifier keys with action while pressed, and modifier keys
> that act on the next non-modifier keystroke (say, for handicapped),
> and modifier keys that lock a state (say, to switch between Latin
> and Cyrillic keyboards).
> 
> It seems very unlikely that you cannot handle Czech with all
> combinations of 8 keys pressed, and need 9.

A czech keyboard has the letters 'escrzyaie' with accents on the number
row of keys. With a Shift, they are supposed to produce the original
numbers, but with a CapsLock, they're supposed to produce the uppercase.
With a right alt or one of three czech dead keys they should produce
the !@#$%^&*() symbols.

It's kind of logical, kind of stupid, but anyway it's the national standard.

You can't do that currently. The main problem is that CapsLock is
hardcoded to work as a Shift on keys and you can't make it work
differently for normal letter keys and for the upper row of keys.

> Please document carefully what you want to do and why you want
> to do it. I think most reasonable things are possible.
> 
> (The weakest part is the support for Unicode / UTF8 - don't know
> whether improvement would be good - it is clear that one doesnt
> want to have full Unicode support in the kernel, but there is
> continued pressure to add some support for diacriticals. We might.)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
