Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132152AbRDFRr5>; Fri, 6 Apr 2001 13:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132186AbRDFRrr>; Fri, 6 Apr 2001 13:47:47 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:48366 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132152AbRDFRrf>; Fri, 6 Apr 2001 13:47:35 -0400
Date: Fri, 6 Apr 2001 19:13:21 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Simmons <jsimmons@linux-fbdev.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
In-Reply-To: <20010406140920.A4866@jurassic.park.msu.ru>
Message-ID: <Pine.GSO.3.96.1010406190813.15958H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2001, Ivan Kokshaysky wrote:

> >  Memory barriers are a separate issue.  On the alpha the
> > natural way to implement it would be in the page table fill code.
> > Memory barriers are o.k. but the really don't help the case when what
> > you want to do is read the latest value out of a pci register.  
> 
> You don't need memory barrier for that. "Write memory barriers" are
> used to ensure correct write order, and "memory barriers" are used
> to ensure that all pending reads/writes will complete before next read
> or write.

 You do.  PCI-space registers are volatile and they may change depending
on what was written (or read) previously.  A memory barrier before a PCI
read will ensure you get a value that is relevant to previous code
actions.  Without a barrier you may get pretty anything, depending on
which of previous writes managed to complete before. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

