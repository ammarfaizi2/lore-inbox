Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261778AbTCGVCx>; Fri, 7 Mar 2003 16:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261781AbTCGVCx>; Fri, 7 Mar 2003 16:02:53 -0500
Received: from faui11.informatik.uni-erlangen.de ([131.188.31.2]:10884 "EHLO
	faui11.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S261778AbTCGVCw>; Fri, 7 Mar 2003 16:02:52 -0500
From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
Message-Id: <200303072113.WAA08451@faui11.informatik.uni-erlangen.de>
Subject: Re: [PATCH] s390 (5/7): kmalloc arguments.
To: zaitcev@redhat.com
Date: Fri, 7 Mar 2003 22:13:23 +0100 (MET)
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:

>What does GFP_DMA do on s390 and s390x?

On s390, nothing.

On s390x, it makes sure the allocated memory resides at
addresses below 2 GB.  This is necessary, as many of the
I/O subsystem data structures as defined by the hardware
contain pointer fields that are still 31-bit, even on
64-bit machines.  Thus we have to make sure those data
structures are allocated below 2 GB.  Using the GFP_DMA
mechanism for that purpose seemed to be the way to go ...

Note that contrary to the usual purpose of GFP_DMA on Intel,
the actual *data* that is being transferred via the I/O 
subsystem can reside at arbitrary addresses (which are 
specified via indirect-addressing lists); it is only the 
control data structures that need to go below 2 GB.

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
