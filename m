Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTELPow (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 11:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbTELPow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 11:44:52 -0400
Received: from franka.aracnet.com ([216.99.193.44]:62659 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262221AbTELPou
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 11:44:50 -0400
Date: Mon, 12 May 2003 06:43:11 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.69-mjb1
Message-ID: <24330000.1052746990@[10.10.2.4]>
In-Reply-To: <3EBFBEF5.6050600@us.ibm.com>
References: <9380000.1052624649@[10.10.2.4]> <20030512132939.GF19053@holomorphy.com> <21850000.1052743254@[10.10.2.4]> <20030512150309.GG19053@holomorphy.com> <23510000.1052744845@[10.10.2.4]> <3EBFBEF5.6050600@us.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, May 12, 2003 08:34:13 -0700 Dave Hansen <haveblue@us.ibm.com> wrote:

> Martin J. Bligh wrote:
>> OK, so maybe I'm still asleep, but I don't see why the hardcoded
>> magic constant (grrr) is 4096 in mainline, when the stacksize is 8K.
>> Presumably the 1019*4 makes up the rest of it? Maybe the real question 
>> is what the hell was whoever wrote that in the first place smoking ? ;-)
>> Why on earth would you skip halfway through the stack with one stupid 
>> magic constant, and then the rest of the way with another? 
> 
> You can go ask the author:
> 
> http://linus.bkbits.net:8080/linux-2.5/diffs/include/asm-i386/processor.h@1.12?nav=index.html|src/|src/include|src/include/asm-i386|hist/include/asm-i386/processor.h

-#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)))[1019])
-#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)))[1022])
...
+#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1019])
+#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1022])

Nope, not his fault, really.

M.
