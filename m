Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVCBGLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVCBGLK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 01:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVCBGLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 01:11:09 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:38858 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262191AbVCBGKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 01:10:44 -0500
Message-ID: <42255971.4070608@jp.fujitsu.com>
Date: Wed, 02 Mar 2005 15:13:05 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Matthew Wilcox <matthew@wil.cx>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
References: <422428EC.3090905@jp.fujitsu.com> <20050301144211.GI28741@parcelfarce.linux.theplanet.co.uk> <20050301192711.GE1220@austin.ibm.com>
In-Reply-To: <20050301192711.GE1220@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
 >> I'd prefer to see it as ioerr_clear(), ioerr_read() ...
 >
 > I'd prefer pci_io_start() and pci_io_check_err()
 >
 > The names should have "pci" in them.
 >
 > I don't like "ioerr_clear" because it implies we are clearing the io error; we are not; we are clearing the checker 
for io errors.

My intention was "clear/read checker(called iochk) to check my I/O."
(bitmask would be better for error flag, but bits are not defined yet.)
So I agree that ioerr_clear/read() would be one of good alternatives.
But still I'd prefer iochk_*, because it doesn't clear error but checker.
iochecker_* would be bit long.

And then, I don't think it need to have "pci" ... limitation of this
API's target. It would not be match if there are a recoverable device
over some PCI to XXX bridge, or if there are some special arch where
don't have PCI but other recoverable bus system, or if future bus system
doesn't called pci...
Currently we would deal only pci, but in future possibly not.

 > Do we really need a cookie?

Some do, some not.
For example, if arch has only a counter of error exception, saving value
of the counter to the cookie would be make sense.

 > Yes, they should be no-ops. save/restore interrupts would be a bad idea.

I expect that we should not do any operation requires enabled interrupt
between iochk_clear and iochk_read. If their defaults are no-ops, device
maintainers who develops their driver on not-implemented arch should be
more careful. Or are there any bad thing other than waste of steps?


Thanks,
H.Seto


