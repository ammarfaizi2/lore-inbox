Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262840AbSJAVmy>; Tue, 1 Oct 2002 17:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262843AbSJAVmy>; Tue, 1 Oct 2002 17:42:54 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:41132 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262840AbSJAVmv>;
	Tue, 1 Oct 2002 17:42:51 -0400
Message-ID: <3D9A173B.1010205@us.ibm.com>
Date: Tue, 01 Oct 2002 14:44:27 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch][rfc] xquad_portio cleanup
References: <3D98DFA0.6020908@us.ibm.com> <20021001152148.GA126@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Mon, Sep 30, 2002 at 04:34:56PM -0700, Matthew Dobson wrote:
> 
>  > diff -Nur linux-2.5.31-vanilla/arch/i386/boot/compressed/misc.c linux-2.5.31-xquad/arch/i386/boot/compressed/misc.c
>  > --- linux-2.5.31-vanilla/arch/i386/boot/compressed/misc.c	Sat Aug 10 18:41:40 2002
>  > +++ linux-2.5.31-xquad/arch/i386/boot/compressed/misc.c	Thu Aug 15 14:28:33 2002
>  > @@ -9,6 +9,8 @@
>  >   * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
>  >   */
>  >  
>  > +#define STANDALONE
>  ...
>  > diff -Nur linux-2.5.31-vanilla/include/asm-i386/io.h linux-2.5.31-xquad/include/asm-i386/io.h
>  > --- linux-2.5.31-vanilla/include/asm-i386/io.h	Sat Aug 10 18:41:28 2002
>  > +++ linux-2.5.31-xquad/include/asm-i386/io.h	Thu Aug 15 15:17:31 2002
>  > @@ -298,7 +298,11 @@
>  >  #endif
>  >  
>  >  #ifdef CONFIG_MULTIQUAD
>  > -extern void *xquad_portio;    /* Where the IO area was mapped */
>  > + #ifdef STANDALONE
>  > +  #define xquad_portio 0
>  > + #else /* !STANDALONE */
>  > +  extern void *xquad_portio;    /* Where the IO area was mapped */
>  > + #endif /* STANDALONE */
>  >  #endif /* CONFIG_MULTIQUAD */
> 
> STANDALONE seems to be a very namespace-polluting choice of define.
> MULTIQUAD_STANDALONE, MQ_STANDALONE... anything would be better imo.

The #define is most definitely *not* NUMA/Multiquad specific.  In this
particular instance, it is guarding Multiquad specific code...  The 
STANDALONE option (please clarify if I'm wrong, Alan) is for code that 
is compiled along with the kernel, with the kernel headers, etc, but is 
not acually part of the kernel proper.

Cheers!

-Matt

