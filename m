Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267297AbSLKVEr>; Wed, 11 Dec 2002 16:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbSLKVEr>; Wed, 11 Dec 2002 16:04:47 -0500
Received: from dp.samba.org ([66.70.73.150]:64930 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267297AbSLKVEq>;
	Wed, 11 Dec 2002 16:04:46 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15863.43576.467511.255317@argo.ozlabs.ibm.com>
Date: Thu, 12 Dec 2002 08:12:24 +1100
To: Kevin Corry <corryk@us.ibm.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lvm-devel@sistina.com
Subject: Re: [PATCH] dm.c - device-mapper I/O path fixes
In-Reply-To: <02121108060005.29515@boiler>
References: <02121016034706.02220@boiler>
	<20021211141820.GA21461@reti>
	<200212111435.gBBEYWa06788@Port.imtp.ilyichevsk.odessa.ua>
	<02121108060005.29515@boiler>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Corry writes:

> Storing an int is *not* atomic unless it is declared as atomic_t and you use 
> the appropriate macros (see include/asm-*/atomic.h). Remember, we are talking 
> about a field in a data structure that can be accessed from multiple threads 
> on multiple CPUs.

As a practical matter, I believe that storing an int to an int-aligned
address _is_ actually atomic on any CPU that can run Linux.  The
PowerPC architecture spec requires that single-word (i.e. 32-bit)
aligned stores are atomic, for instance, and I think that would be the
case on any other sane architecture as well.

The language lawyers would probably agree with you, though.

Regards,
Paul.
