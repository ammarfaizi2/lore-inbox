Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267662AbUIUOTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267662AbUIUOTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 10:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267696AbUIUOTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 10:19:05 -0400
Received: from pop.gmx.net ([213.165.64.20]:1235 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267545AbUIUOSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 10:18:49 -0400
Date: Tue, 21 Sep 2004 16:18:47 +0200 (MEST)
From: "Peter Seiderer" <ps.report@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <Pine.LNX.4.53.0409210944320.3495@chaos.analogic.com>
Subject: Re: [BUG][2.6.8.1] Nevver dump core while /dev/men is mmaped
X-Priority: 3 (Normal)
X-Authenticated: #23711316
Message-ID: <18354.1095776327@www24.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 21 Sep 2004, Peter Seiderer wrote:
> 
> > Hello,
> > the following short program stops my computer immediately (no more
> > input, telnet etc. possible):
> >
> > --- begin ---
> > #include <stdio.h>
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <fcntl.h>
> > #include <sys/mman.h>
> > #include <assert.h>
> >
> > int main(int argc, char *argv[]) {
> > 	int fd;
> > 	assert((fd = open("/dev/mem", O_RDWR)) != (-1));
> >
> > 	size_t s = 67108864;
> > 	void *m;
> > 	assert((m = mmap(NULL, s, PROT_READ|PROT_WRITE, MAP_SHARED, fd,
> > 0xd0000000)) != NULL);
>          ^^^^^^^^^^^^^^^
>  Incorrect. mmap() returns MAP_FAILED, (void *)-1, when it fails, not
> NULL, (void *)0.
> 
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
>             Note 96.31% of all statistics are fiction.
> 

Shit, you are right! But did not change anything on the bad kernel
behaviour.....the mmap succeeds, and the kernel hangs in elf_core_dump.
Peter

-- 
+++ GMX DSL Premiumtarife 3 Monate gratis* + WLAN-Router 0,- EUR* +++
Clevere DSL-Nutzer wechseln jetzt zu GMX: http://www.gmx.net/de/go/dsl

