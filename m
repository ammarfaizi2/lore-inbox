Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267049AbTAFOyM>; Mon, 6 Jan 2003 09:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbTAFOyM>; Mon, 6 Jan 2003 09:54:12 -0500
Received: from chaos.analogic.com ([204.178.40.224]:52636 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267049AbTAFOyJ>; Mon, 6 Jan 2003 09:54:09 -0500
Date: Mon, 6 Jan 2003 10:04:35 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alex Bennee <alex@braddahead.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why do some net drivers require __OPTIMIZE__?
In-Reply-To: <1041863609.21044.11.camel@cambridge.braddahead>
Message-ID: <Pine.LNX.3.95.1030106095704.1580A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Jan 2003, Alex Bennee wrote:

> Hi,
> 
> I've been doing a bring up on an embedded kernel and to prevent gdb
> making me go google eyed I notched the optimization level down to -O0
> for the time being. This broke the natsemi network driver and I noticed
> this stanza appears in a few places:
> 
> #if !defined(__OPTIMIZE__)
> #warning  You must compile this file with the correct options!
> #warning  See the last lines of the source file.
> #error You must compile this driver with "-O".
> #endif
> 
> Despite the comments I couldn't see an explanation at the bottom of the
> source file and a quick google showed a few patches where this was
> removed but no explanation.
> 
> Does anybody know the history behind those lines? Do they serve any
> purpose now or in the past? Should I be nervous about compiling the
> kernel at a *lower* than normal optimization level? After all
> optimizations are generally processor specific and shouldn't affect the
> meaning of the C.
> 
> -- 
> Alex Bennee
> Senior Hacker, Braddahead Ltd
> The above is probably my personal opinion and may not be that of my
> employer

You need to optimize in order enable inline code generation. It is
essential to use in-line code in many places because, if the compiler
actually calls these functions they would have to be protected
from reentry.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


