Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312322AbSCUAa0>; Wed, 20 Mar 2002 19:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312317AbSCUAaQ>; Wed, 20 Mar 2002 19:30:16 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:57342 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312319AbSCUAaI>; Wed, 20 Mar 2002 19:30:08 -0500
Importance: Normal
Sensitivity: 
X-Mailer: Lotus Notes Release 5.0.4  June 8, 2000
MIME-Version: 1.0
Subject: Re: Bad Illegal instruction traps on dual-Xeon (p4) Linux Dell box
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Message-ID: <OF144873DD.BC645CDA-ON87256B83.0000EE37@boulder.ibm.com>
From: "James Washer" <washer@us.ibm.com>
Date: Wed, 20 Mar 2002 16:30:18 -0800
X-MIMETrack: Serialize by Router on D03NM038/03/M/IBM(Release 5.0.9a |January 7, 2002) at
 03/20/2002 05:30:06 PM
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The iTLB would be flushed when he did the reload of cr3 ( per your
suggestion ) UNLESS the G bit was set.
I suppose theres some small chance, that at the time this instruction was
first cached and its corresponding iTLB entry was loaded, the G bit may
have been set.. Seems unlikely. but I'll hack up something to
unconditionally flush the iTLB.

 - jim

Alan Cox <alan@lxorguk.ukuu.org.uk>@vger.kernel.org on 03/20/2002 04:04:51
PM

Sent by:    linux-kernel-owner@vger.kernel.org


To:    kurt@garloff.de (Kurt Garloff)
cc:    tepperly@llnl.gov (Tom Epperly), linux-kernel@vger.kernel.org (Linux
       kernel list)
Subject:    Re: Bad Illegal instruction traps on dual-Xeon (p4) Linux Dell
       box



> disassembly?
> AFAICS, its a push %ebp instruction, which should not be illegal. So
either
> your stack is overflowing or my suspicion with the defect CPU is
applicable.

Or somehow the I/D TLB's got messed up and the ITLB for that entry is now
wrong.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



