Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262510AbSJEULv>; Sat, 5 Oct 2002 16:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262528AbSJEULv>; Sat, 5 Oct 2002 16:11:51 -0400
Received: from mallaury.noc.nerim.net ([62.4.17.82]:3854 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id <S262510AbSJEULu>; Sat, 5 Oct 2002 16:11:50 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.2] i386/dmi_scan updates
From: Jean Delvare <khali@linux-fr.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sat, 5 Oct 2002 22:19:06 CEST
Reply-To: Jean Delvare <khali@linux-fr.org>
X-Priority: 3 (Normal)
X-Originating-Ip: [172.183.206.145]
X-Mailer: Webmail Nerim (NOCC v0.9.5)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <20021005201723.A1FA062D01@mallaury.noc.nerim.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>  - Stop skipping DMI entries when type is less than those of the
>>    previous entry. I could see no reason for doing this.

> Fixes crashes on certain vendors hardware. It shouldnt be
> needed, however in the real world it proves to be a
> rather essential heuristic. Dmidecode doesnt do it
> because in userspace I dont mind spewing crap to show a
> user a problem.

This check has been removed in 2.4 though. I think it was needed when we were trusting the structure count (see version 1.1 of dmidecode) instead of also verifying we weren't running of the table. Now that this check is done, I don't see why we would need the heuristic anymore.

(...)

>>  - Remove senseless tests in dump (debug) code.

> These are also not senseless. Not everyone seems to use
> the proper null string, sometimes you get spaces too

I don't see how the check would protect us against anything. It only looks if the first char is a null byte or a white space. This is not very helpful, since on one hand such strings may be valid, and on the other hand invalid strings may pass the test.

Also note that the white spaces check has been removed from 2.4.

> The technical changes look right, and in theory all of it
> does. In practice I'd rather see a patch that kept the
> rule of thumb about order and the ' ' check

A better way IMHO would be to "secure" the dmi_string function. If we can ensure it will always return a safe (that is, null terminated) string, we are done. Agreed?

Jean Delvare


___________________________________
Webmail Nerim, http://www.nerim.net/


