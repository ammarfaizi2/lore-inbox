Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267470AbRGPSBr>; Mon, 16 Jul 2001 14:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267472AbRGPSBi>; Mon, 16 Jul 2001 14:01:38 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:50192 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S267468AbRGPSBY>;
	Mon, 16 Jul 2001 14:01:24 -0400
Message-ID: <938F7F15145BD311AECE00508B7152DB034C48DB@vts007.vertis.nl>
From: Rolf Fokkens <FokkensR@vertis.nl>
To: "'drepper@cygnus.com'" <drepper@cygnus.com>
Cc: "'alan@lxorguk.ukuu.org.uk'" <alan@lxorguk.ukuu.org.uk>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: PATCH: /proc/sys/kernel/hz
Date: Mon, 16 Jul 2001 20:00:19 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> writes:

>> Some software (like procps) needs the HZ constant in the kernel. It's
>> sometimes determined by counting jiffies during a second. The attached
patch
>> just "publishes" the HZ constant in /proc/sys/kernel/hz.
>
>And what is wrong with
>  getconf CLK_TCK
>or programmatically
>  hz = sysconf (_SC_CLK_TCK);

In short: it doesn't work: it reads 100 while I changed it to 1024 in my
kernel.

> Update your libc and this info will come from the kernel.

Neither RedHat 6.2 (glibc-2.1.3) nor SuSE 7.2 (glibc-2.2.2) works, so what
glibc version are you suggesting?

And suppose I have the right glibc, then the kernel may become a little
confusing:

bash# cd linux-2.4.6
bash# find . -name "*.c" -exec grep -q CLK_TCK {} \; -print
#define   _SC_CLK_TCK             3
./arch/sparc/kernel/sys_sunos.c
#define   _SC_CLK_TCK             3
./arch/sparc64/kernel/sys_sunos32.c
#define	SOLARIS_CONFIG_CLK_TCK			7
./arch/sparc64/solaris/misc.c
bash# find . -name "*.h" -exec grep CLK_TCK {} \; -print
#define   _SC_CLK_TCK             3
./include/asm-sparc64/unistd.h

Seems OK for sparc and maybe for solaris, for others it's a mess.

Rolf
