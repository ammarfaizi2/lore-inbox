Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751687AbWJMQY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWJMQY1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbWJMQY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:24:27 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:64232 "EHLO
	biscayne-one-station.mit.edu") by vger.kernel.org with ESMTP
	id S1751687AbWJMQY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:24:26 -0400
Subject: Re: [linux-pm] Bug in PCI core
From: Adam Belay <abelay@MIT.EDU>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <1160755562.25218.60.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org>
	 <1160753187.25218.52.camel@localhost.localdomain>
	 <1160753390.3000.494.camel@laptopd505.fenrus.org>
	 <1160755562.25218.60.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 12:34:20 -0400
Message-Id: <1160757260.26091.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.217
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-13 at 17:06 +0100, Alan Cox wrote:
> Ar Gwe, 2006-10-13 am 17:29 +0200, ysgrifennodd Arjan van de Ven:
> > > And then you can fix the applications it breaks, like the X server which
> > > does actually want to know where all the devices are located in PCI
> > > space.
> > > 
> > 
> > .. but which could equally well mmap the resource from sysfs ;)
> 
> That doesn't help deal with the location and PCI control side of things
> X has to perform and deal with. You also forgot to attach the tested
> patch set for the X server and other affected apps.
> 
> The cached stuff was put in place precisely because stuff broke
> 

I agree this needs to be fixed.  However, as I previously mentioned,
this isn't the right place to attack the problem.  Remember, this wasn't
originally a kernel regression.  Rather it's a workaround for a known
X/lspci/whatever bug.  It's not the kernel's job to babysit userspace.
If a userspace app that has the proper permissions decides to take a
course of action that could potentially crash the system, then it has a
right to do so.  There are probably dozens of vectors for these sorts of
problems (e.g. mmap as Arjan has mentioned) so why stop at the pci
config sysfs interface?

In this specific case, the workaround for this userspace bug actually
makes it impossible for programs that are implemented correctly (i.e.
understand that PCI configuration space can be inaccessible under
certain conditions) from working optimally because the kernel gives
inaccurate PCI config data rather than reporting the reality of the
situation.  I'd much rather give correct code the advantage then work
around buggy software that really needs to be fixed directly.

Finally, it's worth noting that this issue is really a corner-case, and
in most systems it's extremely rare that even incorrect userspace apps
would have any issue.

Thanks,
Adam


