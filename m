Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTDGUEQ (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 16:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTDGUEQ (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 16:04:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:53123 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263628AbTDGUEO (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 16:04:14 -0400
Date: Mon, 7 Apr 2003 16:28:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Robert White <rwhite@casabyte.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Stupid API Question.
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGGEIHCGAA.rwhite@casabyte.com>
Message-ID: <Pine.LNX.4.53.0304071616200.19772@chaos>
References: <PEEPIDHAKMCGHDBJLHKGGEIHCGAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Apr 2003, Robert White wrote:

> I have looked, but I have not found...
>
> Is there a (safe) Kernel API for setting a processes appearance on the PS
> listing? (e.g. it's name etc.)
>
> I have seen the nonsense about clearing out your various argv[] elements and
> then using strncpy to replace argv[0].  That seems neither safe nor elegant.
> It also seems thread unsafe, or at least thread un-interesting, since all
> the threads would be tagged with the same/last such call.
>
> If it exists, where might it be found?
>
>
> If it doesn't exist...
>
> An API that could change the text for everything after argv[0] and filled a
> pointer in the process structure for the process, would be interesting.
>
> I say *after* argv[0] because I think having *any* means to change the
> presentation of argv[0] is a far-too-gaping security hole.
>
> I have no idea what the order of magnitude for this effort might be.
> Managing a normally-null pointer that overrides the various facts if it is
> set, and is freed back into the kernel memory pool when the process exits,
> wouldn't be that tough.  Intercepting whatever ps(1) (etc.) does to build
> the output might be non-trivial.
>
> Anyway, just a thought...
>
> Rob.

Well `ps` does the wrong thing so users need to do the wrong thing
to be compatible.

`ps` reads the command-line from the proc file-system.  Obviously
the command-line can't be changed after a program starts executing
because it's something that was passed to the program before execution.
That's like making somebody un-pregnant.

So, hacks from hackers `setproctitle` comes to mind, replace some of
the command-line, usually overwriting the environment strings, with
some alien text.

With the current API, (Unix) the "'correct'" way to set a process
title is for everybody to agree upon an environment string like "TITLE=".
Then, if you want to change the process title, you change that string.
`ps` would then look for the "TITLE=" token and use the string after that.

However, it's unlikely that anybody will ever do that because of:

(1) Inertia.
(2) NIH.

PS it's trivial to modify `ps` to search for "TITLE=" and display
that, as well as the command-line strings IFF "TITLE=" is not found.
A new `ps` would make new/old compatibility work, but again, it's
unlikely that this 20 year-old problem will ever be fixed.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

