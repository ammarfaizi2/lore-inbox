Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbSJAPN4>; Tue, 1 Oct 2002 11:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261703AbSJAPN4>; Tue, 1 Oct 2002 11:13:56 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:52611 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261701AbSJAPNy>;
	Tue, 1 Oct 2002 11:13:54 -0400
Date: Tue, 1 Oct 2002 16:21:48 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch][rfc] xquad_portio cleanup
Message-ID: <20021001152148.GA126@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Matthew Dobson <colpatch@us.ibm.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Martin Bligh <mjbligh@us.ibm.com>,
	Linus Torvalds <torvalds@transmeta.com>
References: <3D98DFA0.6020908@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D98DFA0.6020908@us.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 04:34:56PM -0700, Matthew Dobson wrote:

 > diff -Nur linux-2.5.31-vanilla/arch/i386/boot/compressed/misc.c linux-2.5.31-xquad/arch/i386/boot/compressed/misc.c
 > --- linux-2.5.31-vanilla/arch/i386/boot/compressed/misc.c	Sat Aug 10 18:41:40 2002
 > +++ linux-2.5.31-xquad/arch/i386/boot/compressed/misc.c	Thu Aug 15 14:28:33 2002
 > @@ -9,6 +9,8 @@
 >   * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
 >   */
 >  
 > +#define STANDALONE
 ...
 > diff -Nur linux-2.5.31-vanilla/include/asm-i386/io.h linux-2.5.31-xquad/include/asm-i386/io.h
 > --- linux-2.5.31-vanilla/include/asm-i386/io.h	Sat Aug 10 18:41:28 2002
 > +++ linux-2.5.31-xquad/include/asm-i386/io.h	Thu Aug 15 15:17:31 2002
 > @@ -298,7 +298,11 @@
 >  #endif
 >  
 >  #ifdef CONFIG_MULTIQUAD
 > -extern void *xquad_portio;    /* Where the IO area was mapped */
 > + #ifdef STANDALONE
 > +  #define xquad_portio 0
 > + #else /* !STANDALONE */
 > +  extern void *xquad_portio;    /* Where the IO area was mapped */
 > + #endif /* STANDALONE */
 >  #endif /* CONFIG_MULTIQUAD */

STANDALONE seems to be a very namespace-polluting choice of define.
MULTIQUAD_STANDALONE, MQ_STANDALONE... anything would be better imo.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
