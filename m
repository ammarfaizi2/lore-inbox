Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264486AbTGBUiP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 16:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264487AbTGBUiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 16:38:15 -0400
Received: from chaos.analogic.com ([204.178.40.224]:20354 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264486AbTGBUiN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 16:38:13 -0400
Date: Wed, 2 Jul 2003 16:55:44 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Kay Sievers <lkml001@vrfy.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: why does sscanf() does not interpret number length attributes?
In-Reply-To: <20030702203433.GA14854@vrfy.org>
Message-ID: <Pine.LNX.4.53.0307021644550.26973@chaos>
References: <20030702203433.GA14854@vrfy.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jul 2003, Kay Sievers wrote:

> I needed a conversion from hex-string to integer and found
> this mail from Linus suggesting sscanf:
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=101414195507893&w=2
>
> but sscanf in linux-2.5/lib/vsprintf.c interpretes length attributes
> only when the type is a string. It uses simple_strtoul() and it will
> read the buffer until it finds a non-(hex)digit.
>
> int i;
> char str[] ="34AFFE45XYZ";
> sscanf(str, "%1x", &i);
>
> i will be '0x34AFFE45' instead of the expected '3'.
>
> Is this behaviour intended or is just nobody caring about?
>

The in-kernel vsprintf() is very primative, used for very simple
things. Note that it doesn't even have "%f". You should just
do something like:

	i = (int) *str + '0';

      ... if you need to read part of a number.

You don't really wany to increase the size of the permanent
in-kernel stuff if you can help. You add any increased functionality
to your modules so it is used only when needed.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

