Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316232AbSEaRzT>; Fri, 31 May 2002 13:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316531AbSEaRzS>; Fri, 31 May 2002 13:55:18 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:6383 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316232AbSEaRzR>; Fri, 31 May 2002 13:55:17 -0400
Subject: Re: do_mmap
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ad8bvv$3tr$1@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 31 May 2002 19:59:30 +0100
Message-Id: <1022871570.20348.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-31 at 18:30, Linus Torvalds wrote:
> >> is it possible to have 0 as a valid address? - if not, this should
> >> be the return on errors.
> >
> >SuS explicitly says that 0 is not a valid mmap return address.
> 
> But if so, SuS is _very_ _very_ wrong.
> 
> The fact is, if you use something like vm86 mode, you absolutely _need_
> to be able to explicitly mmap at address 0. 
> 
> So it is correct (and in fact there is no other sane way to do it) to
> say
> 
> 	addr = mmap(NULL, 1024*1024,
> 		PROT_READ | PROT_WRITE ,
> 		MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED,
> 		-1, 0);
> 
> and if SuS says that mmap must not return NULL for this case, then SuS
> is so full of sh*t that it's not worth worrying about.

SuS doesn't have this requirement in the case of MAP_FIXED.

For normal maps it says

"When the implementation selects a value for pa, it never places a mapping 
at address 0, nor does it replace any extant mapping."

For MAP_FIXED it says the return value shal be that of pa (first
argument) exactly



