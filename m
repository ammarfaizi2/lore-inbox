Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270309AbRHYTCf>; Sat, 25 Aug 2001 15:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270386AbRHYTCZ>; Sat, 25 Aug 2001 15:02:25 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:56257 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S270309AbRHYTCM>;
	Sat, 25 Aug 2001 15:02:12 -0400
Message-Id: <200108251903.f7PJ3Zl21152@www.2ka.mipt.ru>
Date: Sat, 25 Aug 2001 23:04:09 +0400
From: Evgeny Polyakov <johnpol@2ka.mipt.ru>
To: Bob McElrath <mcelrath@draal.physics.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: basic module bug
In-Reply-To: <20010825105645.T21497@draal.physics.wisc.edu>
In-Reply-To: <20010825005957.Q21497@draal.physics.wisc.edu> <200108251122.f7PBMvl17221@www.2ka.mipt.ru> <20010825102756.R21497@draal.physics.wisc.edu>
	<20010825105645.T21497@draal.physics.wisc.edu>
Reply-To: johnpol@2ka.mipt.ru
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.7; Linux 2.4.9; i686)
Organization: MIPT
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Sat, 25 Aug 2001 10:56:45 -0500
Bob McElrath <mcelrath@draal.physics.wisc.edu> wrote:

BM> Where can I find a "skeleton" kernel module for comparison?

You wrote it some strins below.

BM> Here's a simpler case more compatible with the options passed to gcc
BM> when the kernel is compiled:

BM> /* test module.  Compile with: gcc -c -I/usr/src/linux/include
BM> * -D__KERNEL__ -DMODULE test.c  */
BM> #include <linux/module.h>
BM> #include <linux/kernel.h>
BM> #include <asm/current.h>
BM> #ifdef MODULE
BM> int init_module(void)
BM> #else
BM> int test_init(void)
BM> #endif
BM> {
BM> return 0;
BM> }
BM> #ifdef MODULE
BM> void cleanup_module(void)
BM> {
BM> }
BM> #endif

BM> (0)<mcelrath@draal:/home/mcelrath> gcc -c -I/usr/src/linux/include
-D__KERNEL__
BM> -DMODULE test.c
BM> In file included from test.c:5:
BM> /usr/src/linux/include/asm/current.h:4: warning: call-clobbered
register
BM> used for global register variable

[s0mbre@Sombre /tmp]$ gcc ./test.c -c -o ./test.o -D__KERNEL__ -DMODULE
-I/usr/src/linux/include
[s0mbre@Sombre /tmp]$ 

All is OK.

BM> Yet a simpler case:

BM> #include <asm/current.h>
BM> int main() {}

[s0mbre@Sombre /tmp]$ gcc ./test1.c -o ./test1
[s0mbre@Sombre /tmp]$ cat ./test1.c
#include <asm/current.h>
int main()
        {}
[s0mbre@Sombre /tmp]$

BM> Generates the same warning message.  Why does this message not occur
BM> when compiling the kernel?

I have no problem.
But if i would have this problem, i 
a) rewrite include dir and check symlink
b) reinstall system :)

BM> Cheers,
BM> -- Bob

---
WBR. //s0mbre
