Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130380AbQLGRw7>; Thu, 7 Dec 2000 12:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131220AbQLGRwo>; Thu, 7 Dec 2000 12:52:44 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:1764 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130380AbQLGRwi>; Thu, 7 Dec 2000 12:52:38 -0500
Date: Thu, 7 Dec 2000 17:55:07 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andi Kleen <ak@suse.de>
cc: richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Why is double_fault serviced by a trap gate?
In-Reply-To: <20001207171353.A28798@gruyere.muc.suse.de>
Message-ID: <Pine.GSO.3.96.1001207173802.21086G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Andi Kleen wrote:

> > Why is double_fault serviced by a trap gate? The problem with this is that
> > any double-fault caused by a stack-fault, which is the usual reason,
> > becomes a triple-fault. And a triple-fault results in a processor reset or
> > shutdown making the fault damn near impossible to get any information on.
> > 
> > Oughtn't the double-fault exception handler be serviced by a task gate? And
> > similarly the NMI handler in case the NMI is on the current stack page
> > frame?
> 
> Sounds like a good idea, when you can afford a few K for a special
> NMI/double fault stack. On x86-64 it is planned to do that.

 A task gate is an absolute must for the double fault if we want to have a
working handler.  Intel warns the CPU state can be inconsistent when a
double fault happens and for example I've seen cases where the saved CS
and EIP were not matching each other (tests were not conducted under
Linux).  Also SS:ESP might be unusable leading to a triple fault.

 The NMI should be left alone, though, I think as we want it to be fast
for the NMI watchdog.  Task gates are not necessarily fast (depending on
how you define "fast").

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
