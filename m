Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265181AbUGGOvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbUGGOvA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 10:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265198AbUGGOu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 10:50:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:645 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265181AbUGGOu5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 10:50:57 -0400
Date: Wed, 7 Jul 2004 10:50:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Address space for user process
In-Reply-To: <20040707163535.02323a8f.Christoph.Pleger@uni-dortmund.de>
Message-ID: <Pine.LNX.4.53.0407071039260.18280@chaos>
References: <20040707163535.02323a8f.Christoph.Pleger@uni-dortmund.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2004, Christoph Pleger wrote:

> Hello,
>
> I read that - at least in Kernel 2.4 - the amount of memory that can be
> addressed by a user process is limited to 3 GB, no matter how much
> virtual memory is present. Is it possible to raise that limit?
>
> Kind regards
>   Christoph

Sure. Use two (or more) tasks. It is a per-process limit because
in Unix the kernel shares the processes address space. See
how your process is laid out by executing this:

#include <stdio.h>
extern char _start;
extern char _end;
char dat;
const char x[]="x";
int main()
{
    char foo;
    printf("start = %p\n", &_start);
    printf(" main = %p\n", main);
    printf(" data = %p\n", &dat);
    printf("const = %p\n", x);
    printf("stack = %p\n", &foo);
    printf("  end = %p\n", &_end);
    return 0;
}

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


