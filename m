Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbQLGRDF>; Thu, 7 Dec 2000 12:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbQLGRCp>; Thu, 7 Dec 2000 12:02:45 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129632AbQLGRCk>; Thu, 7 Dec 2000 12:02:40 -0500
Date: Thu, 7 Dec 2000 11:31:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andi Kleen <ak@suse.de>
cc: richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Why is double_fault serviced by a trap gate?
In-Reply-To: <20001207171353.A28798@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.3.95.1001207112423.188A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Andi Kleen wrote:

> On Thu, Dec 07, 2000 at 04:04:21PM +0000, richardj_moore@uk.ibm.com wrote:
> > 
> > 
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
> 
> 

Well, at least on current ix86 processors it can't. Attempting to
use a task gate appears to be a trick to cause the exception to
be handled on the current stack. The hardware protection hierarchy
won't let this happen. You need to have a stack that is not accessible
from the mode that will be trapped. Otherwise, a user could crash
the machine by setting ESP to 0 and waiting for the next context-
switch or timer-tick.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
