Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267451AbUIUNsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbUIUNsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 09:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267223AbUIUNsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 09:48:12 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4481 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267451AbUIUNr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 09:47:58 -0400
Date: Tue, 21 Sep 2004 09:47:20 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Peter Seiderer <ps.report@gmx.net>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG][2.6.8.1] Nevver dump core while /dev/men is mmaped
In-Reply-To: <11831.1095772794@www24.gmx.net>
Message-ID: <Pine.LNX.4.53.0409210944320.3495@chaos.analogic.com>
References: <11831.1095772794@www24.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2004, Peter Seiderer wrote:

> Hello,
> the following short program stops my computer immediately (no more
> input, telnet etc. possible):
>
> --- begin ---
> #include <stdio.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <sys/mman.h>
> #include <assert.h>
>
> int main(int argc, char *argv[]) {
> 	int fd;
> 	assert((fd = open("/dev/mem", O_RDWR)) != (-1));
>
> 	size_t s = 67108864;
> 	void *m;
> 	assert((m = mmap(NULL, s, PROT_READ|PROT_WRITE, MAP_SHARED, fd,
> 0xd0000000)) != NULL);
         ^^^^^^^^^^^^^^^
 Incorrect. mmap() returns MAP_FAILED, (void *)-1, when it fails, not
NULL, (void *)0.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

