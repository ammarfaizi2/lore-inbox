Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264239AbTLAWQV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 17:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264240AbTLAWQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 17:16:21 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64901 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264239AbTLAWQO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 17:16:14 -0500
Date: Mon, 1 Dec 2003 17:19:30 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Rootkit queston
In-Reply-To: <1070313094.11356.6.camel@midux>
Message-ID: <Pine.LNX.4.53.0312011649060.4785@chaos>
References: <1070313094.11356.6.camel@midux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Dec 2003, Markus [ISO-8859-1] Hästbacka wrote:

> Hello all!
>
> I've been wondering about what is a rootkit and how it works?

It's some crap thrown together for the express purpose of
running a command-shell with root privileges on a system
being attacked. The binary load is usually fed in using
some kind of exploit such as overwriting a buffer in some
privileged program.

You fix that problem by upgrading any program found to
be susceptible to attack. If you have an old system, you
might wish to upgrade:

inetd
sendmail
ftpd
tftpd
/usr/sbin/in.*
dump
... and any other program that runs suid.

In particular, do not run inetd. Run xinetd instead.
You can check for a common 'root attack', if you have inetd,
by looking at the last few lines in /etc/inetd.conf.
It may have some access port added that allows anybody
who knows about it to log in as root from the network.

It will look something like this:

# End of inetd.conf.
4002 stream tcp nowait root /bin/bash --

In this case, port 4002 will allow access to a root shell
that has no terminal processing, but an attacker can use this
to get complete control of your system. FYI, this is a 5-year-old
attack, long obsolete if you have a "store-bought" distribution
more recent.

> I've been paranoid after I heard that the debian project got
> "rootkitted", I ran chkrootkit, and it said that it's possible that I
> have a LKM rootkit installed, but the website told me that it's possible
> that the LKM test gives wrong information with recent kernels (Running
> 2.4.22 now).
>
> These processes "were hidden from ps command":
> root         0  0.0  0.0     0    0 ?        SWN  Oct28   0:01
> [ksoftirqd_CPU0]
> root         0  0.0  0.0     0    0 ?        SW   Oct28   4:27 [kswapd]
> root         0  0.0  0.0     0    0 ?        SW   Oct28   0:00 [bdflush]
> root         0  0.0  0.0     0    0 ?        SW   Oct28   0:01
> [kupdated]
>
> They seem to have PID 0, is this normal?

Yes. These are kernel threads.

[SNIPPED...]

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


