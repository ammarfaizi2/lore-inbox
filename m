Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbUDEU67 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 16:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbUDEU67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 16:58:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9600 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263195AbUDEU6n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 16:58:43 -0400
Date: Mon, 5 Apr 2004 16:59:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jamie Lokier <jamie@shareable.org>
cc: Chris Friesen <cfriesen@nortelnetworks.com>, bero@arklinux.org,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Catching SIGSEGV with signal() in 2.6
In-Reply-To: <20040405204028.GA21649@mail.shareable.org>
Message-ID: <Pine.LNX.4.53.0404051644440.2948@chaos>
References: <Pine.LNX.4.58.0404050824310.13367@build.arklinux.oregonstate.edu>
 <20040405181707.GA21245@mail.shareable.org> <4071B093.9030601@nortelnetworks.com>
 <20040405204028.GA21649@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Apr 2004, Jamie Lokier wrote:

> Chris Friesen wrote:
> > SA_SIGINFO implies sigaction().  The original poster was talking about
> > signal().
> >
> > That said, it seems to work with 2.6.4 on ppc32.
>
> Just tried it with 2.6.3, x86 and signal().  Works fine.
>
> -- Jamie

Are you using a longjump to get out of the signal handler?
You may find that you can trap SIGSEGV, but you can't exit
from it because it will return to the instruction that
caused the trap!!!

#include <stdio.h>
#include <signal.h>
void handler(int sig) {
    fprintf(stderr, "Caught %d\n", sig);
}
int main() {
    char *foo = NULL;
    signal(SIGSEGV, handler);
    fprintf(stderr, "Send a signal....\n");
    kill(0, SIGSEGV);
    fprintf(stderr, "Okay! That worked!\n");
//    *foo = 0;
    return 0;
}

Just un-comment the null-pointer de-reference and watch!

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


