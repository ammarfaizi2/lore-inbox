Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWJLVni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWJLVni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWJLVni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:43:38 -0400
Received: from farad.aurel32.net ([82.232.2.251]:5613 "EHLO farad.aurel32.net")
	by vger.kernel.org with ESMTP id S1751082AbWJLVnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:43:37 -0400
Message-ID: <452EB653.7070604@aurel32.net>
Date: Thu, 12 Oct 2006 23:40:35 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: SYS_personality does not work correctly on mips(el)64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On mips(el), when doing multiple call to the syscall SYS_personality in 
order to get the current personality (using 0xffffffff for the first 
argument), on a 64-bit kernel, the second and subsequent syscalls are 
failing. That works correctly with a 32-bit kernels and on other 
architectures.

Here is a small test below:

#include <sys/personality.h>
#include <stdio.h>

void main()
{
   printf("%i\n", personality(0xFFFFFFFF));
   printf("%i\n", personality(0xFFFFFFFF));
}


Bye,
Aurelien
-- 
   .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
  : :' :  Debian developer           | Electrical Engineer
  `. `'   aurel32@debian.org         | aurelien@aurel32.net
    `-    people.debian.org/~aurel32 | www.aurel32.net
