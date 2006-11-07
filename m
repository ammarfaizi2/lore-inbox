Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753331AbWKGUv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbWKGUv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbWKGUv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:51:56 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7859 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1753331AbWKGUv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:51:56 -0500
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
	<m1mz739l0b.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0611071228230.8122@topaz.pathscale.com>
Date: Tue, 07 Nov 2006 13:51:00 -0700
In-Reply-To: <Pine.LNX.4.64.0611071228230.8122@topaz.pathscale.com> (Dave
	Olson's message of "Tue, 7 Nov 2006 12:30:25 -0800 (PST)")
Message-ID: <m1wt677zgr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Olson <olson@pathscale.com> writes:

> On Tue, 7 Nov 2006, Eric W. Biederman wrote:
> | > | If your card doesn't pay attention to configuration space access cycles
> then
> | > | there should be no reason to write the value there.  If your card does pay
> | > | attention to the configuration space access cycles it should be trivial to
> | > | make this work.
> | >
> | > The card does pay attention, and other programs such as lspci and the
> | > like also look at the config space.  They should definitely be kept
> | > in sync, and config writes are fairly cheap, anyway.
> | 
> | Well this is a rathole so it really isn't safe for lspci to play with
> | (races with the kernel accessing it)
>
> Displaying something that might change is a fact of life, and no
> different than the PCI world.  It's still best to keep things as
> correct as possible.

No.  I was thinking of the rat hole in pci config space you have to
access to read these registers.  You have to actively write a pci
config value to select which register you are going to read.

So by default it is not safe to touch this value from user space,
because you could mess up the kernel, if the kernel is updating the
value.

Eric
