Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUCBQyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 11:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUCBQyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 11:54:41 -0500
Received: from chaos.analogic.com ([204.178.40.224]:896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261416AbUCBQyk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 11:54:40 -0500
Date: Tue, 2 Mar 2004 11:54:29 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Anonymous <anon78344@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: init dies after reboot
In-Reply-To: <20040302161239.79676.qmail@web20909.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0403021145150.489@chaos>
References: <20040302161239.79676.qmail@web20909.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2004, Anonymous wrote:

> Hello
>
> I encountered a strange problem, and i'm not sure that
> it originates or not in the kernel.
> the probl. is that on many slack boxes init dies after
> some time, but the OS is still up and running.
> if I 'ps aux' the machine,no init, and /proc/1 doesn't
> exist.
> although, `lsof | grep init` shows:init          1
> root  cwd    DIR        8,3        472         2 /
> init          1   root  rtd    DIR        8,3
> 472         2 /
> init          1   root  txt    REG        8,3
> 468916     15607 /sbin/init
> init          1   root    0r   CHR        1,3
>        5659 /dev/null
> init          1   root    1u   CHR        1,3
>        5659 /dev/null
> init          1   root    2u   CHR        1,3
>        5659 /dev/null
> init          1   root   10u  FIFO        8,3
>      137774 /dev/initctl
>
>
> Any kind of ideea?
>
> Thanks,
> Uwe Bower

The kernel will never send a signal 9 to init. However, it can
send many other signals. If the signal handler in init got
corrupt from a buffer overrun, bad memory, etc., it's quite
possible for init to die. When it dies, it would usually
die as a result of a seg-fault. You can observe /proc/1/cwd to
see where init lives. There may be a core-file in that directory.
The core-file might be able to give you a hint. Also, somebody
who has su privs can `cp /dev/random /dev/initctl` with some
interesting results.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


