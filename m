Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265660AbUGDMuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265660AbUGDMuO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 08:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265680AbUGDMuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 08:50:14 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:24328 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265660AbUGDMuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 08:50:08 -0400
Date: Sun, 4 Jul 2004 14:50:03 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org, sebek64@post.cz
Subject: Re: register dump when press scroll lock
Message-ID: <20040704125003.GE6456@pclin040.win.tue.nl>
References: <20040703102516.GA11284@penguin.localdomain> <200407040219.32581.vda@port.imtp.ilyichevsk.odessa.ua> <20040704121740.GA3637@penguin.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704121740.GA3637@penguin.localdomain>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 02:17:40PM +0200, Marcel Sebek wrote:

> > > Steps to reproduce:
> > > Switch keyboard by "Pause/Break" key from English to Czech map (or another
> > > second keymap, I also tried Slovak). Then press scrolllock. The following
> > > is printed out and scrlock led state is untouched:
> 
> I'm using Debian testing.
> 
> I looked at keymap definition. For ScrLock there is this:
> 
> keycode 70 = Scroll_Lock Show_Memory Show_Registers
> control keycode 70 = Show_State
> alt keycode 70 = Scroll_Lock
> 
> If I want the same behavior as with english keymap, I should either
> use Alt-ScrLock or rewrite the keymap.

The keymap knows about 8 modifiers.
You can bind keys to simple modifiers, also to locking modifiers.

Your Czech keymap uses the Pause key as ShiftR_Lock.
(ShiftR is the 6th modifier, see also keymaps(5).)
Thus, while typing in the English state of the keyboard
you are using no modifiers unless explicitly pressing Shift/Alt/Ctrl/...
but when typing in the Czech state of the keyboard you are
permanently using ShiftR.

Now you press ScrollLock in the Czech state of the keyboard.
What happens is the action bound to ShiftR ScrollLock.
If no action is bound you may instead get the action bound
to Plain ScrollLock.

Investigate your keymap. If you understand, all is well.
If you don't understand, complain, e.g. to aeb@cwi.nl.

I am not aware of any recent changes in this area.
Your keymap is something of your own choice, not something
given by the kernel. See also loadkeys and dumpkeys.

Andries
