Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315191AbSFITeF>; Sun, 9 Jun 2002 15:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314929AbSFITcs>; Sun, 9 Jun 2002 15:32:48 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:48637 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S315191AbSFIT3h>; Sun, 9 Jun 2002 15:29:37 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.44.0206091257340.8715-100000@hawkeye.luckynet.adm> 
To: Thunder from the hill <thunder@ngforever.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Dave Jones <davej@suse.de>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
Subject: Re: [patch] fat/msdos/vfat crud removal 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 09 Jun 2002 20:29:00 +0100
Message-ID: <2166.1023650940@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


thunder@ngforever.de said:
>  Stop! The reason for _some_ includes there is actually to keep some
> definitions in sync with the kernel, e.g. errno values! Stopping them
> altogether is a Really Bad Thing[tm], IMO, since it means users will
> have  to get a new glibc with almost every kernel they have (don't
> tell me we  don't change much!).

Er, no. If you randomly reassign errno values, the world breaks.
Don't even contemplate it.

The _only_ thing that userspace could possibly pick from the kernel headers 
is the ABI. But if the ABI changes, that _must_ be a carefully-considered 
thing.

To that end, we should put '#ifndef __KERNEL__ #error' into all kernel
headers, and C libraries should maintain a _separate_ set of headers which
contain only the ABI definitions and are suitable for userspace. I believe 
dietlibc already does this, and recent Red Hat distributions contain a 
'glibc-kernheaders' package with a slightly-sanitised version of kernel 
headers, which should become more sanitised over time.

--
dwmw2


