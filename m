Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbUAIO4X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 09:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUAIO4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 09:56:22 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:56275 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261877AbUAIOzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 09:55:49 -0500
Date: Fri, 9 Jan 2004 06:57:18 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, joe.korty@ccur.com, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040109065718.364789dd.pj@sgi.com>
In-Reply-To: <16381.57040.576175.977969@cargo.ozlabs.ibm.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M, replying to Paul J:
> > If this request proceeds as expected, I will follow up with a patch to
> > lib/mask.c that will likely make use of the cpu_to_le32() and
> > le32_to_cpu() macros in byteorder.h to swap bytes in the u32 words being
> > displayed and parsed.
> 
> That would be the wrong approach IMHO.

Ok - I agree that this would be wrong for 64 bit sparc and ppc, for
these architectures use native big endian byte order within cpumasks,
not little endian.

Indeed, I take it that this applies not just to cpumasks, but to any
mask-like operand that bitops such as ffs() are applied to.

I also need to examine the 32 bit big endian architectures, to see
whether their cpumasks, and other bitop operands, are big or little
endian.  If they are big endian (native order) then my mask printing and
scanning code should always presume native byte order, and only has to
special case the order of two u32 words within a u64 long on 64 bit big
endian architectures.  If they are little endian, then I'll also need to
make use of the cpu_to_le32() and le32_to_cpu() macros in byteorder.h to
swap bytes in the u32 words being displayed and parsed (but _not_ for
sparc64 or ppc).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
