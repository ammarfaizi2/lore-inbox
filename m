Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287467AbSAECvL>; Fri, 4 Jan 2002 21:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287468AbSAECvB>; Fri, 4 Jan 2002 21:51:01 -0500
Received: from hera.cwi.nl ([192.16.191.8]:31403 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S287467AbSAECux>;
	Fri, 4 Jan 2002 21:50:53 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 5 Jan 2002 02:50:50 GMT
Message-Id: <UTC200201050250.CAA232926.aeb@cwi.nl>
To: bryce@obviously.com
Subject: Re: Why would a valid DVD show zero files on Linux?
Cc: Lionel.Bouton@free.fr, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, util-linux@math.uio.no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here are the first 2048 1024 byte blocks.

Hmm. I am a bit slow, but just looked at this image.
It looks fine in iso9660 style, provided you give the
nojoliet option. I get:

# mount DeLorme_TopoUSA_DVD.head /mnt -t iso9660 -o loop,nojoliet
# ls -l /mnt
total 12
dr-xr-xr-x    1 root     root         2048 Feb 28  2001 .
drwxr-xr-x   31 root     root         4096 Jan  3 02:11 ..
-r-xr-xr-x    1 root     root         2763 Feb 28  2001 cd.txt
dr-xr-xr-x    1 root     root         2048 Feb 28  2001 data
-r-xr-xr-x    1 root     root          196 Feb 28  2001 pdataset.txt

and

# mount DeLorme_TopoUSA_DVD.head /mnt -t udf -o loop
# ls -l /mnt
total 14
dr-xr-xr-x    3 4294967295 4294967295      184 Feb 28  2001 .
drwxr-xr-x   31 root     root         4096 Jan  3 02:11 ..
-r--r--r--    1 4294967295 4294967295     2763 Feb 28  2001 CD.TXT
dr-xr-xr-x    2 4294967295 4294967295      380 Feb 28  2001 DATA
-r--r--r--    1 4294967295 4294967295      196 Feb 28  2001 PDATASET.TXT

so the iso9660 version looks a bit better than the udf version.
(But I cannot look at the actual contents because the initial
fragment is not large enough. You can check for yourself
whether the nojoliet mount is OK.)

Thus, there do not seem reasons to change mount(2) or mount(8)
in the way you suggested. There is no "empty iso9660 filesystem" here.

Andries
