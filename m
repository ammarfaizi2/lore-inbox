Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281557AbRKPVfB>; Fri, 16 Nov 2001 16:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281558AbRKPVev>; Fri, 16 Nov 2001 16:34:51 -0500
Received: from 20dyn241.com21.casema.net ([213.17.90.241]:44674 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S281557AbRKPVea>; Fri, 16 Nov 2001 16:34:30 -0500
Message-Id: <200111162134.WAA22927@cave.bitwizard.nl>
Subject: mmap not working?
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Date: Fri, 16 Nov 2001 22:34:24 +0100 (MET)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I want to mmap a device in an application, so I do: 

	base = mmap(NULL ,  DEV_LENGTH,  myprot , flags, kmem, dev_base); 

Turns out that some BIOSs put my device at an address like

	0xdffffc00

whereas others put it at 0xfa000000 . In the latter case, mmap works
as expected. However in the first case I get EINVAL: The base is
not page-aligned. 

However, in the latter case I get my requested 1k of memory, and the
following 3k for free. In the first case I'd want "3k for free,
followed by the 1k I requested".

effectively, provided "start" equals NULL, the kernel IMHO should:

	offset = dev_base & PAGE_MASK; 
	return mmap (NULL, length+offset, prot, flags, base - offset) + offset; 
Comments?

The "failure" was observed on 2.4.14 and/or 2.4.9. 

		Roger. 


P.S. I end up not being able to closely follow linux-kernel
lately. CCs to me appreciated.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
