Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132121AbRDFRb1>; Fri, 6 Apr 2001 13:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132125AbRDFRbS>; Fri, 6 Apr 2001 13:31:18 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:33262 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132121AbRDFRbG>; Fri, 6 Apr 2001 13:31:06 -0400
Date: Fri, 6 Apr 2001 19:07:45 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        James Simmons <jsimmons@linux-fbdev.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
In-Reply-To: <m17l0zw6mx.fsf@frodo.biederman.org>
Message-ID: <Pine.GSO.3.96.1010406185324.15958G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Apr 2001, Eric W. Biederman wrote:

> The point is on the Alpha all ram is always cached, and i/o space is
> completely uncached.  You cannot do write-combing for video card

 You don't want to cache fb memory, do you?  All you want is write
combining and you achieve it with memory barriers.  You write to fb memory
space whatever you need to and write buffers actually deliver data to fb
memory whenever the bus is idle or they get filled up.  When you finally
decide you wrote all data and you want ensure it actually reaches the fb
memory before you perform an operation (say you send a command to fb's
support circuitry) you issue a write memory barrier.  Or a memory barrier,
if you want ensure the data reaches the fb memory ASAP.

 In other words, you have write-combining by default and request
write-through explicitly.

> memory.  Memory barriers are a separate issue.  On the alpha the
> natural way to implement it would be in the page table fill code.

 Please forgive me -- I can't see how this is related to write combining.

> Memory barriers are o.k. but the really don't help the case when what
> you want to do is read the latest value out of a pci register.  

 They do -- you issue an mb and you are sure all pending writes reached
the involved PCI hw. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

