Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268227AbUGXB4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268227AbUGXB4e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 21:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268228AbUGXB4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 21:56:34 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:12999 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S268227AbUGXB4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 21:56:33 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.27+stdarg+gcc-3.4.1 
In-reply-to: Your message of "Sat, 24 Jul 2004 02:14:21 +0200."
             <20040724001421.GC8560@werewolf.able.es> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 24 Jul 2004 11:56:21 +1000
Message-ID: <808.1090634181@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jul 2004 02:14:21 +0200, 
"J.A. Magallon" <jamagallon@able.es> wrote:
>With gcc-3.4.1 I get the following error when building 2.4.27-rc3.
>Any suggestion ?
>
>gcc -D__KERNEL__ -nostdinc -iwithprefix include -I/usr/src/linux-2.4.27-rc3-jam1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -mpreferred-stack-boundary=2 -msoft-float -march=pentium3 -fno-unit-at-a-time   -DKBUILD_BASENAME=do_mounts -c -o init/do_mounts.o init/do_mounts.c
>init/do_mounts.c: In function `change_floppy':
>init/do_mounts.c:424: error: `va_list' undeclared (first use in this function)

Looks like you applied some additional patches over 2.4.27-rc3, that
command line is non-standard.  Run

gcc -D__KERNEL__ -nostdinc -iwithprefix include \
    -I/usr/src/linux-2.4.27-rc3-jam1/include -Wall \
    -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common \
    -fomit-frame-pointer -mpreferred-stack-boundary=2 -msoft-float \
    -march=pentium3 -fno-unit-at-a-time   -DKBUILD_BASENAME=do_mounts -c \
    -o init/do_mounts.s init/do_mounts.c -E

Mail the results from

egrep -B20 -A5 'va_list|stdarg\.h' init/do_mounts.i

