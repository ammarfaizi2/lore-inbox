Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317829AbSHUD6J>; Tue, 20 Aug 2002 23:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317833AbSHUD6J>; Tue, 20 Aug 2002 23:58:09 -0400
Received: from mail.cs.unm.edu ([64.106.20.33]:47371 "EHLO jah.cs.unm.edu")
	by vger.kernel.org with ESMTP id <S317829AbSHUD6I>;
	Tue, 20 Aug 2002 23:58:08 -0400
Date: Tue, 20 Aug 2002 20:25:19 -0600
From: moret@cs.unm.edu
To: linux-kernel@vger.kernel.org
Subject: problem with modules (modutils) and 2.5.31 kernel
Message-ID: <20020821022519.GA2554@cs.unm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I searched for, but could not find references to, a problem
I have with 2.5.31 and modutils.  (2.5.31 running with Debian
distribution on a P3 laptop or on two different P4 workstations,
each with a somewhat different kernel configuration -- no further
details here, in case this is already a well-known problem.)

  insmod, depmod, update-modules all fail with the message:

=>   kernel: QM_SYMBOLS: Bad address


That message comes from the routine new_get_kernel_info (in modstat.c,
a part of the modutils package 2.4.19-3 under Debian), in response to
a call to query_module that is querying the kernel itself:

  query_module(NULL, QM_SYMBOLS, syms, bufsize, &ret)

The return code is -1 (error) and errno is the code for EFAULT,
indicating a bad address for one of syms or ret.

Is the problem that the modutils version (2.4.19-3 from Debian
unstable, in either precompiled or locally built versions)
is too old for the 2.5.31 kernel?  (I see references
to a forthcoming modutils 2.5, but could not locate it.)
Or is there a known problem with the kernel itself?

Sorry if this message is a bit naive.  I do need the 2.5.31 kernel,
because the 2.4.19 (and earlier) kernels cannot correctly assign
IRQs and iomem addresses to my Dell machine (problems with handling
the 82801DB ICH4 controller resulting in extremely poor IDE disk
performance and incorrect USB handling), whereas the 2.5.31 kernel
has no problem there.
However, I need to use a couple of modules (they cannot be compiled
directly into the kernel) and so need to get around that problem
with modutils.  Any pointers or patches appreciated!

					Bernard Moret
-- 
Bernard M.E. Moret	     moret@cs.unm.edu      http://www.cs.unm.edu/~moret
(505) 277-5699 (office)    (505) 277-6927 (FAX)     (505) 277-3112 (department)
Department of Computer Science, University of New Mexico, Albuquerque, NM 87131
