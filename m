Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311530AbSDDUak>; Thu, 4 Apr 2002 15:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311564AbSDDUaV>; Thu, 4 Apr 2002 15:30:21 -0500
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:59037 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S311530AbSDDUaJ>; Thu, 4 Apr 2002 15:30:09 -0500
Importance: Normal
Sensitivity: 
Subject: Re: Changes in s390x uaccess.h in 2.4.17+
To: zaitcev@redhat.com
Cc: linux-kernel@vger.kernel.org,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF002C3AD3.583E5011-ONC1256B91.006ED06D@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Thu, 4 Apr 2002 22:29:58 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 04/04/2002 22:30:01
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:

>The 2.4.17 patch comes with a change to uaccess.h, which
>contains the following:
>
>- * These functions have a non-standard call interface
>+ * These functions have standard call interface
>
>Does it look familiar to anyone? The change is in Marcelo's
>tree now, but I am curious what it actually does.

This is just a minor optimization.  The old code used to
have the core of __copy_to_user_asm etc. inline, and only
the exception fixup code in lib (__copy_to_user_fixup).

The point of this was to save the cost of a function call
for the default case.  However, because of various reasons
(tedious argument reloading, register pressure, code size)
this 'optimization' turned out to be actually worse than
just a plain function call, so we threw it out. The new code
simply implements __copy_to_user_asm completely in lib.

>The 2.4.17 patch readme says "This patch contains the current
>recommended kernel 2.4.7 code base (up to 2002-01-21),
>adapted to kernel 2.4.17.", but I cannot find this change
>in any published 2.4.7 patches. I am pretty sure there must
>be a good reason for the change, and it's interesting to
>know what it is.

The 2.4.17 patch also contains a number of minor cleanups
that should not cause any noticeable difference in behaviour,
like this one.

We did not find it worthwhile to backport this to 2.4.7;
we usually do that only for bugfixes.


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

