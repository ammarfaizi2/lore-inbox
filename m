Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261736AbTCXI17>; Mon, 24 Mar 2003 03:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261834AbTCXI17>; Mon, 24 Mar 2003 03:27:59 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:36995 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S261736AbTCXI16>;
	Mon, 24 Mar 2003 03:27:58 -0500
Date: Mon, 24 Mar 2003 09:39:00 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Jurriaan <thunder7@xs4all.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.65 + matrox framebuffer: life is good!
Message-ID: <20030324083859.GA5881@vana.vc.cvut.cz>
References: <20030323120949.GA5002@hh.idb.hist.no> <Pine.LNX.4.44.0303231649170.5720-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303231649170.5720-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 04:50:12PM +0000, James Simmons wrote:
> 
> > On Fri, Mar 21, 2003 at 07:43:37PM +0100, Jurriaan wrote:
> > > Just to let people know there's a new version of Petr's ongoing work
> > > with the matrox framebuffer available:
> > > 
> > > ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/
> > > 
> > > the file is called mga-2.5.65.gz, and it works wonderfully.
> > > 
> > > As far as I know, this patch was only announced on the fbdev-developers
> > > mailing-list. I assume there are more matrox-users here.
> > > 
> > It applies fine to 2.5.65-mm3 too.
> > Is this something that could be mergerd?  The current
> > matrox driver don't even compile.
> 
> Its for testing and it hasn't been fully ported over yet. Its close. 
> I was busy fixing higher level bugs but now that most are fixed I can work 
> on the matrox driver again.

There are still some open problems (text mode, hardware cursor), and I missed 
something somewhere, as czech font works only on VT1 console with mga-2.5.65 
(on other VTs there is some font loaded, but character mapping looks broken). 
I have no idea whether it is my problem or James's...

Probably worst problem currently is cursor code: it calls imgblit from interrupt
context, and matroxfb's accelerated procedures are not ready to handle
such thing (patch hooks cursor call much sooner for primary mga head).

At worst, for 2.6.0 I can remove text mode from version for Linus, and maintain
text mode capable driver separately, if we'll find some solution for cursor...
						Petr Vandrovec
						vandrove@vc.cvut.cz
