Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266642AbTGFIdQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 04:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266644AbTGFIdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 04:33:16 -0400
Received: from dp.samba.org ([66.70.73.150]:20407 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266642AbTGFIdP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 04:33:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16135.57910.936187.611245@cargo.ozlabs.ibm.com>
Date: Sun, 6 Jul 2003 18:47:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: benh@kernel.crashing.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
In-Reply-To: <20030705073946.GD32363@wohnheim.fh-wedel.de>
References: <20030703202410.GA32008@wohnheim.fh-wedel.de>
	<20030704174339.GB22152@wohnheim.fh-wedel.de>
	<20030704174558.GC22152@wohnheim.fh-wedel.de>
	<20030704175439.GE22152@wohnheim.fh-wedel.de>
	<16134.2877.577780.35071@cargo.ozlabs.ibm.com>
	<20030705073946.GD32363@wohnheim.fh-wedel.de>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel writes:

> The problem is with a broken signal handler, that moves the stack
> pointer to nirvana.  You get a signal, set up the signal stack, move
> the pointer to nirvana, get a signal, set up the signal stack, move
> the pointer to nirvana, get a signal, ...

You can get the same effect by doing kill(0, SIGINT) inside a handler
for SIGINT.  All you seem to be saying is "if you behave stupidly then
bad things happen to you".  I don't see that this example exposes any
bug or vulnerability in the kernel.

> If I was just going down the signal stack, I would be perfectly happy,
> but instead the kernel believes each signal is the very first on the
> signal stack and sets it up again (and again...) each time.

You had to go to some trouble to get this effect - you had to use an
asm statement to change the stack pointer, which is well and truly
into "undefined behaviour" territory, and so you deserve all you
get. :)  It's a very contrived example IMHO.

Paul.
