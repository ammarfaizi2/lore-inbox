Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263367AbSJFKEv>; Sun, 6 Oct 2002 06:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263368AbSJFKEv>; Sun, 6 Oct 2002 06:04:51 -0400
Received: from mallaury.noc.nerim.net ([62.4.17.82]:38926 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id <S263367AbSJFKEu>; Sun, 6 Oct 2002 06:04:50 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.2] i386/dmi_scan updates
From: Jean Delvare <khali@linux-fr.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sun, 6 Oct 2002 12:12:06 CEST
Reply-To: Jean Delvare <khali@linux-fr.org>
X-Priority: 3 (Normal)
X-Originating-Ip: [172.186.9.185]
X-Mailer: Webmail Nerim (NOCC v0.9.5)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <20021006101026.92C2A62DC0@mallaury.noc.nerim.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> btw word wrap is broken on your mailer

I'm sorry about that. I have access to no SMTP server here and have to use a webmail client, which does no word wrap at all (and I'm rather happy with that since it allows me to send inline patches without having them totally messed up). I'm doing my best to word wrap quotations by myself but I may fail sometimes.

>> Also note that the white spaces check has been removed
>> from 2.4.
>The debug data can basically go

I'm not sure I get you. The debug data is still present and I think it is a good idea (we can enable it to blacklist systems that wouldn't even boot without an appropriate workaround). Only the white space check was removed. Anyway, I still this this check was bad, as was the null byte check also. See below.

>> A better way IMHO would be to "secure" the dmi_string
>> function. If we can ensure it will always return a safe
>> (that is, null terminated) string, we are done. Agreed?
>I'd ascii filter it as well but yes. The length one I dont
> think is a problem because the table length will gie us a
> defined worst case

I don't agree with ASCII filtering. I don't want to enlarge everyone's kernel for just some rare cases where the DMI table is broken *and* debug code is enabled. If you want, I can write the code that does it, but I wouldn't enable it by default.
As far as the length is concerned, the table length doesn't help, because we check the structure length against the remaining table length. The structure length does *not* include the string data, so we could pass the length test and still run of the table in dmi_string. What's more, the string index could be more that the string count for this structure and no check is done for this.
I think we need a safer dmi_string function that knows about the table length (or, better indeed, the remaining length from this point), and checks for both string index being too large and string index leading outside the table. Then, the other checks (white space and null byte) will be obsolete.

Jean Delvare


___________________________________
Webmail Nerim, http://www.nerim.net/


