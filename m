Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbTDWNTO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 09:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264028AbTDWNTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 09:19:14 -0400
Received: from chaos.analogic.com ([204.178.40.224]:64391 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264027AbTDWNTM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 09:19:12 -0400
Date: Wed, 23 Apr 2003 09:33:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andrew Kirilenko <icedank@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Stored data missed in setup.S
In-Reply-To: <200304231617.23243.icedank@gmx.net>
Message-ID: <Pine.LNX.4.53.0304230925150.23037@chaos>
References: <200304231617.23243.icedank@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, Andrew Kirilenko wrote:

> Hello!
>
> I feel myself stupid, when fighting against setup.S. Here is small piece of
> code (/arch/i386/boot/setup.S)
>
> --->
> start_of_setup: # line 160
> 	# bla bla bla - some checking code
>         movb    $1, %al
>         movb    %al, (0x100)
> ....
> ....
>         pushw   %ax
>         movb    (0x100), %al

You put something from offset 0x100 into %al.


>         cmpb    $1, %al

Then you compared it against 1. This is where the comparaison
occurred.

>         popw    %ax # pop don't change any flags - 386 asm reference

Then you put something else into %ax. Whatever it is, doesn't count.

>         je     bail820 # and it don't jump -- al != 1

Then you jumped based upon the comparison you made before you
destroyed the contents of %al by poping %eax (%eax is (%ah << 8) | %al).

If you don't want to muck with registers, just do:

		cmpb	$1, (0x100)
		jz	wherever

You don't need to put memory oprands into registers to compare.


> meme820: # line 300
> <---
>
> Any ideas? I've spent two days, trying to understand what's going on
> - no luck
> at all...
>
> Best regards,
> Andrew.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

