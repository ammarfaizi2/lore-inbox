Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268314AbTCFTI4>; Thu, 6 Mar 2003 14:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268316AbTCFTI4>; Thu, 6 Mar 2003 14:08:56 -0500
Received: from chaos.analogic.com ([204.178.40.224]:40073 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268314AbTCFTIy>; Thu, 6 Mar 2003 14:08:54 -0500
Date: Thu, 6 Mar 2003 14:21:49 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: jds <jds@soltis.cc>
cc: linux-kernel@vger.kernel.org
Subject: Re: problems in kernel 2.4.20  stat() seems to return always size zero for any fifo (named pipe)
In-Reply-To: <20030306180838.M2529@soltis.cc>
Message-ID: <Pine.LNX.3.95.1030306140516.11315A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003, jds wrote:

> 
>  Hi:
> 
> I have a problem using stat() with kernel 2.4.20
> The size of ANY fifo is always 0.
> There is no backward compatibility.
> Probably it is a kernel bug in this particular version.
> The problem shows up when using the ls, stat commands.
> 
> How reproducible:
> Always
[SNIPPED...]

Have you ever tried this before? I'm not aware that stat
or lstat is supposed to return the byte-count of a pipe
of FIFO. It certainly doesn't on my Sun SunOS 5.5.1 or
Linux 2.4.18. In fact, the Sun prevents ^Z when reading
the FIFO interactively so your script won't test it.

The second echo "abcd" >xx blocks so the pipe never
accepts anything anyway, there are never any "bytes-
in-the-pipe" that should be visible anyway. You can't
write to a pipe until a reader is reading, and if the
reader is suspended, there is no requirement for writing
to be buffered, i.e., a write to be accepted for such
a pipe.

Pipes do not work like you propose and, if they ever did,
that was the bug.

> Expected Results:  prw-rw-r--    1 kostadin kostadin        5 Feb 21 13:54 xx
> 
> In Kernel 2.4.18-X the RedHat work perfect,
> e inclusive in 2.4.20-X the Redhat
>   beta 8.0.94
>

Linux 2.4.18 does not accept writes to a pipe when a reader is
not actively reading. As such, a byte-count cannot exist.

If you have a program that expects a byte-count from a FIFO,
the program is broken. FIFOs must have readers before any
writes are accepted.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


