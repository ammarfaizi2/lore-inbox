Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280430AbRKJCtC>; Fri, 9 Nov 2001 21:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280433AbRKJCsw>; Fri, 9 Nov 2001 21:48:52 -0500
Received: from faui11.informatik.uni-erlangen.de ([131.188.31.2]:28846 "EHLO
	faui11.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S280460AbRKJCsi>; Fri, 9 Nov 2001 21:48:38 -0500
From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
Message-Id: <200111100248.DAA00341@faui11.informatik.uni-erlangen.de>
Subject: Re: Patch for kernel.real-root-dev on s390
To: zaitcev@redhat.com
Date: Sat, 10 Nov 2001 03:48:33 +0100 (MET)
Cc: linux-kernel@vger.kernel.org, uweigand@de.ibm.com
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:

>what do you think about the attached patch. Without it, 
>a sysctl to kernel.real-root-dev corrupts adjacent memory. 

I agree that this looks broken, but I don't see why it 
would be s390 specific.  The clobber of adjacent memory
happens on all architectures, and on all big endian systems
the value read is incorrect even if adjacent memory happens 
to be 0.

However, I'm not convinced the patch is a proper fix; it
will cause the MAJOR and MINOR macros to be applied to a
variable not of type kdev_t, which happens to work now but will 
break if the definition of kdev_t is changed to a structure
or pointer type (as it probably will at some point in the 
future, if I recall the various discussions correctly).

What about either
 - adding support for kdev_t values to procfs
or
 - keeping two int variables real_root_major and 
   real_root_minor ?

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
