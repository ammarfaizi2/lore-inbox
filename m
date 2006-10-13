Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751744AbWJMQak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbWJMQak (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbWJMQak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:30:40 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:23792 "EHLO
	biscayne-one-station.mit.edu") by vger.kernel.org with ESMTP
	id S1751744AbWJMQaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:30:39 -0400
Subject: Re: [linux-pm] Bug in PCI core
From: Adam Belay <abelay@MIT.EDU>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alan Stern <stern@rowland.harvard.edu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <1160753390.3000.494.camel@laptopd505.fenrus.org>
References: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org>
	 <1160753187.25218.52.camel@localhost.localdomain>
	 <1160753390.3000.494.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 12:40:31 -0400
Message-Id: <1160757632.26091.121.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.217
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-13 at 17:29 +0200, Arjan van de Ven wrote:
> On Fri, 2006-10-13 at 16:26 +0100, Alan Cox wrote:
> > Ar Gwe, 2006-10-13 am 10:29 -0400, ysgrifennodd Alan Stern:
> > > > I'd like to propose that we have the pci config sysfs interface return
> > > > -EIO  when it's blocked (e.g. active BIST or D3cold).  This accurately
> > > > reflects the state of the device to userspace, reduces complexity, and
> > > > could potentially save some memory per PCI device instance.
> > > 
> > > Could you resubmit your old patches and include a corresponding fix for 
> > > this access problem?
> > 
> > And then you can fix the applications it breaks, like the X server which
> > does actually want to know where all the devices are located in PCI
> > space.
> > 
> 
> .. but which could equally well mmap the resource from sysfs ;)
> 
> 
> also the thing this patch does is ONLY when the device is effectively
> off the bus return -EIO.
> One can argue that -EAGAIN is nicer since it's only a temporary
> condition though....
> 
> 

Yeah, perhaps -EAGAIN would be more appropriate, especially in the power
state transition and BIST cases.  An interesting possibility might be to
have the file actually block, although I'm not sure if the O_NONBLOCK
flag or polling for that matter can be supported through the
sysfs/driver-core API.

-Adam


