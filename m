Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264729AbUFMAiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264729AbUFMAiO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 20:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbUFMAiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 20:38:14 -0400
Received: from zero.aec.at ([193.170.194.10]:23301 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264729AbUFMAiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 20:38:13 -0400
To: john@stebbins.name
cc: linux-kernel@vger.kernel.org
Subject: Re: sys_close undefined on x86_64
References: <26qTc-8ok-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 13 Jun 2004 02:38:09 +0200
In-Reply-To: <26qTc-8ok-3@gated-at.bofh.it> (John Stebbins's message of
 "Sun, 13 Jun 2004 02:20:06 +0200")
Message-ID: <m3acz8nvgu.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stebbins <john@stebbins.name> writes:

> Can someone tell me if this is a kernel bug or a problem with the module
> I'm trying to compile?
>
> I'm attempting to compile an external module for the PVR-250 mpeg-2
> capture card (ivtv module).  The driver is a little behind the times,
> but various people have persuaded it to compile and load on 2.6
> systems.  I had it running on i386 arch 2.6 kernel earlier.  But I've
> since upgraded to x86_64.
>
> insmod fails with sys_close undefined message when attempting to load
> the module.
>
> The other sys_ functions seem to be there.
>
> If the use of sys_close has been deprecated or something, could someone
> please give me a pointer to the right way to do syscalls in the 2.6
> kernels.  I've done some digging and just can't find any useful
> information.

It's just not exported and x86-64 unlike i386 calls in kernel system
calls directly.  In theory it could be exported (stick a
EXPORT_SYMBOL(sys_close) somewhere in the main kernel), however it
would be better to change the driver to not use it and use a private
file or no file at all.

-Andi

