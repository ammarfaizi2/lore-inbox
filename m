Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130434AbRCPHVP>; Fri, 16 Mar 2001 02:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130438AbRCPHVF>; Fri, 16 Mar 2001 02:21:05 -0500
Received: from csl.Stanford.EDU ([171.64.66.149]:27832 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S130434AbRCPHUv>;
	Fri, 16 Mar 2001 02:20:51 -0500
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200103160719.XAA04602@csl.Stanford.EDU>
Subject: Re: [CHECKER] big stack variables
To: jdike@karaya.com (Jeff Dike)
Date: Thu, 15 Mar 2001 23:19:57 -0800 (PST)
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <200103160256.VAA02335@karaya.com> from "Jeff Dike" at Mar 15, 2001 09:56:10 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> engler@csl.Stanford.EDU said:
> > As usual, please report any false positives so we can fix our
> > checkers.
> 
> Not a false positive, but a false negative:
> 
> the tty_struct locals at lines 1994 and 2029 in tty_register_devfs and 
> tty_unregister_devfs, respectively, in the 2.4.2 drivers/char/tty_io.c.

Turns out we didn't have CONFIG_DEVFS_FS defined.  Big time fun when it is:

/u2/engler/mc/2.4.1/drivers/char/tty_io.c:1996:tty_register_devfs: ERROR:VAR:1996:1996: suspicious var 'tty' = 3112 bytes
/u2/engler/mc/2.4.1/drivers/char/tty_io.c:2007:tty_register_devfs: ERROR:FN:2007:2007: function stack consumes = 3146 bytes
/u2/engler/mc/2.4.1/drivers/char/tty_io.c:2031:tty_unregister_devfs: ERROR:VAR:2031:2031: suspicious var 'tty' = 3112 bytes
/u2/engler/mc/2.4.1/drivers/char/tty_io.c:2042:tty_unregister_devfs: ERROR:FN:2042:2042: function stack consumes = 3148 bytes

Right now we've just gone in and put =y for all options in .config --- is
there a more principled approach that will get more coverage?

> Nice work, BTW.

Thanks!  If you have any other ideas of things to check for, do let us
know.  We're mainly just going after things we've found in comments and
code.  We have about another 600 potential bugs to report, but are
going over them to try to make sure they are reasonable.

Dawson
