Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbSLLNKl>; Thu, 12 Dec 2002 08:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264624AbSLLNKl>; Thu, 12 Dec 2002 08:10:41 -0500
Received: from mg02.austin.ibm.com ([192.35.232.12]:36268 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S264610AbSLLNKk>; Thu, 12 Dec 2002 08:10:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] dm.c - device-mapper I/O path fixes
Date: Thu, 12 Dec 2002 06:30:56 -0600
X-Mailer: KMail [version 1.2]
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lvm-devel@sistina.com
References: <02121016034706.02220@boiler> <02121108060005.29515@boiler> <15863.43576.467511.255317@argo.ozlabs.ibm.com>
In-Reply-To: <15863.43576.467511.255317@argo.ozlabs.ibm.com>
MIME-Version: 1.0
Message-Id: <02121206305600.05277@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 December 2002 15:12, Paul Mackerras wrote:
> Kevin Corry writes:
> > Storing an int is *not* atomic unless it is declared as atomic_t and you
> > use the appropriate macros (see include/asm-*/atomic.h). Remember, we are
> > talking about a field in a data structure that can be accessed from
> > multiple threads on multiple CPUs.
>
> As a practical matter, I believe that storing an int to an int-aligned
> address _is_ actually atomic on any CPU that can run Linux.  The
> PowerPC architecture spec requires that single-word (i.e. 32-bit)
> aligned stores are atomic, for instance, and I think that would be the
> case on any other sane architecture as well.

Given the constraints of having properly aligned data on an SMP machine with 
the correct cache-coherency hardware, then yes, I will agree that such stores 
should be atomic. However, it has been my understanding that these conditions 
cannot be guaranteed on every architecture. Thus we're stuck with atomic_t's 
so everyone can play nicely together.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
