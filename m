Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316181AbSEOBBR>; Tue, 14 May 2002 21:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316184AbSEOBBQ>; Tue, 14 May 2002 21:01:16 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:6971 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316181AbSEOBBO>; Tue, 14 May 2002 21:01:14 -0400
Message-Id: <5.1.0.14.2.20020515015506.02749780@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 15 May 2002 02:01:27 +0100
To: "Axel H. Siebenwirth" <axel@hh59.org>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [2.5.15] NTFS does not compile. (with gcc3.1)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020515004113.GA21702@neon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a known issue with gcc-3.1. It fails to realize that the unnamed 
fields are typedef-ed structs/unions. And I really cannot understand why 
gcc-3.1 is barfing like that. I consider it a gcc-3.1 bug.

I have been meaning to contact the gcc developers about this for a while... 
Thanks for the reminder!

For the moment you can probably bypass this problem by making the driver 
work the gcc-2.95 way by editing fs/ntfs/types.h where it says

#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 96)

just change that to say:

#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 96) || (__GNUC__ == 
3 && __GNUC_MINOR__ >= 1)

Note this is a kludge and should NOT be applied to the main tree! I want 
gcc fixed not kludges added to ntfs...

Best regards,

         Anton

At 01:41 15/05/02, Axel H. Siebenwirth wrote:
>Dear kernel developers,
>
>I know, I know, I am not supposed to use gcc 3.x with linux kernel build,
>but maybe someone can just give me a hint what gcc option to add to NTFS
>build to get it to work?
>I just tried to build 2.5.15 and it stops during compilation of
>fs/ntfs/aops.c because of included header file layout.h:
>
>gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes
>-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
>-pipe -mpreferred-stack-boundary=2 -march=i686  -DNTFS_VERSION=\"2.0.6\"
>-DDEBUG -DKBUILD_BASENAME=aops  -c -o aops.o aops.c
>In file included from attrib.h:31,
>                  from debug.h:31,
>                  from ntfs.h:43,
>                  from aops.c:30:
>layout.h:299: unnamed fields of type other than struct or union are not
>allowed
>layout.h:1450: unnamed fields of type other than struct or union are not
>allowed
>layout.h:1466: unnamed fields of type other than struct or union are not
>allowed
>layout.h:1715: unnamed fields of type other than struct or union are not
>allowed
>layout.h:1892: unnamed fields of type other than struct or union are not
>allowed
>layout.h:2052: unnamed fields of type other than struct or union are not
>allowed
>layout.h:2064: unnamed fields of type other than struct or union are not
>allowed
>make[3]: *** [aops.o] Error 1
>make[3]: Leaving directory /usr/src/linux-2.5.15/fs/ntfs'
>make[2]: *** [first_rule] Error 2
>make[2]: Leaving directory /usr/src/linux-2.5.15/fs/ntfs'
>make[1]: *** [_subdir_ntfs] Error 2
>make[1]: Leaving directory /usr/src/linux-2.5.15/fs'
>make: *** [_dir_fs] Error 2
>
>
>
>Regards,
>Axel
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

