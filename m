Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289868AbSAKT12>; Fri, 11 Jan 2002 14:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289997AbSAKT1S>; Fri, 11 Jan 2002 14:27:18 -0500
Received: from colorfullife.com ([216.156.138.34]:12554 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S289868AbSAKT1F>;
	Fri, 11 Jan 2002 14:27:05 -0500
Message-ID: <3C3F3C7F.76CCAF76@colorfullife.com>
Date: Fri, 11 Jan 2002 20:26:55 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre9 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Q: behaviour of mlockall(MCL_FUTURE) and VM_GROWSDOWN segments
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If an app has an VM_GROWS{DOWN,UP} stack and calls
mlockall(MCL_FUTURE|MCL_CURRENT), which pages should the kernel lock?

* grow the vma to the maximum size and lock all.
* just according to the current size.

What should happen if the segment is extended by more than one page
at once? (i.e. a function with 100 kB local variables)

* Just allocate the page that is needed to handle the page faults
* always fill holes immediately.

Right now segments are not grown during the mlockall syscall. Some
codepaths fill holes (find_extend_vma()), most don't (page fault
handlers)

What's the right thing (tm) to do?
I don't care which implementation is choosen, but IMHO all
implementations should be identical

--
	Manfred

