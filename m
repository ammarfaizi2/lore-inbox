Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264661AbSJORCJ>; Tue, 15 Oct 2002 13:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264669AbSJORCI>; Tue, 15 Oct 2002 13:02:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17536 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264661AbSJORCD>; Tue, 15 Oct 2002 13:02:03 -0400
Date: Tue, 15 Oct 2002 13:08:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Daniele Lugli <genlogic@inrete.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: unhappy with current.h
In-Reply-To: <3DAB3592.E19150C6@inrete.it>
Message-ID: <Pine.LNX.3.95.1021015130629.1853B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, Daniele Lugli wrote:

> 
> Try the following instead:
> 
> // file shade1.cpp
> 
> // excerpt from common.h
> 
> #define current get_current()
> 
> // my stuff
> 
> struct {
>   int any;
>   int current[1000];
> } mine;
> 
> 
> // file shade2.cpp
> 
> #include <stdio.h>
> 
> // my stuff
> 
> extern struct {
>   int any;
>   int current[1000];
> } mine;
> 
> int main () {
>   mine.current[999] = 1;
>   printf ("%d\n", mine.current[999]);
> }
> 
> g++ shade1.cpp shade2.cpp
> 
> ./a.out => segmentation fault
> 
> Regards, Daniele
> 

It should have written a diagnostic which it does in C, not C++.

xxx.c:6: `get_current' declared as function returning an array
xxx.c:6: field `get_current' declared as a function

This () make all the difference. If you are trying to write kernel
drivers in C++, you will have more suprises. If not, you should
not be including kernel headers.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

