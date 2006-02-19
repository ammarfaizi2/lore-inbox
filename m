Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWBSByA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWBSByA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 20:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWBSByA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 20:54:00 -0500
Received: from util105.his.com ([216.194.192.8]:31219 "EHLO util105.his.com")
	by vger.kernel.org with ESMTP id S1750861AbWBSByA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 20:54:00 -0500
Date: Sat, 18 Feb 2006 20:53:38 -0500 (EST)
From: Thomas Dickey <dickey@his.com>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
cc: Adam Tla/lka <atlka@pg.gda.pl>, torvalds@osdl.org, bug-ncurses@gnu.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]console:UTF-8 mode compatibility fixes
In-Reply-To: <43F72C7A.8010709@ums.usu.ru>
Message-ID: <20060218204407.L36972@mail101.his.com>
References: <20060217233333.GA5208@sunrise.pg.gda.pl> <43F72C7A.8010709@ums.usu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Feb 2006, Alexander E. Patrakov wrote:

> [sorry for repost, the first attempt got blocked due to html attachment, now 
> I gzipped it to circumvent the filter]
>
> Adam Tla/lka wrote:
>> This patch applies to 2.6.15.3 kernel sources to drivers/char/vt.c file.
>> It should work with other versions too.
>> 
>> Changed console behaviour so in UTF-8 mode vt100 alternate character
>> sequences work as described in terminfo/termcap linux terminal definition.
>> Programs can use vt100 control seqences - smacs, rmacs and acsc  characters
>> in UTF-8 mode in the same way as in normal mode so one definition is always
>> valid - current behaviour make these seqences not working in UTF-8 mode.

I expect some discussion from the people who _vehemently_ refused to allow
the Linux console to have anything that resembled a mode.

More to the point: since it's been in this form for several years, it 
doesn't do much good to developers, because there are already workarounds 
in ncurses to accommodate this, and even if you fixed it today, it would
be needed in ncurses for a few more years.

For example (man ncurses):

        NCURSES_NO_UTF8_ACS
             During initialization, the  ncurses  library  checks  for  special
             cases  where  VT100  line-drawing (and the corresponding alternate
             character set capabilities) described in the terminfo are known to
             be  missing.   Specifically,  when  running in a UTF-8 locale, the
             Linux console emulator and the GNU screen  program  ignore  these.
             Ncurses checks the TERM environment variable for these.  For other
             special cases, you should set this  environment  variable.   Doing
             this  tells  ncurses to use Unicode values which correspond to the
             VT100 line-drawing glyphs.   That  works  for  the  special  cases
             cited, and is likely to work for terminal emulators.

             When  setting this variable, you should set it to a nonzero value.
             Setting it to zero (or to a nonnumber) disables the special  check
             for Linux and screen.

is the most recent refinement (from a year ago) to a workaround which 
first appeared in ncurses 5.4 (originally from December 2002).

> Doesn't work here with linux-2.6.16-rc3-mm1, ncurses-5.5. BTW has this
> been discussed with Thomas Dickey (ncurses maintainer)?

no (my seeing it via google doesn't count).

> Another feature request / bug report (spotted while viewing in Lynx a
> page containing English text and a few Chinese characters, artificial
> testcase attached):
>
> If ncurses attempt to add some Chinese character to the Linux text
> screen, Linux (correctly) prints this replacement character and advances
> the cursor by one position. Ncurses think that the cursor has moved two
> positions forward. The effect is that when you view the testcase in Lynx
> (compiled --with-screen=ncursesw) on Linux console and press PageDown,
> the fourth line contains "Thek" instead of "The" in the end.
>
> This disagreement has to be solved somehow.

yes.  ncurses has no better information for this than the result from
wcwidth().  Shall we add another kludge to accommodate Linux console?
(Are there other terminal emulators with this specific problem?)

-- 
Thomas E. Dickey
http://invisible-island.net
ftp://invisible-island.net
