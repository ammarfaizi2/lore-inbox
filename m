Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266008AbTFWMoe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 08:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbTFWMoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 08:44:34 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:44244 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266008AbTFWMoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 08:44:32 -0400
Date: Mon, 23 Jun 2003 14:58:35 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Julien Oster <lkml@mf.frodoid.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: no crash after setting ESP to 0 in module
In-Reply-To: <frodoid.frodo.87isqxmxxf.fsf@usenet.frodoid.org>
Message-ID: <Pine.LNX.4.44.0306231455130.5675-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
>
> I already asked this once, but since I got no answer I figured I'll
> try it again, maybe this time someone has the time to quickly explain
> me that thing.
>
> If I build a kernel module which does something like, say:
>
> MOV ESP, 0
>
> in init_module() then I get an oops, insmod (or whatever process tried
> to insert the module) gets killed by the kernel and everything goes on
> like that never happened.
>
> My question is now: why? How? I really expect the processor to fail
> into a triple fault when doing such a nasty thing, since I am in Ring
> 0 and there isn't any stack to handle the stack fault exception.
>
> Where's the magic?

Processor will do double fault prior to triple fault. Double fault
exception 8 points to a task switch gate --- and task switch doesn't
require correct ESP. So it loads new ESP from task state segment of that
gate and calls doublefault_fn.

See file arch/i386/kernel/doublefault.c

Mikulas

