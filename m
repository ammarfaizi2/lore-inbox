Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274806AbRJQHPY>; Wed, 17 Oct 2001 03:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274872AbRJQHPF>; Wed, 17 Oct 2001 03:15:05 -0400
Received: from mail.science.uva.nl ([146.50.4.51]:55742 "EHLO
	mail.science.uva.nl") by vger.kernel.org with ESMTP
	id <S274806AbRJQHO6>; Wed, 17 Oct 2001 03:14:58 -0400
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
Date: Wed, 17 Oct 2001 09:14:48 +0200 (CEST)
From: Kamil Iskra <kamil@science.uva.nl>
To: <linux-kernel@vger.kernel.org>
cc: <csmall@users.sourceforge.net>
Subject: Kernel 2.4.12 breaks fuser
Message-ID: <Pine.LNX.4.33.0110170858400.3761-100000@krakow.science.uva.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

fuser -n [tcp|udp] no longer works with the Linux kernel 2.4.12.  No
processes are printed, even though ports are clearly being used.  It used
to work fine with 2.4.10, I don't know about 2.4.11.  fuser is version 19,
as found in RH 7.1 (psmisc-19-4).

I know nothing about kernel internals, so I can't pinpoint the exact
change.  However, I debugged fuser with gdb and what I found out is that
fuser expects the st_dev field of /proc/pid/fd/* to be 0 for sockets.  In
2.4.12 st_dev is 4, at least for TCP sockets, so fuser fails to match the
entries.

I don't know if it's fuser that makes invalid assumptions or if it is a
kernel bug.  I guess it's for you guys to decide.

If you reply, please include my e-mail address in Cc, as I'm not on the
kernel list.

Regards,

-- 
Kamil Iskra                 http://www.science.uva.nl/~kamil/
Section Computational Science, Faculty of Science, Universiteit van Amsterdam
kamil@science.uva.nl  tel. +31 20 525 75 35  fax. +31 20 525 74 90
Kruislaan 403  room F.202  1098 SJ Amsterdam  The Netherlands

