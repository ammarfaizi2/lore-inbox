Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264476AbRFOSc3>; Fri, 15 Jun 2001 14:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264479AbRFOScT>; Fri, 15 Jun 2001 14:32:19 -0400
Received: from cnxtsmtp2.conexant.com ([198.62.9.253]:12729 "EHLO
	cnxtsmtp2.conexant.com") by vger.kernel.org with ESMTP
	id <S264476AbRFOScJ>; Fri, 15 Jun 2001 14:32:09 -0400
From: dan.davidson@conexant.com
Subject: Re: Lockup in 2.4.2 kernel ADSL PCI card ATM driver module
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OF77846C57.423E75DC-ON86256A6C.0061CDB6@conexant.com>
Date: Fri, 15 Jun 2001 13:13:17 -0500
X-MIMETrack: Serialize by Router on NPBSMTP1/Server/Conexant(Release 5.0.7 |March 21, 2001) at
 06/15/2001 11:31:59 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I apologize to all for my first post!

To partly answer my own poorly documented problem:-

First, once the code added for the debugger (int3) was removed from
the driver, the driver worked fine with kernel version 2.4.2-ac28 (but
still not with 2.4.2-2rh or 2.4.2).

Second, with sincere apologies to all (some suffer from brain
lapses more than others), I neglected to mention that the system
hangs, in both 2.4.2-2rh and 2.4.2 kernels, when the driver
performs:
    ...
    save_flags(flags);
    cli();
    ...
    TimeRemain = interruptible_sleep_on_timeout(&pEvent->WaitQue,
WaitTime);
    restore_flags(flags);
    ...

Again note that there were not any code changes to the driver,
with the results that the driver worked for 2.4.0 and 2.4.2-ac28
but did not work for 2.4.2-2rh or 2.4.2.

Does anyone know if there was a bug introduced between 2.4.0 and 2.4.2
in the interruptible sleep area that was fixed by 2.4.2-ac28?
If not, then there might still be a timing related problem in our
driver (or possibly the kernel).

Thanks again,
Dan Davidson
dan.davidson@conexant.com
Conexant Systems, Inc.


