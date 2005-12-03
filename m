Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVLCBfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVLCBfN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 20:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVLCBfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 20:35:12 -0500
Received: from hera.cwi.nl ([192.16.191.8]:6061 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S1750783AbVLCBfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 20:35:11 -0500
Date: Sat, 3 Dec 2005 02:34:55 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: 7eggert@gmx.de
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, horms@verge.net.au
Subject: Re: security / kbd
Message-ID: <20051203013455.GB24760@apps.cwi.nl>
References: <5f6Fp-1ZB-11@gated-at.bofh.it> <E1EiLA5-0001VE-64@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EiLA5-0001VE-64@be1.lrz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 01:21:51AM +0100, Bodo Eggert wrote:

> > On the other hand, I am told that recent kernels restrict the use of
> > loadkeys to root. If so, an unfortunate choice. People want to switch
> > unicode support on/off, or go from/to a dvorak keymap.
> 
> It's global, and it can be done remotely. Therefore you can either have
> remote logins or a secure console.

Let me repeat what I said and you snipped:
If there is a security problem, then it should be solved in user space.

Some people actually use the console. They want to be able to reassign
CapsLock, set their own function keys, set dvorak keymap etc.
It is a bad idea to restrict that functionality to root.

There are a thousand things one can do to put the kernel keyboard/console
in an interesting state. The solution is to have init/getty/login reset
state to a useful initial state. Not to have the kernel forbid one
to change the settings of the very keyboard one is typing on.

Andries

> The correct fix would be binding the keymap to the current tty only,
> resetting the console if it gets closed and not allowing init to reuse
> it unless it's closed. If you do this, you'll want a default setting, too.

Yes.

> YANI: Root should be able to set a coloured border indicating that it's
> really the getty/login process asking for the user prompt/password.

Didnt I show a "bleeding edge" patch some April 1st or so?
At least I had a red border on some console a few years ago.
The patch must still exist somewhere. I seem to recall that Paul Gortmaker
submitted a somewhat more general version.

---

marc.theaimsgroup.com tells me that the change was due to horms and akpm.
Let me cc them and see whether they have reasons why this had to be done
in kernel space.
