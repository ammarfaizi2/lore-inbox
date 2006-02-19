Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWBSEcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWBSEcr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 23:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWBSEcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 23:32:47 -0500
Received: from relay4.usu.ru ([194.226.235.39]:4307 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1750806AbWBSEcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 23:32:47 -0500
Message-ID: <43F7F521.2060308@ums.usu.ru>
Date: Sun, 19 Feb 2006 09:33:37 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Dickey <dickey@his.com>
Cc: "Adam Tla/lka" <atlka@pg.gda.pl>, torvalds@osdl.org, bug-ncurses@gnu.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]console:UTF-8 mode compatibility fixes
References: <20060217233333.GA5208@sunrise.pg.gda.pl> <43F72C7A.8010709@ums.usu.ru> <20060218204407.L36972@mail101.his.com>
In-Reply-To: <20060218204407.L36972@mail101.his.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.1.0; VDF: 6.33.1.5; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Dickey wrote:

> On Sat, 18 Feb 2006, Alexander E. Patrakov wrote:
>
>> If ncurses attempt to add some Chinese character to the Linux text
>> screen, Linux (correctly) prints this replacement character and advances
>> the cursor by one position. Ncurses think that the cursor has moved two
>> positions forward. The effect is that when you view the testcase in Lynx
>> (compiled --with-screen=ncursesw) on Linux console and press PageDown,
>> the fourth line contains "Thek" instead of "The" in the end.
>>
>> This disagreement has to be solved somehow.
>
>
> yes.  ncurses has no better information for this than the result from
> wcwidth().  Shall we add another kludge to accommodate Linux console?

Maybe yes, since putting wcwidth() into the kernel is a bigger kludge, 
because linux kernel will never draw CJK, and because after glibc 
update, kernel and glibc might disagree upon wcwidth of some characters.

So on linux console, ncurses should draw two 0xfffd characters when a 
character with wcwidth > 1 is requested.

> (Are there other terminal emulators with this specific problem?)

Not sure. I will test putty a bit later. Anyway, an environment variable 
for this kludge may be a good idea.

-- 
Alexander E. Patrakov
