Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVDZST0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVDZST0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 14:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVDZSTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 14:19:25 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:42453 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261670AbVDZSTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 14:19:12 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
To: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Tue, 26 Apr 2005 20:18:02 +0200
References: <3X9X6-5JP-27@gated-at.bofh.it> <3Xdel-8u2-43@gated-at.bofh.it> <3XfpD-21C-11@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DQUdL-0000rx-P3@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias-Christian Ott <matthias.christian@tiscali.de> wrote:

> And if you think "register" variables are outdated, please remove the
> CONFIG_REGPARM option from the Kernel source.

Register variables are outdated because they hinder the compiler from
optimizing by taking away 1/7 of the usable registers on x86. Use six
register variables and you're back to a accumulator-machine.
Use -O2 or -Os instead, the compiler is smarter than you.

The regparm calling convention will change the
load value -> store value on stack -> call sequence into
load value -> call -> store if needed
Obviously the second form can be better optimized than the first one.
Therefore it's a gain instead of a loss.

If you really want to help the compiler, look for something like repeated
pointer dereference or access to global variables and cache them in block-
local variables (pointers, int and uint only, even for caching chars).
Beware of volatile variables, and don't forget to look at the assembler code.
-- 
The generation of random numbers is too important to be left to chance. 

