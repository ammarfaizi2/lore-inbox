Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267487AbUHJTFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267487AbUHJTFW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 15:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267543AbUHJTEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 15:04:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:28560 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267487AbUHJTDz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 15:03:55 -0400
Date: Tue, 10 Aug 2004 15:03:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Paul Jackson <pj@sgi.com>
cc: Eric Masson <cool_kid@future-ericsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Fork and Exec a process within the kernel
In-Reply-To: <20040810092116.7dfe118c.pj@sgi.com>
Message-ID: <Pine.LNX.4.53.0408101456260.13579@chaos>
References: <4117E68A.4090701@future-ericsoft.com> <20040809161003.554a5de1.pj@sgi.com>
 <4118E822.3000303@future-ericsoft.com> <20040810092116.7dfe118c.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004, Paul Jackson wrote:

> > My user mode program is running.
>
> Good.
>
> > Any idea how to control which console it shows up on?
>
> No clue.
>
> --


/dev/console is a symlink to /dev/tty0.

Alt-F1 = /dev/tty0
Alt-F2 = /dev/tty1
Alt-F3 = /dev/tty2

... etc.

    struct termios term;

    tcgetattr(0, &term);	// Get old terminal characteristics
    (void)close(0);		// Close old terminal(s)
    (void)close(1);
    (void)close(2);
    fd = open("/dev/console", O_RDWR);
    tcsetattr(fd, &term);	// Restore characteristics
    dup2(fd, 0);
    dup2(fd, 1);
    dup2(fd, 2);

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


