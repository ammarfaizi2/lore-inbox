Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271221AbTGWTB1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271223AbTGWTAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:00:20 -0400
Received: from chaos.analogic.com ([204.178.40.224]:41089 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S271221AbTGWS65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:58:57 -0400
Date: Wed, 23 Jul 2003 15:14:22 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Bernardo Innocenti <bernie@develer.com>
cc: uClinux development list <uclinux-dev@uclinux.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6 size increase
In-Reply-To: <200307232046.46990.bernie@develer.com>
Message-ID: <Pine.LNX.4.53.0307231507300.16939@chaos>
References: <200307232046.46990.bernie@develer.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003, Bernardo Innocenti wrote:

> Hello,
>
> code bloat can be very harmful on embedded targets, but it's
> generally inconvenient for any platform. I've measured the
> code increase between 2.4.21 and 2.6.0-test1 on a small
> kernel configuration for ColdFire:
>
>    text    data     bss     dec     hex filename
>  640564   39152  134260  813976   c6b98 linux-2.4.x/linux
                   ^^^^^^
>  845924   51204   78896  976024   ee498 linux-2.5.x/vmlinux

[SNIPPED...]

It looks like a lot of data may have been initialized in the
newer kernel, i.e. int barf = 0; or struct vomit = {0,}.
If they just declared the static data, it would end up in
.bss which is allocated at run-time (and zeroed) and is
not in the kernel image.

You might want to check this out. There is 51204 - 39152 = 12,052
more data, but 134260 - 78896 = 55350 less bss.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

