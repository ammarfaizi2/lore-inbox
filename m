Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131663AbQLHM2b>; Fri, 8 Dec 2000 07:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131754AbQLHM2W>; Fri, 8 Dec 2000 07:28:22 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:15601 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131663AbQLHM2J>; Fri, 8 Dec 2000 07:28:09 -0500
Date: Fri, 8 Dec 2000 12:44:05 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Brian Gerst <bgerst@didntduck.org>, richardj_moore@uk.ibm.com,
        Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Why is double_fault serviced by a trap gate?
In-Reply-To: <Pine.LNX.3.95.1001207202330.5283A-100000@chaos.analogic.com>
Message-ID: <Pine.GSO.3.96.1001208123551.6796C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Richard B. Johnson wrote:

> I am not denying the possibility of "warm-booting", i.e.,
> reloate some code to where there is a 1:1 physical to virtual
> translation, jump to the relocated code, disable paging, restart kernel
> code, and possibly examine what happened. You just have to get
> back to "flat-mode" with no paging to handle anything beyond a
> double fault. You are just not going to be able to restart
> from the stack-faulted code.

 If you want to handle triple faults (well, there should be none of these
given a proper double fault handler) you may use the NMI as well.  You are
guaranteed to receive a NMI after a while when the watchdog is active (it
is for SMP systems by default now and it will be for P6+ UP systems for
Linux 2.5 as well).  At least current Intel chipsets do not assert RESET
to the CPU as a response to the shutdown special cycle in their default
configuration (we may even explicitly force that behaviour). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
