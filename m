Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbTDWO6Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264071AbTDWO6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:58:25 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8584 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264067AbTDWO54
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:57:56 -0400
Date: Wed, 23 Apr 2003 11:11:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: icedank@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: Stored data missed in setup.S
In-Reply-To: <20030423075158.510e25d2.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.53.0304231107530.23670@chaos>
References: <200304231617.23243.icedank@gmx.net> <Pine.LNX.4.53.0304230925150.23037@chaos>
 <200304231639.57148.icedank@gmx.net> <Pine.LNX.4.53.0304231028270.23276@chaos>
 <20030423075158.510e25d2.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, Randy.Dunlap wrote:

> On Wed, 23 Apr 2003 10:36:55 -0400 (EDT) "Richard B. Johnson" <root@chaos.analogic.com> wrote:
>
> | On Wed, 23 Apr 2003, Andrew Kirilenko wrote:
> |
> | [SNIPPED...]
> |
> | > OK. And now code looks like:
> | > -->
> | > start_of_setup: # line 160
> | > 	# bla bla bla - some checking code
> | >         movb    $1, %al
> | >         movb    %al, (0x100)
> | > ....
> | > ....
> | > 	cmpb    $1, (0x100)
> | > 	je bail820 # and it DON'T jump here
> | > <--
> | >
> |
> | > I'm sure, I'm doing something wrong. But what???
> |
> | The only possibiity is that the code you just showed is not
> | being executed. Absolute location 0x100 is not being overwritten
> | by some timer-tick (normally) so whatever you write there should
> | remain. You just put a byte of 1 in that location and then
> | you compared against a byte of 1. If the CPU was broken, you
> | wouldn't have even loaded your code.
>
> Could possibly be that DS (seg register) is altered between
> the store and the comparison...

I can only assume that the code presented is the only code that
was executed. You are correct that DS may have never even been
set. The data segment may be in some non-writable space, which
is hard to find now-days with most evenything being shadowed
and left writable. Many modern chip-sets can't turn off write,
maybe it was too expensive from a performance standpoint.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

