Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262180AbSJNUYw>; Mon, 14 Oct 2002 16:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbSJNUYw>; Mon, 14 Oct 2002 16:24:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:26755 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262180AbSJNUYu>; Mon, 14 Oct 2002 16:24:50 -0400
Date: Mon, 14 Oct 2002 16:33:50 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Daniele Lugli <genlogic@inrete.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: unhappy with current.h
In-Reply-To: <3DAB1F00.667B82B5@inrete.it>
Message-ID: <Pine.LNX.3.95.1021014162539.16867B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, Daniele Lugli wrote:

> I recently wrote a kernel module which gave me some mysterious problems.
> After too many days spent in blood, sweat and tears, I found the cause:
> 
> *** one of my data structures has a field named 'current'. ***
> 
> Pretty common word, isn't it? Would you think it can cause such a
> trouble? But in some of my files I happen to indirectly include
> <asm/current.h> (kernel 2.4.18 for i386), containing the following line:
> 
> #define current get_current()
> 
> so that my structure becomes the owner of a function it has never asked
> for, while it looses a data member. gcc has nothing to complain about
> that.
>

This cannot be the reason for your problem. The name of a structure
member has no connection whatsoever with the name of any function or
definition.

The following code will correctly write "Hello world!" to the screen
even though the text initializes a member of a structure called "current"
while "current" has been defined to be a function called puts.


#include <stdio.h>
#define current puts
struct foo {
    char *current;
    int foo;
    } bar; 
main()
{
    bar.current = "Hello world!";
    current(bar.current);
    return 0;
}


For your code to get "confused", you really have something else
wrong. That said, some name-space polution may make it difficult
to find the problem. For instance, a structure member is expected
to have a ";" after it. It's possible for some previous definition
to make a syntax error invisible.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

