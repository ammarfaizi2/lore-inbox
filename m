Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317422AbSINSXP>; Sat, 14 Sep 2002 14:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317434AbSINSXP>; Sat, 14 Sep 2002 14:23:15 -0400
Received: from web40506.mail.yahoo.com ([66.218.78.123]:16675 "HELO
	web40506.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317422AbSINSXO>; Sat, 14 Sep 2002 14:23:14 -0400
Message-ID: <20020914182804.28287.qmail@web40506.mail.yahoo.com>
Date: Sat, 14 Sep 2002 11:28:04 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: Possible bug and question about ide_notify_reboot in 2.4.19
To: miquels@cistron.nl
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Putting the drive in stand-by mode has the side effect of flushing
>the cache.
Maxtor's tech support says this is NOT true.

>So before poweroff, send the FLUSH CACHE command,
>then send the standby command, hope that one of them works ..
Problem is we're currently flushing the cache AFTER we do
standby...

>I put put-the-drive-in-standby-mode stuff in halt.c of sysvinit
>after several reports of fs corruption at poweroff and it seems
>to have fixed the problems for the people who reported them.
That code is only executed if the '-h' option is passed to halt:
Some distros (namely Slackware 7.x) pass the '-p' option instead
(look in /etc/rc.d/rc.0).


Ok how about this: I'm current testing some patches against
ide.c and friends. Why don't I just add ( and document ) a
define called NO_STANDBY_ON_SHUTDOWN which would live in 
ide.c. By default it would not be defined. Then I just wrap
the standby code in an '#ifndef NO_STANDBY_ON_SHUTDOWN..#endif'
block.




__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
