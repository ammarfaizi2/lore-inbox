Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbTLUPEy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 10:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbTLUPEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 10:04:54 -0500
Received: from ping.ovh.net ([213.186.33.13]:39882 "EHLO ping.ovh.net")
	by vger.kernel.org with ESMTP id S262859AbTLUPEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 10:04:52 -0500
Date: Sun, 21 Dec 2003 16:03:12 +0100
From: Octave <oles@ovh.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Peter Zaitsev <peter@mysql.com>, linux-kernel@vger.kernel.org
Subject: Re: lot of VM problem with 2.4.23
Message-ID: <20031221150312.GJ25043@ovh.net>
References: <20031221001422.GD25043@ovh.net> <1071999003.2156.89.camel@abyss.local> <Pine.LNX.4.58L.0312211235010.6632@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0312211235010.6632@logos.cnet>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 12:37:44PM -0200, Marcelo Tosatti wrote:
> 
> 
> On Sun, 21 Dec 2003, Peter Zaitsev wrote:
> 
> > On Sun, 2003-12-21 at 03:14, Octave wrote:
> > > Hi,
> > > Since we use 2.4.23 we have lot of crash. I have no kernel panic.
> > > All I can report is this kind of syslog's message:
> > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > VM: killing process rateup
> 
> How much swap do you have in your system?
> 
> This is happening because the system is unable to free memory (you
> probably ran out of swap for some reason).

Marcelo,

For exemple this server: Piv 2.4GHz with 1Go RAM
I think it arrives when all memory is used (ram + swap). 

# free
             total       used       free     shared    buffers     cached
Mem:       1032592    1016492      16100          0      36184     759668
-/+ buffers/cache:     220640     811952
Swap:       265064     122784     142280

# ps auxw | grep -v "0  0.0"
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
mysql    26958  0.0 14.0 275000 144972 ?     S    Dec19   2:09 /usr/sbin/mysqld --basedir=/ --datadir=/var/lib/mysql --user=mysql --
mysql    27004  0.0 14.0 275000 144972 ?     S    Dec19   2:28 /usr/sbin/mysqld --basedir=/ --datadir=/var/lib/mysql --user=mysql --
mysql    27005  0.0 14.0 275000 144972 ?     S    Dec19   2:03 /usr/sbin/mysqld --basedir=/ --datadir=/var/lib/mysql --user=mysql --
root      9621  0.0  0.1  6316 1860 ?        S    01:02   0:00 /usr/sbin/sshd
root      9631  0.0  0.1  2500 1352 pts/0    S    01:02   0:00 -bash
root      9683  0.0  0.1  6276 1844 ?        S    13:47   0:00 /usr/sbin/sshd
root      9707  0.0  0.1  2504 1356 pts/2    S    13:47   0:00 -bash
postfix  29728  0.0  0.1  3508 1184 ?        S    15:45   0:00 pickup -l -t fifo -u
mysql     7341  0.0 14.0 275000 144972 ?     S    15:59   0:00 /usr/sbin/mysqld --basedir=/ --datadir=/var/lib/mysql --user=mysql --
root      7347  0.0  0.1  2504 1356 pts/2    R    15:59   0:00 -bash

There is nothing to take 1Go of RAM.

I switched to 2.4.22 some servers and there is no more problem with. So I think
it's 2.4.23's problem only.

Octave
