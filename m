Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267003AbTAFPpy>; Mon, 6 Jan 2003 10:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267005AbTAFPpy>; Mon, 6 Jan 2003 10:45:54 -0500
Received: from chaos.analogic.com ([204.178.40.224]:56732 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267003AbTAFPpw>; Mon, 6 Jan 2003 10:45:52 -0500
Date: Mon, 6 Jan 2003 10:56:34 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Robert Love <rml@tech9.net>
cc: Alex Bennee <alex@braddahead.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why do some net drivers require __OPTIMIZE__?
In-Reply-To: <1041867947.730.8.camel@phantasy>
Message-ID: <Pine.LNX.3.95.1030106105330.1785B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Jan 2003, Robert Love wrote:

> On Mon, 2003-01-06 at 10:04, Richard B. Johnson wrote:
> 
> > You need to optimize in order enable inline code generation. It is
> > essential to use in-line code in many places because, if the compiler
> > actually calls these functions they would have to be protected
> > from reentry.
> 
> I do not think this is correct.
> 
> Concurrency concerns would not change wrt calling the function vs.
> inlining it.
> 
> More likely some code, i.e. asm, just assumes inlining is taking place.
> 
> 	Robert Love
> 

When you call a function, that function gets a copy of the parameters
passed to it. In-line code accesses those parameters directly. That's
why the spin-lock code, for instance, won't work (with the current macros)
unless they are in-lined.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


