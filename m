Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130515AbRCLRiF>; Mon, 12 Mar 2001 12:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130516AbRCLRhz>; Mon, 12 Mar 2001 12:37:55 -0500
Received: from hood.tvd.be ([195.162.196.21]:7725 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S130515AbRCLRho>;
	Mon, 12 Mar 2001 12:37:44 -0500
Date: Mon, 12 Mar 2001 18:34:55 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: tulip-users@lists.sourceforge.net,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 21041 transmit timed out
In-Reply-To: <Pine.GSO.4.10.10103121407450.15717-100000@escobaria.sonytel.be>
Message-ID: <Pine.LNX.4.05.10103121833300.14663-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2001, Geert Uytterhoeven wrote:
> I made a list of driver versions that showed the problem so far:
> 
> | Tulip driver version 0.9.14 (February 20, 2001)

Wow! 0.9.14 in my 2.4.3-pre2 kernel just seem to have recovered from the
problem:

| NETDEV WATCHDOG: eth0: transmit timed out
| eth0: 21041 transmit timed out, status fc660000, CSR12 000001c8, CSR13 ffffef05, CSR14 ffffff3f, resetting...
| eth0: 21143 100baseTx sensed media.
| NETDEV WATCHDOG: eth0: transmit timed out
| eth0: 21041 transmit timed out, status fc260010, CSR12 000002c8, CSR13 ffffef0d, CSR14 fffff73d, resetting...
| NETDEV WATCHDOG: eth0: transmit timed out
| eth0: 21041 transmit timed out, status fc260010, CSR12 000002c8, CSR13 ffffef0d, CSR14 fffff73d, resetting...
| eth0: Out-of-sync dirty pointer, 243506 vs. 243524.

And eth0 is back online.

The next few lines in the syslog do look suspicious, though:

| release_dev: driver.table[1] not tty for ()
| release_dev: driver.table[7] not tty for (FikXZdoGQcCWQFGjV5evDzG+mv
| Q1jmH5buYh7LWpmXr8mfjykOCoR2Ry+NmzL3sE49mLozzdT22tUJKu6ztÄPÂÜð)
| Warning: dev (04:08) tty->count(2) != #fd's(1) in release_dev
| release_dev: driver.table[7] not tty for ()
| Warning: dev (04:41) tty->count(2) != #fd's(1) in tty_open
| Warning: dev (04:08) tty->count(3) != #fd's(1) in tty_open
| Warning: dev (04:41) tty->count(3) != #fd's(2) in tty_open
| Warning: dev (04:41) tty->count(3) != #fd's(2) in release_dev
| Warning: dev (04:41) tty->count(3) != #fd's(2) in tty_open

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

