Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276313AbRI1VMd>; Fri, 28 Sep 2001 17:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276305AbRI1VMX>; Fri, 28 Sep 2001 17:12:23 -0400
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:40459 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S276314AbRI1VMN>; Fri, 28 Sep 2001 17:12:13 -0400
Message-ID: <3BB4E6AC.4BA48EF4@dcrdev.demon.co.uk>
Date: Fri, 28 Sep 2001 22:07:56 +0100
From: Dan Creswell <dan@dcrdev.demon.co.uk>
Organization: Empty Hand Systems Ltd
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.9-ac16 + imm module = hard lock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a dual pentium III 550Mhz box and a parallel port ZIP-plus drive.

Under 2.2.19 SMP, with imm compiled as a module, everything works fine.

With 2.4.9-ac16 (plus the swapoff patch) SMP, with imm compiled as a
module I get a hard lock when I load the module.  It successfully
determines which mode to use (EPP-32 bit) but, at the point where it
probes, everything dies.

The same kernel 2.4.9-ac16 compiled for uniprocessor with imm compiled
as a module also works fine.

A quick diff of the 2.2.19 imm source-code and the 2.4.9-ac16 imm
source-code reveals that the only major difference is the introduction
of:

spin_unlock_irq(&io_request_lock);

and

spin_lock_irq(&io_request_lock);

in various places.

The parallel port code is compiled into the kernel at build time.

That's all the info I have right now, any thoughts/suggestions/more info
required?

Thanks,

Dan.


