Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316588AbSFZOCm>; Wed, 26 Jun 2002 10:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316589AbSFZOCl>; Wed, 26 Jun 2002 10:02:41 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:40201 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S316588AbSFZOCk>;
	Wed, 26 Jun 2002 10:02:40 -0400
Date: Wed, 26 Jun 2002 22:54:00 +0900 (JST)
Message-Id: <20020626.225400.74747335.taka@valinux.co.jp>
To: akpm@zip.COM.AU
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: efficient copy_to_user and copy_from_user routines in Linux
 Kernel
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <200206251743.VAA00510@sex.inr.ac.ru>
References: <3D18A26A.73E6DD07@zip.com.au>
	<200206251743.VAA00510@sex.inr.ac.ru>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a patch which let sendmsg use copy_from_user instead of
csum_and_copy_from_user when a NIC supports HW-checksumming.
It just works on kernel 2.4, I haven't ported it on kernel 2.5 yet.
If you want it I'll port it after I come back from OTTAWA.

You can get the patch against kernel 2.4 from
ftp://ftp.valinux.co.jp/pub/people/taka/tune/2.4.17/va-udptcpchecksum-2.4.17-test1.patch

Would you try it?

> > I changed tcp to use a different copy if either source or dest were
> > not eight-byte aligned, and found that the resulting improvement
> > across a mixed networking load was only 1%.  Your numbers are higher,
> > so perhaps there are different alignments in the mix...
> 
> Did you look at sender or changed both of the functions?
> 
> After that accident TCP was changed and it does not use copy_from_user more,
> it does copy_and_csum even when no checksum is required. So, his results
> on sender side (except for strange anomaly at msg size 8K) just confirm
> nil effect of copy_from_user.
> 
> What's about copy_to_user, we forgot about this at all,
> worrying mostly about sender side. :-)

Thank you,
Hirokazu Takahashi.
