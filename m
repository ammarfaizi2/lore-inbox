Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbTJTNrN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 09:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTJTNrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 09:47:13 -0400
Received: from chaos.analogic.com ([204.178.40.224]:48772 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262308AbTJTNrJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 09:47:09 -0400
Date: Mon, 20 Oct 2003 09:48:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ken Foskey <foskey@optushome.com.au>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: K 2.6 test6 strange signal behaviour
In-Reply-To: <1066654886.5930.57.camel@gandalf.foskey.org>
Message-ID: <Pine.LNX.4.53.0310200938260.13239@chaos>
References: <1066654886.5930.57.camel@gandalf.foskey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Oct 2003, Ken Foskey wrote:

>
> I have a problem with signals.
>
> I get multiple signals from a single execution of the program.  I have
> attached a stripped source.  Here is the critical snippet, you can see
> the signal handler being set before each call:
>
> 	signal( SIGSEGV,	SignalHdl );
> 	signal( SIGBUS,		SignalHdl );
> 	fprintf( stderr, "Running \n" );
> 	result = func( eT, p );
> 	fprintf( stderr, "Finished \n" );
> 	signal( SIGSEGV,	SIG_DFL );
> 	signal( SIGBUS,		SIG_DFL );
>
> When I run the code, that does 2 derefs of NULL you will see 2 instances
> of "Running" and the handler is not invoked at all for the second time.
>
> ./solar:

You really didn't give enough information, but I think your
signal() is not set up as BSD signals as you expect. I encountered
such a problem several years ago and reported it to the people
who wrote the 'C' runtime library. They were kind enough to respond
with the usual "you are an idiot..." response, but buried in the
response was the information that I needed. You can bypass all
those problems by using sigaction(). You can set the flags to
give the required response. I think you want SA_RESTART in the
flags to give you the response you expect.

Also, if you have a longjmp() in your handler code, you can
trash your local variables in the main-line code. You want
to try to perform whatever it is that you are doing without
setjmp()/longjmp() or sigsetjmp()/siglongjmp().

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


