Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130089AbQKCVaz>; Fri, 3 Nov 2000 16:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131936AbQKCVap>; Fri, 3 Nov 2000 16:30:45 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37906 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130089AbQKCVah>;
	Fri, 3 Nov 2000 16:30:37 -0500
Message-ID: <3A032E32.39E7B151@mandrakesoft.com>
Date: Fri, 03 Nov 2000 16:29:22 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <200011031937.WAA10753@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > that does hardware register access without protecting against interrupts
> > or checking if the interface is up.
> 
> This issue is not that issue. It is separate issue and in fact
> it is private problem of driver and its author, what is safe,
> what is not safe.
> 
> F.e. I see no cathastrophe even if MII registers are accessed without
> any protections. Diag utilities do this from user space. 8)8)

It depends on the hardware...  For the ioctl-only case, you are
correct.  rtnl_lock protects us there.  But when the timer and ioctl
both call mdio_xxx, you need SMP protection, otherwise you corrupt the
multi-step MDIO read/write found in many drivers.

IMNSHO the timer routines found in net drivers should all be converted
to kernel threads.  There are too many limitations placed on you by
timers.


> > de4x5 is probably also buggy in regard to this.
> 
> de4x5 is hopeless. I added nice comment in softnet to it.
> Unfortunately it was lost. 8)
> 
> Andi, neither you nor me nor Alan nor anyone are able to audit
> all this unnevessarily overcomplicated code. It was buggy, is buggy
> and will be buggy. It is inavoidable, as soon as you have hundreds
> of drivers.

de4x5 is becoming EISA-only in 2.5.x too, since its PCI support is
duplicated now in tulip driver.

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
