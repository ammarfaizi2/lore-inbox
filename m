Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSH0Haf>; Tue, 27 Aug 2002 03:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315278AbSH0Haf>; Tue, 27 Aug 2002 03:30:35 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:45549 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S315276AbSH0Haf> convert rfc822-to-8bit; Tue, 27 Aug 2002 03:30:35 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH RFC] s390x sys32 (remove duplicated code)
To: Tim Hockin <thockin@sun.com>
Cc: linux-390@vm.marist.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFAA4E270B.0BB4F82F-ONC1256C22.00285512@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Tue, 27 Aug 2002 09:29:42 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 27/08/2002 09:34:44
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tim,

> I am working on a patch that removes the old limit of NGROUPS.
>
> In doing so, I am checking everything that references NGROUPS.  One
> such place is in arch/s390x/kernel/linux32.c.
>
> I notice these things:
> * s390x defines __kernel_old_gid_t to __kernel_gid_t (unsigned int)
> * s390x has a sys32_getgroups16() which looks JUST LIKE uid16.c
> sys_getgroups16
> * s390x does not define CONFIG_UID16, but seems to need it
The early versions of 64 bit s390x did not have the 31 bit emulation
layer. As long as only 64 bit code is executed you don't need the
16 bit uids/gids. Thats why is isn't defined.

> It seems to me that if we do:
> * s390x defines CONFIG_UID16
> * typedef __kernel_old_gid_t to u16
> * get rid of all the sys32_*16 stuff and just call the uid16.c function
I checked the code and didn't find any reason why this shouldn't work.
In fact with the 31 bit emulation layer the 64 bit kernel does need the
16 bit uid/gid system calls although only for the emulation. To make it
really perfect you could define CONFIG_UID16 dependent on
CONFIG_S390_SUPPORT. This saves a few bytes in the image if the emulation
support is not enabled.

> We could save a bit of duplicated code.  Patches that remove code are
> good, right?
Definitly.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


