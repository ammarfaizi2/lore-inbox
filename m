Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274549AbRITQAS>; Thu, 20 Sep 2001 12:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274550AbRITQAI>; Thu, 20 Sep 2001 12:00:08 -0400
Received: from smtp.guardiandigital.com ([209.11.107.5]:37897 "HELO
	juggernaut.guardiandigital.com") by vger.kernel.org with SMTP
	id <S274549AbRITQAB>; Thu, 20 Sep 2001 12:00:01 -0400
Date: Thu, 20 Sep 2001 12:00:24 -0400 (EDT)
From: "Ryan W. Maple" <ryan@guardiandigital.com>
To: Richard Mueller <mueller@teamix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange SGID-Bit behavior with 2.2. and 2.4
In-Reply-To: <8414177426.20010920142457@teamix.net>
X-Base: ALL YOUR BASE ARE BELONG TO US. (http://www.scene.org/redhound/AYB.swf)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <20010920160025.9184611D304@juggernaut.guardiandigital.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Did you upgrade/patch your fileutils anytime in between?  Check this URL
out:

  http://www.mail-archive.com/bug-fileutils@gnu.org/msg00934.html

cp was not clearing the SUID and SGID bits in the absense of -p.

Cheers,
Ryan

 +-- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --+
   Ryan W. Maple          "I dunno, I dream in Perl sometimes..."  -LW
   Guardian Digital, Inc.                     ryan@guardiandigital.com
 +-- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --+


On Thu, 20 Sep 2001, Richard Mueller wrote:

> Hello almighty kernelgods...
> 
> a friend and I discovered some strange diffrence in the beahavior
> of the 2.4, 2.2 Kernels.
> 
> Following Commands were done on both kernels:
> ---------------------------------------------
> su -
> cd /
> mkdir test
> chmod 2755 test
> chown rdd test
> su rdd
> cd /test
> touch a
> chgrp users a
> chmod 7777 a
> cp a b
> cp /bin/ls d
> chgrp users d
> chmod 7777 d
> cp d e
> 
> These results are on 2.4.6
> --------------------------
> drwxr-sr-x    2 rdd      root          190 Sep 14 15:17 .
> drwxr-xr-x   22 root     root          455 Sep 14 14:59 ..
> -rwsrwsrwt    1 rdd      users           0 Sep 14 15:00 a
> -rwsr-sr-t    1 rdd      root            0 Sep 14 15:02 b
>    -->^<-- What's that?
> -rwsrwsrwt    1 rdd      users       46568 Sep 14 15:07 d
> -rwxr-xr-t    1 rdd      root        46568 Sep 14 15:08 e
> 
> 
> And these on 2.2.16
> -------------------
> drwxr-sr-x   2 rdd      root          103 Sep 14 15:13 .
> drwxr-xr-x  20 root     root          369 Sep 14 15:10 ..
> -rwsrwsrwt   1 rdd      users           0 Sep 14 15:12 a
> -rwsr-xr-t   1 rdd      root            0 Sep 14 15:12 b
> -rwsrwsrwt   1 rdd      users       41552 Sep 14 15:12 d
> -rwsr-xr-t   1 rdd      root        41552 Sep 14 15:13 e
> 
> It happens both with ext2 and reiserfs.
> 
> 
> Can anyone explain this behavior? Would be great.
> 
> If this is a damn stupid question, please drop it and kill me. :|
> 
> 
> Richard Mueller
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

