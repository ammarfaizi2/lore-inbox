Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275424AbRJATYW>; Mon, 1 Oct 2001 15:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275421AbRJATYN>; Mon, 1 Oct 2001 15:24:13 -0400
Received: from colorfullife.com ([216.156.138.34]:23310 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S275406AbRJATXy>;
	Mon, 1 Oct 2001 15:23:54 -0400
Message-ID: <3BB8C2E4.D6B0581C@colorfullife.com>
Date: Mon, 01 Oct 2001 21:24:20 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Erich Focht <focht@ess.nec.de>, linux-kernel@vger.kernel.org
Subject: Re: deadlock in crashed multithreaded job
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The symptoms: running the tests (make check) sometimes ends up
> with hanging processes.

Does it _only_ hang during coredumping, or also during normal usage?

Could you remove
	down_read(&mmap_sem);
	binfmt->coredump();
	up_read(&mmap_sem);
from fs/exec.c and rerun your tests?

The hang during coredumping is known, there are 2 fixes [I have one, not
yet released, Andrea wrote one, IIRC included in his -aa kernels].

Up to 2.4.10 there was a second hang with /proc/*/stats, that one is
fixed in 2.4.10.

--
	Manfred
