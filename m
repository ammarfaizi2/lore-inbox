Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbSL0WxS>; Fri, 27 Dec 2002 17:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbSL0WxS>; Fri, 27 Dec 2002 17:53:18 -0500
Received: from p060.as-l031.contactel.cz ([212.65.234.252]:17536 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S265238AbSL0WxQ>;
	Fri, 27 Dec 2002 17:53:16 -0500
Date: Fri, 27 Dec 2002 23:58:12 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Jurriaan <thunder7@xs4all.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: also frustrated with the framebuffer and your matrox-card in 2.5.53? hack/patch available!
Message-ID: <20021227225812.GC1403@ppc.vc.cvut.cz>
References: <20021227023943.GC1412@ppc.vc.cvut.cz> <Pine.GSO.4.21.0212271128120.17037-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0212271128120.17037-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2002 at 12:05:38PM +0100, Geert Uytterhoeven wrote:
> On Fri, 27 Dec 2002, Petr Vandrovec wrote:
> > On Thu, Dec 26, 2002 at 07:47:52PM +0000, James Simmons wrote:
> > > Petr is expressing his political view. It has nothing to do with technical 
> > > arguments. In fact I place a bet. I will port the matrox driver and it 
> > > will have the same functionality as the previous driver except for text 
> > > mode support. If I can't do it I will not only revert the changes but I 
> > 
> > Yes. Without text mode support. But without textmode support that driver is
> > of no use for me because of it is not compatible with VMware then.
> 
> What exactly in the new fbdev API is preventing you from having text mode
> support?

Problem is that in new framework driver does not get in touch with characters.
It gets only prepared bitmap passed to imageblit callback (because of fbcon_putcs
unconditionally calls accel_putcs, which does character -> bitmap conversion). Of 
course it is possible to convert bitmap back to character number, but it is very 
time consuming, and it looks illogical to me first convert character number to its
graphic image, and then convert graphic image back to character number... Not even
talking about 9x16 character cell.

Next problem is that fbdev driver is no more notified (if I understand code correctly)
about font changes, so it even cannot upload correct font into the hardware, and
so it must rely on accel_putcs at the time of character print.

If nothing else, VMware can be happy with just black screen in text mode, it will
paint proper characters directly...

Much worse problem is that I do not see any way how to have different resolutions
on different virtual terminals, and I do not know how to work around this.

						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz
