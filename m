Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVLBOL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVLBOL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 09:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVLBOL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 09:11:57 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:49820 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750754AbVLBOL5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 09:11:57 -0500
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <041701c5f742$d6b0a450$4168010a@bsd.tnes.nec.co.jp>
References: <01e901c5f66e$d4551b70$4168010a@bsd.tnes.nec.co.jp>
	 <1133447539.8557.14.camel@kleikamp.austin.ibm.com>
	 <041701c5f742$d6b0a450$4168010a@bsd.tnes.nec.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 02 Dec 2005 08:11:50 -0600
Message-Id: <1133532710.8890.11.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-02 at 22:18 +0900, Takashi Sato wrote:
> >> 2. Change the type of architecture dependent stat64.st_blocks in
> >>    include/asm/asm-*/stat.h from unsigned long to unsigned long long.
> >>    I tried modifying only stat64 of 32bit architecture
> >>    (include/asm-i386/stat.h).
> >
> >This changes the API, but the structure does suggest that the 4-byte pad
> >should be used for the high-order bytes of st_blocks, so that's not
> >really a problem.  A correct fix would replace __pad4 with
> >st_blocks_high (or something like that) and ensure that the high-order
> >word was stored there.  Your proposed fix would only be correct on
> >little-endian hardware, as Jörn pointed out.
> 
> Thank you for your advice.  I'll research for glibc and consider
> how to implement.
> By the way I think, as Avi Kivity said, it's always little-endian on i386,
> is it correct?

That's true.  The patch does fix i386 without any bad side-effects.  A
generic fix that would fix all architectures would be a little more
complicated, since the size of st_blocks varies.  32-bit big-endian
would have to explicitly copy the high and low words.  (The first time I
looked at this, I ignored the fact that the change was in asm-i386.)

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

