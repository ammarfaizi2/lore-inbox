Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVDFPGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVDFPGJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 11:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVDFPGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 11:06:09 -0400
Received: from relay02.pair.com ([209.68.5.16]:62985 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S262223AbVDFPGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 11:06:05 -0400
X-pair-Authenticated: 24.126.76.52
Message-ID: <4253FAC3.5010000@kegel.com>
Date: Wed, 06 Apr 2005 08:05:39 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible;MSIE 5.5; Windows 98)
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Marty Ridgeway <mridge@us.ibm.com>, linux-kernel@vger.kernel.org,
       ltp-list@lists.sourceforge.net, ltp-announce@lists.sourceforge.net
Subject: Re: [LTP] Re: [ANNOUNCE] April Release of LTP now Available
References: <OF98479217.2360E20E-ON85256FDA.00696BC9-86256FDA.00698E70@us.ibm.com> <20050406043001.3f3d7c1c.akpm@osdl.org>
In-Reply-To: <20050406043001.3f3d7c1c.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>> LTP-20050405
> 
> It seems to have an x86ism in it which causes the compile to fail on ppc64:
> 
> socketcall01.c: In function `socketcall':
> socketcall01.c:80: error: asm-specifier for variable `__sc_4' conflicts with asm clobber list

That might be a problem with your toolchain.
Other mentions of that error message on Google
suggest that it's due to a kernel header problem.
I bet your toolchain uses kernel headers from 2.4.21 or earlier...
check includes/asm-ppc64/unistd.h to see if it's got the
line
   /* On powerpc a system call basically clobbers the same registers like a
in it.  If not, it may be missing the patch mentioned below.

See
http://ozlabs.org/pipermail/linuxppc64-dev/2003-April/000211.html
http://ozlabs.org/pipermail/linuxppc-dev/2002-October/014492.html
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=9379
http://www.hu.kernel.org/pub/linux/kernel/v2.4/snapshots/incr/patch-2.4.22-bk57-bk58

- Dan

-- 
Trying to get a job as a c++ developer?  See http://kegel.com/academy/getting-hired.html
