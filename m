Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132959AbRDESYe>; Thu, 5 Apr 2001 14:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132961AbRDESYY>; Thu, 5 Apr 2001 14:24:24 -0400
Received: from [166.70.28.69] ([166.70.28.69]:30286 "EHLO flinx.biederman.org")
	by vger.kernel.org with ESMTP id <S132959AbRDESYS>;
	Thu, 5 Apr 2001 14:24:18 -0400
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        James Simmons <jsimmons@linux-fbdev.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
In-Reply-To: <Pine.GSO.3.96.1010405150444.21134E-100000@delta.ds2.pg.gda.pl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Apr 2001 12:20:22 -0600
In-Reply-To: "Maciej W. Rozycki"'s message of "Thu, 5 Apr 2001 15:15:26 +0200 (MET DST)"
Message-ID: <m17l0zw6mx.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> writes:

> On Thu, 5 Apr 2001, Geert Uytterhoeven wrote:
> 
> > > 32bit writes on a bus with a word size of 64 or more bits.  By the way
> > > does anyone know who didn't implement MTRR's or the equivalent on
> > > alpha so we can shoot them?
> > 
> > People never get shot in Open Source projects. Not when they write buggy code,
> 
> > not when they don't implement some features.
> 
>  Was DEC Alpha an Open Source project? ;-)
> 
>  Memory barriers are more RISC-styled and more flexible anyway (e.g. you
> can't run out of them ;-) ), though they require a greater care when
> writing code.  MTRRs are the Intel style of complicating designs.  Still
> they are probably a reasonable solution to preserve DOS compatibility. 

The point is on the Alpha all ram is always cached, and i/o space is
completely uncached.  You cannot do write-combing for video card
memory.  Memory barriers are a separate issue.  On the alpha the
natural way to implement it would be in the page table fill code.
Memory barriers are o.k. but the really don't help the case when what
you want to do is read the latest value out of a pci register.  

Eric



