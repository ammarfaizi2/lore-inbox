Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268325AbUJJPpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268325AbUJJPpU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 11:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268329AbUJJPpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 11:45:20 -0400
Received: from zero.aec.at ([193.170.194.10]:55567 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268325AbUJJPpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 11:45:16 -0400
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] __initdata strings
References: <2NNXM-1fZ-5@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 10 Oct 2004 17:45:12 +0200
In-Reply-To: <2NNXM-1fZ-5@gated-at.bofh.it> (Oleg Nesterov's message of
 "Sun, 10 Oct 2004 17:40:07 +0200")
Message-ID: <m38yae1ss7.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> Hello.
>
> This patch is not intended for inclusion, just for illustration.
>
> __init functions leaves strings (mainly printk's arguments) in
> .data section. It make sense to move them in .init.data.
>
> Is there anyone else who would consider this useful?

There is a more generic way to do this with gcc extensions. Something like
(uncompiled/untested)

#define __i(x) ({ static char __str[] __initdata = x; __str; })

But I'm not sure the few bytes saved are worth the code uglification. 
Probably not. likely/unlikely is already bad enough.

-Andi

