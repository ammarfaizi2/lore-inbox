Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbRIDTb3>; Tue, 4 Sep 2001 15:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268133AbRIDTbU>; Tue, 4 Sep 2001 15:31:20 -0400
Received: from [213.97.45.174] ([213.97.45.174]:8453 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S268071AbRIDTbD>;
	Tue, 4 Sep 2001 15:31:03 -0400
Date: Tue, 4 Sep 2001 21:31:16 +0200 (CEST)
From: Pau Aliagas <linux4u@wanadoo.es>
X-X-Sender: <pau@pau.intranet.ct>
To: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: help!! tons of Z processes in 2.4.x (x > 3)
In-Reply-To: <E15eLmy-0004Ki-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0109042123570.2038-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2001, Alan Cox wrote:

> > Since 2.4.6-ac[45] until 2.4.9-ac7 I keep on getting processes in Z
> > state, mainly identd (spawned from an identd daemon), galeon (the gnome
> > browser) and mysqld.
>
> Sounds like user mode problems to me. Z is a zombie - its waiting for its
> parent to wake up and collect its exit code. Look at their ppid see what
> the parent is and is doing

(only relevant parts included)
$ ps -eo pid,stat,pcpu,nwchan,wchan=WIDE-WCHAN-COLUMN -o args

 2051 S     0.0 140d0c do_poll            \_ /usr/bin/galeon-bin
 2052 S     0.0 140d0c do_poll                \_ /usr/bin/galeon-bin
 2053 S     0.0 105e8b rt_sigsuspend          \_ /usr/bin/galeon-bin
 2318 Z     0.0 11872e do_exit                \_ [galeon-bin <defunct>]
 2319 Z     0.0 11872e do_exit                \_ [galeon-bin <defunct>]
 2320 Z     0.0 11872e do_exit                \_ [galeon-bin <defunct>]
 2331 Z     0.0 11872e do_exit                \_ [galeon-bin <defunct>]

 2087 S     0.0 118af1 wait4             /bin/sh /usr/bin/safe_mysqld
 2114 S     0.0 1406c6 do_select          \_ /usr/libexec/mysqld
 2116 S     0.0 140d0c do_poll                \_ /usr/libexec/mysqld
 2117 S     0.0 105e8b rt_sigsuspend              \_ /usr/libexec/mysqld
 2118 S     0.0 105e8b rt_sigsuspend              \_ /usr/libexec/mysqld
 2124 Z     0.0 11872e do_exit                    \_ [mysqld <defunct>]
 2174 S     0.0 1d1ed8 tcp_data_wait              \_ /usr/libexec/mysqld
 2308 S     0.0 1f2e1c unix_stream_data_          \_ /usr/libexec/mysqld

It looks like they don't exit gracefully :(

> Yep - it doesnt really exist except as a process slot

> > If I run the redhat-7.1 kernel (kernel-2.4.3-12) this doesn't
> > happen, so I deduce it has something to do with recent changes.
> > I'm surprised that I'm the only one with this problem.
>
> So far you are

In fact I've noticed that it also happens with rh71 kernel rpm.

Pau

