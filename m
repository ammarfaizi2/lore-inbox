Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVAIJVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVAIJVO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 04:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVAIJVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 04:21:14 -0500
Received: from omega.datac.cz ([81.31.15.4]:54150 "EHLO omega.datac.cz")
	by vger.kernel.org with ESMTP id S261568AbVAIJVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 04:21:10 -0500
Message-ID: <41E0F76D.7080805@feix.cz>
Date: Sun, 09 Jan 2005 10:20:45 +0100
From: Michal Feix <michal@feix.cz>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Conflicts in kernel 2.6 headers and {glibc,Xorg}
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello evereyone!

First, I'm not on kernel mailing list so please CC any replies to me. 
Thank you.

Yesterday I was recompiling my Linux from Scratch distribution for the 
first time with Linux kernel 2.6.10 headers as a base for glibc. I've 
found, that glibc (and XOrg later on too) won't compile, as there is a 
conflict in certain functions or macros that glibc and Kernel headers 
both define.

One was in asm/bitops.h (strictly speaking, asm-i386/bitops.h) named 
__ffs, which is defined with unsigned long (both for return type and 
parameter) in linux kernel, but as int in glibc sources. Others were in 
asm/system.h. Macro mb() and nop() which conflicts with Xorg sources and 
with one part of KDE as well (mb() macro and kdepim sources).

Now I am a bit confused. To force my glibc, Xorg and KDE to compile 
cleanly, I had to rename these in kernel headers in my /usr/include/asm 
directory, so they are no longer conflicting (which of course breaks the 
  rest of kernel header files, that use these macros), but since I was 
changing only files in /usr/include/asm, it's probably a "no harm done" 
change, as my Kernel has it's own copy of these files.

My question is: is this a bug in glibc and Xorg sources that they 
declare macros and functions with the same name as kernel headers? I 
believe not, as it worked cleanly with kernel 2.4 headers and glibc was 
first to use these names. :)

Or is it a bug in kernel 2.6 headers, which should be fixed by including 
these functions and macros into __KERNEL__ block, so they will not 
collide with userspace sources?

Thanks for reading this to the end... :)

-- 
Michal Feix
michal@feix.cz
