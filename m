Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273714AbSISWwN>; Thu, 19 Sep 2002 18:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273730AbSISWwM>; Thu, 19 Sep 2002 18:52:12 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:28327 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S273714AbSISWwL>;
	Thu, 19 Sep 2002 18:52:11 -0400
Subject: 
To: akpm@digeo.com, taka@valinux.co.jp
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFDCC62A37.55EFB5E3-ON87256C39.007C43C5@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Thu, 19 Sep 2002 17:56:42 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 09/19/2002 04:56:44 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote ...

>It seems that movsl works acceptably with all alignments on AMD
>hardware, although this needs to be checked with more recent machines.


>movsl is a (bad) loss on PII and PIII for all alignments except 8&8.
>Don't know about P4 - I can test that in a day or two.


>I expect that a minimal, 90% solution would be just:


>fancy_copy_to_user(dst, src, count)
>{
>        if (arch_has_sane_movsl || ((dst|src) & 7) == 0)
>                movsl_copy_to_user(dst, src, count);
>        else
>                movl_copy_to_user(dst, src, count);
>}

>and

>#ifndef ARCH_HAS_FANCY_COPY_USER
>#define fancy_copy_to_user copy_to_user
>#endif


>and we really only need fancy_copy_to_user in a handful of
>places - the bulk copies in networking and filemap.c. For all
>the other call sites it's probably more important to keep the
>code footprint down than it is to squeeze the last few drops out
>of the copy speed.


>Mala Anand has done some work on this. See
>http://www.uwsg.iu.edu/hypermail/linux/kernel/0206.3/0100.html


><searches> Yes, I have a copy of Mala's patch here which works
>against 2.5.current. Mala's patch will cause quite an expansion
>of kernel size; we would need an implementation which did not
>use inlining. This work was discussed at OLS2002. See
>http://www.linux.org.uk/~ajh/ols2002_proceedings.pdf.gz

I will move the code from uaccess.h (inline) to usercopy.c (routine)
and will post it soon. It is in my list of things to do.

Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088




