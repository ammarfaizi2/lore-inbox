Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVLCCJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVLCCJm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 21:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVLCCJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 21:09:42 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:17061 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751149AbVLCCJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 21:09:42 -0500
Date: Sat, 3 Dec 2005 03:11:42 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
cc: 7eggert@gmx.de, linux-kernel@vger.kernel.org, akpm@osdl.org,
       horms@verge.net.au
Subject: Re: security / kbd
In-Reply-To: <20051203013455.GB24760@apps.cwi.nl>
Message-ID: <Pine.LNX.4.58.0512030251570.6039@be1.lrz>
References: <5f6Fp-1ZB-11@gated-at.bofh.it> <E1EiLA5-0001VE-64@be1.lrz>
 <20051203013455.GB24760@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Dec 2005, Andries Brouwer wrote:
> On Sat, Dec 03, 2005 at 01:21:51AM +0100, Bodo Eggert wrote:

> > > On the other hand, I am told that recent kernels restrict the use of
> > > loadkeys to root. If so, an unfortunate choice. People want to switch
> > > unicode support on/off, or go from/to a dvorak keymap.
> > 
> > It's global, and it can be done remotely. Therefore you can either have
> > remote logins or a secure console.
> 
> Let me repeat what I said and you snipped:
> If there is a security problem, then it should be solved in user space.

By killing and disabeling all remote logins when root logs in or by 
ptracing each user program during root sessions? You'd have to do this 
untill we find somebody to do the correct fix in the kernel.

> Some people actually use the console. They want to be able to reassign
> CapsLock, set their own function keys, set dvorak keymap etc.
> It is a bad idea to restrict that functionality to root.

You can allways chmod u+s `type -p keymap`, but you'll take the blame.

> There are a thousand things one can do to put the kernel keyboard/console
> in an interesting state. The solution is to have init/getty/login reset
> state to a useful initial state.

This is not enough, since it's a global setting. At least, it used to be 
when I last looked. loadkeys doesn't complain when run from an xterm, 
therefore I asume nobody changed this. I can't change to the console since 
ati sucks.

> Not to have the kernel forbid one
> to change the settings of the very keyboard one is typing on.

> > The correct fix would be binding the keymap to the current tty only,
> > resetting the console if it gets closed and not allowing init to reuse
> > it unless it's closed. If you do this, you'll want a default setting, too.
> 
> Yes.

Unfortunartely nobody dares to implement this.

> > YANI: Root should be able to set a coloured border indicating that it's
> > really the getty/login process asking for the user prompt/password.
> 
> Didnt I show a "bleeding edge" patch some April 1st or so?

It's a bad day for presenting a usefull patch. It's one thing where
windows was ahead security-wise and which unices usurally lacked.
Off cause the CTRL-ALT-DEL secure screen is about to be disabled, so we 
can measure up to[0] windows by waiting.-)



[0] The translations of "gleicgziehen" by dict.leo.org seem strange.
-- 
If at first you don't succeed, call it version 1.0 
