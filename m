Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315191AbSEFVHO>; Mon, 6 May 2002 17:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315192AbSEFVHN>; Mon, 6 May 2002 17:07:13 -0400
Received: from quechua.inka.de ([212.227.14.2]:45944 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S315191AbSEFVHM>;
	Mon, 6 May 2002 17:07:12 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: modversion.h improvement suggestion
In-Reply-To: <E174OQu-0007H2-00@smtp.web.de> <8447.1020642180@ocs3.intra.ocs.com.au>
Organization: private Linux site, southern Germany
Date: Mon, 06 May 2002 23:03:34 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E174pdv-0001rU-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The build instructions for third party modules should say something
> like
>
>   If your kernel was built with CONFIG_MODVERSIONS=y then add these
>   flags to the build for this module
>
>   -DMODVERSIONS -include kernel_source_tree/linux/modversions.h

or even better, pick up the _complete_ compilation rule from the
kernel Makefile, since this is (unfortunately) by now the only way to
get all compiler options right.

I do it this way (in a configure.in for an external module):
KSRC is the kernel source location.

  cp $KSRC/Makefile conftest.make
  echo -e "conftest.CC:" >>conftest.make
  echo -e "\t@echo \$(CC)" >>conftest.make
  echo -e "conftest.CFLAGS:" >>conftest.make
  echo -e "\t@echo \$(CFLAGS) \$(MODFLAGS)" >>conftest.make
  here=`pwd`
  NKCC=`cd $KSRC; $MAKE -s -f $here/conftest.make conftest.CC`
  NKCFLAGS=`cd $KSRC; $MAKE -s -f $here/conftest.make conftest.CFLAGS`

i.e. copy the main Makefile, add a few rules to just echo the flags,
and then invoke it in the original place (since it depends on that).
We should really have a more elegant way to extract this info from the
main Makefile.

> In any case, modversions.h will disappear in kbuild 2.5.

which leaves hope this issue will be addressed...

Olaf



