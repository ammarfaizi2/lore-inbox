Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265995AbUAKWKm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 17:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUAKWKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 17:10:42 -0500
Received: from adsl-67-114-19-185.dsl.pltn13.pacbell.net ([67.114.19.185]:48007
	"EHLO bastard.smallmerchant.com") by vger.kernel.org with ESMTP
	id S265995AbUAKWKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 17:10:40 -0500
Message-ID: <4001C9DC.4070505@tupshin.com>
Date: Sun, 11 Jan 2004 14:10:36 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla Thunderbird 0.5a (20031216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: The NeverGone <never@delfin.klte.hu>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: UML (user-mode-linux) kernel-2.6.x
References: <Pine.LNX.4.58.0401112222030.1401@localhost> <4001C68D.4010108@tupshin.com> <Pine.LNX.4.58.0401112300020.1585@localhost>
In-Reply-To: <Pine.LNX.4.58.0401112300020.1585@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NeverGone wrote:

>On Sun, 11 Jan 2004, Tupshin Harper wrote:
>
>  
>
>>The guest UML kernel??? Works for me. What guest kernel are you running?
>>    
>>
>
>The guest UML using 2.4.23, and it works properly with 2.4.24 host kernel,
>but not with 2.6.x ...
>  
>
Is that guest 2.4.23 kernel stock, with only the mentioned patch (pasted 
below) applied?

Are you absolutely positive that you rebuilt that guest kernel with the 
patch???(I'm guessing that this is really the problem)

Are you still getting the same error message? ("I'm tracing myself...")

-Tupshin

--- 1.5/arch/um/os-Linux/process.c      Sat Jan 18 12:29:27 2003
+++ 1.6/arch/um/os-Linux/process.c      Thu Oct  2 14:27:57 2003
@@ -7,6 +7,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <signal.h>
+#include <linux/unistd.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include "os.h"
@@ -87,7 +88,8 @@
 
 void os_usr1_process(int pid)
 {
-       kill(pid, SIGUSR1);
+       syscall(__NR_tkill, pid, SIGUSR1);
+/*     tkill(pid, SIGUSR1);*/
 }
 
 int os_getpid(void)




