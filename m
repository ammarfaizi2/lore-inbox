Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263183AbUEBSBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbUEBSBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 14:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUEBSBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 14:01:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27410 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263183AbUEBSBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 14:01:20 -0400
Date: Sun, 2 May 2004 19:01:15 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@osdl.org>, vandrove@vc.cvut.cz, koke@amedias.org,
       linux-kernel@vger.kernel.org, Andries Brouwer <Andries.Brouwer@cwi.nl>
Subject: Re: strange delays on console logouts (tty != 1)
Message-ID: <20040502190115.D17905@flint.arm.linux.org.uk>
Mail-Followup-To: Chris Wedgwood <cw@f00f.org>,
	Andrew Morton <akpm@osdl.org>, vandrove@vc.cvut.cz,
	koke@amedias.org, linux-kernel@vger.kernel.org,
	Andries Brouwer <Andries.Brouwer@cwi.nl>
References: <20040501214617.GA6446@taniwha.stupidest.org> <20040501232448.GA4707@vana.vc.cvut.cz> <20040501180347.31f85764.akpm@osdl.org> <20040502090059.A9605@flint.arm.linux.org.uk> <20040502011337.2b0b3ca3.akpm@osdl.org> <20040502091751.B9605@flint.arm.linux.org.uk> <20040502103721.C9605@flint.arm.linux.org.uk> <20040502111729.D9605@flint.arm.linux.org.uk> <20040502135424.GA20578@apps.cwi.nl> <20040502175326.GA30108@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040502175326.GA30108@taniwha.stupidest.org>; from cw@f00f.org on Sun, May 02, 2004 at 10:53:26AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 10:53:26AM -0700, Chris Wedgwood wrote:
> On Sun, May 02, 2004 at 11:17:29AM +0100, Russell King wrote:
> 
> > The first one is of particular note, because it is the cause of the
> > GROSS hack in agetty, which according to the comments is also in
> > gdm.
> 
> I've emailed the debian util-linux maintainer about this.
> 
> > I wonder really if the problem was elsewhere, and if Debian wanted
> > to take care of this problem, why they didn't just take the serial
> > line locking solution (really: s/serial line/tty/) and apply it to
> > agetty / gdm.
> 
> It locking really the way to do this?  What's wrong with vhangup?

As I read the original problem, you have gdm running on what it thought
was a free tty at the time.  agetty starts up and takes control of the
tty.

If you vhangup, what does gdm do...  Hopefully it should restart and
find another tty to use, but I'm not convinced this is a really elegant
solution.

Couple that with the way that agetty is supposed to support "dial-in"
lines (according to the man page), and realise that dial-in means modem
and modems can also dial out, so correct locking with (eg) minicom is
probably a good idea _anyway_.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
