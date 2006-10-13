Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWJMQtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWJMQtg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWJMQtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:49:36 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:14780 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751351AbWJMQtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:49:35 -0400
Date: Fri, 13 Oct 2006 10:49:33 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adam Belay <abelay@MIT.EDU>, Arjan van de Ven <arjan@infradead.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Bug in PCI core
Message-ID: <20061013164933.GD11633@parisc-linux.org>
References: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org> <1160753187.25218.52.camel@localhost.localdomain> <1160753390.3000.494.camel@laptopd505.fenrus.org> <1160755562.25218.60.camel@localhost.localdomain> <1160757260.26091.115.camel@localhost.localdomain> <1160759349.25218.62.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160759349.25218.62.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 06:09:09PM +0100, Alan Cox wrote:
> Ar Gwe, 2006-10-13 am 12:34 -0400, ysgrifennodd Adam Belay:
> > I agree this needs to be fixed.  However, as I previously mentioned,
> > this isn't the right place to attack the problem.  Remember, this wasn't
> > originally a kernel regression.  Rather it's a workaround for a known
> 
> It's a kernel regression. It used to be reliable to read X resource
> addresses at any time.

No it didn't.  It's undefined behaviour to perform *any* PCI config
access to the device while it's doing a D-state transition.  It may have
happened to work with the chips you tried it with, but more likely you
never hit that window because X simply didn't try to do that.

> > Finally, it's worth noting that this issue is really a corner-case, and
> > in most systems it's extremely rare that even incorrect userspace apps
> > would have any issue.
> 
> Except just occasionally and randomly in the field, probably almost
> undebuggable and irreproducable - the very worst conceivable kind of
> bug.

Indeed.  Only now we have software producing it, rather than hardware
producing it.  That's actually an improvement I think, since it forces
awareness of the issue.
