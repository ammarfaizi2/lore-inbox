Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289273AbSANXNO>; Mon, 14 Jan 2002 18:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSANXNF>; Mon, 14 Jan 2002 18:13:05 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:31757 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S289277AbSANXMt>; Mon, 14 Jan 2002 18:12:49 -0500
Date: Tue, 15 Jan 2002 10:12:56 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: esr@thyrsus.com, alan@lxorguk.ukuu.org.uk, babydr@baby-dragons.com,
        cate@debian.org, linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
Message-Id: <20020115101256.33f1bafa.rusty@rustcorp.com.au>
In-Reply-To: <Pine.GSO.4.21.0201141337580.224-100000@weyl.math.psu.edu>
In-Reply-To: <20020114131050.E14747@thyrsus.com>
	<Pine.GSO.4.21.0201141337580.224-100000@weyl.math.psu.edu>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002 14:09:16 -0500 (EST)
Alexander Viro <viro@math.psu.edu> wrote:
> Two technical obstacles:
> 	a) on some architecures modular code is slower (IIRC, the problem is
> with medium-range calls being faster than far ones and usable only in the
> kernel proper).  We probaly want to leave a gap after the .text and remap
> .text of module in there - if I understand the problem that should be
> enough, but that's really a question to folks dealing with these ports (PPC64
> and Itanic?)

Sparc64 has a special allocator.  PPC32 is not so lucky, and if the module
doesn't end up under 32MB we use trampolines (PLT in the ppc parlance).
PPC64 has similar issues.

> 	b) current differences between options parsing in case of built-in
> and modular drivers.

I have a patch for this, of course, but it's tied to my replacement module
loader:

	http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/param.patch.bz2

Cheers!
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
