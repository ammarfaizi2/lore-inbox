Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbSKNS10>; Thu, 14 Nov 2002 13:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbSKNS10>; Thu, 14 Nov 2002 13:27:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59264 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261550AbSKNS1Z>; Thu, 14 Nov 2002 13:27:25 -0500
Date: Thu, 14 Nov 2002 13:36:54 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Chuck Lever <cel@citi.umich.edu>, Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new timeout behavior for RPC requests on TCP sockets
In-Reply-To: <shsd6p8qhul.fsf@charged.uio.no>
Message-ID: <Pine.LNX.3.95.1021114133025.13043B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Nov 2002, Trond Myklebust wrote:

> >>>>> " " == Richard B Johnson <root@chaos.analogic.com> writes:
> 
>      > The Client is the guy that just retries, as you say from a
>      > time-out.  This shouldn't affect any internal TCP/IP code. The
>      > time-out is at the application (client) level. It sent a
>      > request, the data was sent or promised to be sent because the
>      > write() or send() didn't block, now it expects to get the data
>      > it asked for. It waits, nothing happens. It times-out and sends
>      > the exact same request again.
> 
> Huh??? There's no 'application level' involved here at all, nor any
> 'internal TCP/IP code'.
> 
> Chuck's patch touches the way the kernel Sun RPC client code (as used
> exclusively by the kernel NFS client and the kernel NLM client)
> handles the generic case of message timeout + resend. Why would we
> want to even consider pushing that sort of thing down into the NFS
> code itself?
> 
> Cheers,
>   Trond
> 

Because all of the RPC stuff was, initially, user-mode code. For
performance reasons or otherwise, it was moved into the kernel.
Okay, so far? Now, when something goes wrong with that code, should
that code be fixed, or should the unrelated TCP/IP code be modified
to accommodate? I think the time-outs should be put at the correct
places and not added to generic network code.

Once the client side gets a buffer of data from the TCP/IP stack,
the TCP/IP should not care (ever) what it does with it. Putting
the timeout(s) in the TCP/IP stack, makes it care, and adds code
to accommodate.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


