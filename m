Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263579AbTDWTuo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTDWTuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:50:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:30856 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263579AbTDWTul
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:50:41 -0400
Date: Wed, 23 Apr 2003 16:05:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andrew Kirilenko <icedank@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Searching for string problems
In-Reply-To: <200304232248.35985.icedank@gmx.net>
Message-ID: <Pine.LNX.4.53.0304231602270.26351@chaos>
References: <200304231958.43235.icedank@gmx.net> <200304232200.20028.icedank@gmx.net>
 <Pine.LNX.4.53.0304231529320.25963@chaos> <200304232248.35985.icedank@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, Andrew Kirilenko wrote:

> Hello!
>
> Big thanks to all of you. Now I'm starting to understand how it's working.
> Here is current version of my code:
>
> -->
>        jmp         cl_start
> cl_id_str:      .string "STRING"
> cl_start:
>         cld
>         movw    %cs, %ax
>         movw    %ax, %ds
>         movw    $0xe000, %ax
>         movw    %ax, %es
>         movb    $0, %al
>         xor         %bx, %bx  # start of segment
> cl_compare:
>         movw    $cl_id_str, %si
>         movw    $cl_start, %cx
>         subw    %si, %cx
>         decw    %cx
>         movw    %bx, %di
>         repz    cmpsb
>         je      cl_compare_done_good
>         incw    %bx
>         cmpw    $0xffff, %bx  # are we at the end of segment
>         je      cl_compare_done
>         jmp     cl_compare
> cl_compare_done_good:
>        movb $1, %al
> cl_compare_done:
> <--
>
> And this code won't work as well :(
>
> Unfortunately, I can't start DOS and check, cause there is no video and
> keyboard controller on that PC.
>
> Best reagrds,
> Andrew.

Change this:

         movw    $0xe000, %ax

To:
         movw    $0xf000, %ax

... like I told you. The BIOS ROM contents, the stuff that has the
serial number _must_ start where I told you.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

