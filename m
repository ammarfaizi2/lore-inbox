Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267908AbTAHVZZ>; Wed, 8 Jan 2003 16:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267909AbTAHVZY>; Wed, 8 Jan 2003 16:25:24 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:36759 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S267908AbTAHVZX>;
	Wed, 8 Jan 2003 16:25:23 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Date: Wed, 8 Jan 2003 22:33:49 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: PCI code:  why need  outb (0x01, 0xCFB); ?
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <CAD6B2D09F9@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Jan 03 at 22:22, Maciej W. Rozycki wrote:
> On Wed, 8 Jan 2003, Petr Vandrovec wrote:
> 
> > > > 1. which device is at port address 0xCFB?
> > > 
> > > Hopefully none.
> > 
> > Actually I'm not sure. This code is here since at least 2.0.28,
> > and during googling I even found code for direct PCI access
> > (http://www-user.tu-chemnitz.de/~heha/viewzip.cgi/hs_freeware/gerald.zip/DIRECTNT.CPP?auto=CPP)
> > which sets lowest bit at 0xCFB to 1 before doing PCI config
> > accesses and reset it back to original value afterward.
> > 
> > So I believe that there were some chipsets (probably in 486&PCI times)
> > which did conf1/conf2 accesses depending on value of this bit.
> > Unfortunately I was not able to confirm this - almost nobody provides
> > northbridge datasheets from '94 era, even Intel does not provide them
> > (f.e. Neptune) anymore :-(
> 
>  Fortunately that's not true.  Grab the relevant docs from: 
> 'ftp://download.intel.com/support/chipsets/430nx/'.  The semantics of
> 0xcf8, 0xcf9, 0xcfa and 0xcfb I/O ports when used as byte quantities is
> explained there.  Note that 0xcf8 and 0xcfa are the way to get at the PCI
> config space using conf2 accesses. 

Thanks, page 34 of 290479.pdf is exactly what I was looking for 
(i.e. write 1 to 0xCFB to get PCI conf1, write 0 to get PCI conf2).
Next time I'll complain immediately instead of spending time with
browsing Intel website and google.
                                            Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
