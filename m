Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbUCDNV3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbUCDNV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:21:29 -0500
Received: from pxy1allmi.all.mi.charter.com ([24.247.15.38]:14464 "EHLO
	proxy1.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S261886AbUCDNVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:21:22 -0500
Message-ID: <40472D4A.9000607@quark.didntduck.org>
Date: Thu, 04 Mar 2004 08:21:14 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Igor Yu. Zhbanov" <bsg@uniyar.ac.ru>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: __buggy_fxsr_alignment() not found.
References: <Pine.GSO.3.96.SK.1040304140003.4028A-100000@univ.uniyar.ac.ru>
In-Reply-To: <Pine.GSO.3.96.SK.1040304140003.4028A-100000@univ.uniyar.ac.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Igor Yu. Zhbanov wrote:
> On Mon, 1 Mar 2004, Randy.Dunlap wrote:
> 
> 
>>On Sun, 29 Feb 2004 20:02:12 +0300 (MSK) Igor Yu. Zhbanov wrote:
>>
>>| Hello!
>>| My system is:
>>| AMD K6-II 450
>>| Linux-2.4.24
>>| glibc-2.2.5
>>| 
>>| I cannot compile 2.4.24 kernel because linker says:
>>| init/main.o: In function `check_fpu':
>>| init/main.o(.text.init+0x53): undefined reference to `__buggy_fxsr_alignment'
>>| 
>>| It's prototype is in inculude/asm-i386/bugs.h:
>>| -----
>>| /* Enable FXSR and company _before_ testing for FP problems. */
>>|         /*
>>|          * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
>>|          */
>>|         if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
>>|               extern void __buggy_fxsr_alignment(void);
>>|               __buggy_fxsr_alignment();
>>| -----
>>| But there is no realisation of this function in source files.
>>| When I comment the lines above, everything works.
>>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>This function is not supposed to be defined anywhere.
>>It is there to indicate a build error and to keep the kernel
>>build from completing successfully.
>>
>>For some reason, with your config (and CPU arch.) and compiler,
>>the 'fxsave' field is not on a 16-byte alignment.  Have you applied
>>any patches to 2.4.24?  What version of gcc are you using (gcc -v)?
>>
> 
> 
> My compiler is pgcc-2.95.3 (gcc optimized for Pentium).
> And I use security patch from OpenWall.
> Here is my config file:

Get a newer compiler.  It's either not getting the alignment of 
thread.i387.fxsave right or not optimizing the test away properly.

--
				Brian Gerst
