Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293503AbSCUHaK>; Thu, 21 Mar 2002 02:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293513AbSCUHaA>; Thu, 21 Mar 2002 02:30:00 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:30434 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S293503AbSCUH3v>; Thu, 21 Mar 2002 02:29:51 -0500
Date: Thu, 21 Mar 2002 09:19:41 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: James Washer <washer@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Bad Illegal instruction traps on dual-Xeon (p4) Linux Dell box
In-Reply-To: <OF144873DD.BC645CDA-ON87256B83.0000EE37@boulder.ibm.com>
Message-ID: <Pine.LNX.4.44.0203210912020.1140-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, James Washer wrote:

> 
> The iTLB would be flushed when he did the reload of cr3 ( per your
> suggestion ) UNLESS the G bit was set.
> I suppose theres some small chance, that at the time this instruction was
> first cached and its corresponding iTLB entry was loaded, the G bit may
> have been set.. Seems unlikely. but I'll hack up something to
> unconditionally flush the iTLB.

I find vol3 somewhat confusing in this regard...

P104 - The only ways to deterministically invalidate global page entries 
are as follows:
o Clear the PGE flag and then invalidate the TLBs.
o Execute the INVLPG instruction to invalidate individual page-directory 
  or page-table entries in the TLBs.
o Write to control register CR3 to invalidate all TLB entries.

Then on page 381.

The following operations invalidate all TLB entries except global entries. 
(A global entry is one for which the G (global) flag is set in its 
corresponding page-directory or page-table entry. The global flag was 
introduced into the IA-32 architecture in the P6 family processors, see 
Section 10.5.,  Cache Control .)

o Writing to control register CR3.
o A task switch that changes control register CR3.

I would reckon reference 1 (p104) is incorrect, can someone shed some 
light?

Thanks,
	Zwane


