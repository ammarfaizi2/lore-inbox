Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTEMFnD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 01:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbTEMFnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 01:43:03 -0400
Received: from franka.aracnet.com ([216.99.193.44]:51145 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262942AbTEMFnB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 01:43:01 -0400
Date: Mon, 12 May 2003 20:41:22 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: 2.5.69-mjb1
Message-ID: <17070000.1052797281@[10.10.2.4]>
In-Reply-To: <20030513012346.GQ19053@holomorphy.com>
References: <9380000.1052624649@[10.10.2.4]> <20030512132939.GF19053@holomorphy.com> <21850000.1052743254@[10.10.2.4]> <3EBFB82B.8040509@us.ibm.com> <20030513012346.GQ19053@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Wow, that's intuitive :)
>> They're trying to access the variables that have been pushed onto the
>> top of the stack.  The thread_info field points to the bottom of the
>> kernel's stack (no matter how big it is).  I don't know where the -5 and
>> -2 come from.  It needs a big, fat stinking comment.
> 
> I'm not 100% convinced it DTRT on modern kernels. I vaguely wonder if
> the following would be more appropriate. Shame the typedef isn't there
> yet; the _struct suffix is an eyesore.


So are the new bits of the patch related to the KSTK_E* bit?
They don't seem to be ... however, this bit looks really good:

> -#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1019])
> -#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1022])
> +#define KSTK_EIP(task)	((task)->thread.eip)
> +#define KSTK_ESP(task)	((task)->thread.esp)

Can I assume it's tested, or does it need someone to do that?

Thanks,

M.

