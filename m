Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318502AbSHURSi>; Wed, 21 Aug 2002 13:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318503AbSHURSi>; Wed, 21 Aug 2002 13:18:38 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:63471 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318502AbSHURSh>; Wed, 21 Aug 2002 13:18:37 -0400
Subject: Re: Overcommit_memory logic fails when swap is off
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: josip@icase.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D63C9DE.7479D2E9@icase.edu>
References: <3D63C9DE.7479D2E9@icase.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 18:23:39 +0100
Message-Id: <1029950619.26845.106.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 18:11, Josip Loncaric wrote:
> Hello,
> 
> I've found some minor logic flaws in mmap.c::vm_enough_memory() which you may
> want to fix.  The problem is simple: overcommit_memory strategies "2" and "3"
> misbehave on machines operated without swap space.  Strategy "2" results in a
> very restrictive memory policy, while strategy "3" crashes the system because
> no memory can be allocated when total_swap_pages is zero.  May I suggest that

The behaviour it provides is correct and intentional. The documentation
is also quite plain on the fact you need swap for mode 3.

Since the kernel needs memory for its own purposes you cannot run
swapless with no overcommit and allow user space all of memory.

2.5 propses including the ability to set the %age between the 0% of mode
3, the 50 of mode 2 and upwards to things relevant in some embedded
system cases. So for 2.6 you will be able to tune it in different ways
according to precise understanding of workload.

As far as your hang goes I'd grab a standard 2.4.19 or 2.4.19-ac4 kernel
and try that.

