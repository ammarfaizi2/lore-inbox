Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965675AbWKGSVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965675AbWKGSVR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965686AbWKGSVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:21:17 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4547 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965675AbWKGSVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:21:17 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: olson@pathscale.com
Cc: "Bryan O'Sullivan" <bos@serpentine.com>, Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
	<20061105064801.GV13381@stusta.de>
	<m1lkmpq5we.fsf@ebiederm.dsl.xmission.com>
	<20061107042214.GC8099@stusta.de> <45501730.8020802@serpentine.com>
	<m1psbzbpxw.fsf@ebiederm.dsl.xmission.com>
	<4550B22C.1060307@serpentine.com>
	<m18xinb1qn.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0611070934570.25925@topaz.pathscale.com>
Date: Tue, 07 Nov 2006 11:20:20 -0700
In-Reply-To: <Pine.LNX.4.64.0611070934570.25925@topaz.pathscale.com> (Dave
	Olson's message of "Tue, 7 Nov 2006 09:37:07 -0800 (PST)")
Message-ID: <m1mz739l0b.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Olson <olson@pathscale.com> writes:

> On Tue, 7 Nov 2006, Eric W. Biederman wrote:
> | Huh?  As I read the ipath code I am passing you the value that needs to go
> | into ipath->int_config and thus into dd->ipath_kregs->kr_interrupt_config.
>
> Yes.
>
> | Sure it is coming as 2 32bit words instead of a one big 64 bit one, but
> | that is simple to fix.
>
> It would be cleaner, but not absolutely necessary.
>
> | If your card doesn't pay attention to configuration space access cycles then
> | there should be no reason to write the value there.   If your card does pay
> | attention to the configuration space access cycles it should be trivial to
> | make this work.
>
> The card does pay attention, and other programs such as lspci and the
> like also look at the config space.  They should definitely be kept
> in sync, and config writes are fairly cheap, anyway.

Well this is a rathole so it really isn't safe for lspci to play with
(races with the kernel accessing it)

This hole concept of you having the register but not connecting it up on
the card is rather bizarre.

> | If you really need to write to both the config space registers and your
> | magic shadow copy of the register I can certainly do the config space
> | writes for you.  I just figured it would be more efficient not to.
>
> The HT layer should always do the config updates, since you are trying
> to clean up that layer.  Only the "extra" stuff (if any) should be done by
> the callback.

Fine by me.  That's why the patch was up for review.  That is just moving
the if statement I currently have.  So it should be trivial.  If that
won't break your card that is good enough for me.

Eric
