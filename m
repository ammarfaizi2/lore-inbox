Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135886AbRDTM0T>; Fri, 20 Apr 2001 08:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135887AbRDTM0J>; Fri, 20 Apr 2001 08:26:09 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:44050 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S135886AbRDTMZx>;
	Fri, 20 Apr 2001 08:25:53 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15072.11026.385642.667425@argo.ozlabs.ibm.com.au>
Date: Fri, 20 Apr 2001 22:26:58 +1000 (EST)
To: tom_gall@vnet.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: pmd_alloc, pte_alloc, Was Re: 2.4.3 and Alpha
In-Reply-To: <3AD77FBF.874F8305@vnet.ibm.com>
In-Reply-To: <E14oBht-0003dd-00@the-village.bc.nu>
	<3AD77FBF.874F8305@vnet.ibm.com>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tom_gall@vnet.ibm.com writes:

>   Basically in the pmd, it would seem that the current design in 2.4.3 forces
> you to have pointers in there. Currently in our source we're using offsets
> instead of a 64 bit pointer... this of course saved us from having to alloc 2
> contiguous pages in memory. 

Nope, the representation of the pgd/pmd/pte entries is entirely up to
you (us :).  The pmd entries for example are accessed through pmd_none,
pmd_present, pte_offset, etc., and are set with pmd_populate.  Those
functions are all defined in asm/pgtable.h and asm/pgalloc.c.  So you
can make the representation whatever you like as long as those
functions all do the right thing.  Same goes for the pgd and pte
levels.

Paul.
