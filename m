Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264052AbTDWOXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264053AbTDWOXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:23:05 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4744 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264052AbTDWOXD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:23:03 -0400
Date: Wed, 23 Apr 2003 10:36:55 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andrew Kirilenko <icedank@gmx.net>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Stored data missed in setup.S
In-Reply-To: <200304231639.57148.icedank@gmx.net>
Message-ID: <Pine.LNX.4.53.0304231028270.23276@chaos>
References: <200304231617.23243.icedank@gmx.net> <Pine.LNX.4.53.0304230925150.23037@chaos>
 <200304231639.57148.icedank@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, Andrew Kirilenko wrote:

[SNIPPED...]

> OK. And now code looks like:
> -->
> start_of_setup: # line 160
> 	# bla bla bla - some checking code
>         movb    $1, %al
>         movb    %al, (0x100)
> ....
> ....
> 	cmpb    $1, (0x100)
> 	je bail820 # and it DON'T jump here
> <--
>

> I'm sure, I'm doing something wrong. But what???

The only possibiity is that the code you just showed is not
being executed. Absolute location 0x100 is not being overwritten
by some timer-tick (normally) so whatever you write there should
remain. You just put a byte of 1 in that location and then
you compared against a byte of 1. If the CPU was broken, you
wouldn't have even loaded your code.

It is quite likely that the IP is being diverted around your code
by some previous code.

FYI, you can check the progress of your code by 'printing' on
the screen. Set up ES to point to the screen segment, and write
letters there:

	movw	$0xb800, %ax
	movb	%ax, %es
	movb	$'A', %es:(0)

This 'prints' an 'A' at the first location on the screen.




Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

