Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWCWO43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWCWO43 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 09:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWCWO43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 09:56:29 -0500
Received: from mail.parknet.jp ([210.171.160.80]:49672 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S964841AbWCWO42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 09:56:28 -0500
X-AuthUser: hirofumi@parknet.jp
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: Phillip Susi <psusi@cfl.rr.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
References: <1142890822.5007.18.camel@localhost.localdomain>
	<20060320134533.febb0155.rdunlap@xenotime.net>
	<dvn835$lvo$1@terminus.zytor.com>
	<Pine.LNX.4.61.0603211840020.21376@yvahk01.tjqt.qr>
	<44203B86.5000003@zytor.com>
	<Pine.LNX.4.61.0603211854150.21376@yvahk01. <442050C8.1020200@zytor.com>
	<44205BC5.9040200@cfl.rr.com> <44206E1C.6090808@zytor.com>
	<87y7z2l159.fsf@duaron.myhome.or.jp> <442286CD.6070200@lsrfire.ath.cx>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 23 Mar 2006 23:56:20 +0900
In-Reply-To: <442286CD.6070200@lsrfire.ath.cx> (=?iso-8859-1?Q?Ren=E9?=
 Scharfe's message of "Thu, 23 Mar 2006 12:30:21 +0100")
Message-ID: <87d5gdky5n.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

René Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> OGAWA Hirofumi schrieb:
>> Looks like we get a good reason to kill strange reserved names in vfat
>> (and msdos too?).
>> 
>> Could you/anyone check what shortname is used for "AUX" if it is created
>> in cmd.exe?
>
> on Windows XP Home SP2 I did:
>
>    mkdir d:\test
>    cd /d d:\test
>    echo 1 > \\?\d:\test\aux
>    echo 2 > \\?\d:\test\nul
>    echo 3 > \\?\d:\test\nul.x
>    echo 4 > \\?\d:\test\nul.longext
>    echo 5 > \\?\d:\test\...
>    echo 6 > "\\?\d:\test\[];,+="
>    echo 7 > "\\?\d:\test\   "
>    dir /x > a.txt
>
> And here's the contents of a.txt:
>
> --- snip! ---
>  Datenträger in Laufwerk D: ist 53_00_00
>  Volumeseriennummer: 1002-884F
>
>  Verzeichnis von D:\test
>
> 23.03.2006  12:21    <DIR>                       .
> 23.03.2006  12:21    <DIR>                       ..
> 23.03.2006  12:21                 4 0103~1
> 23.03.2006  12:21                 4 7154~1       ...
> 23.03.2006  12:21                 0              a.txt
> 23.03.2006  12:21                 4              aux
> 23.03.2006  12:21                 4              nul
> 23.03.2006  12:21                 4 NUL~1.LON    nul.longext
> 23.03.2006  12:21                 4              nul.x
> 23.03.2006  12:21                 4 ______~1     [];,+=
>                8 Datei(en)             28 Bytes
>                2 Verzeichnis(se), 31.506.370.560 Bytes frei
> --- snip! ---
>
> So, no shortname is created for aux on my machine.

Thanks, Phillip and Rene.

It seems the shortname. Because "a.txt" is using same form, and
"no shortname" is meaning a "broken directory entry" in fat spec.

> Of course that doesn't prevent us from creating one in vfat, right?

Yes. We would not need special case for devices.

I'll remove reserved names from vfat/msdos, because many OSes/commands
(even Windows) creates it.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
