Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276978AbRJKV5J>; Thu, 11 Oct 2001 17:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276977AbRJKV47>; Thu, 11 Oct 2001 17:56:59 -0400
Received: from dsl-65-185-37-21.telocity.com ([65.185.37.21]:35887 "EHLO
	onevista.com") by vger.kernel.org with ESMTP id <S276978AbRJKV4t>;
	Thu, 11 Oct 2001 17:56:49 -0400
Reply-To: johna@onevista.com
Content-Type: text/plain; charset=US-ASCII
From: John Adams <johna@onevista.com>
Organization: One Vista Associates
To: linux-kernel@vger.kernel.org
Subject: Re: Module read a file?
Date: Thu, 11 Oct 2001 17:57:25 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <m38zehucml.fsf@flash.localdomain> <3BC60CCB.4F525A02@nortelnetworks.com> <m3zo6xswcq.fsf@flash.localdomain>
In-Reply-To: <m3zo6xswcq.fsf@flash.localdomain>
MIME-Version: 1.0
Message-Id: <01101117572500.01036@flash>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 October 2001 17:25, Mark Atwood wrote:
> "Christopher Friesen" <cfriesen@nortelnetworks.com> writes:
> > Mark Atwood wrote:
> > > I'm modifying a PCMCIA driver module so that it can load new firmware
> > > into the card when it's inserted.
> > > Are their any good examples of kernel code or kernel modules reading
> > > a file out of the filesystem that I could copy or at least look to
> > > for inspiration?
> >
> > What about adding an ioctl() and making a userspace tool to pass the
> > new firmware down in a buffer?  This lets you do more complicated
> > error-checking and maybe some sort of validation of the firmware in
> > userspace, saving on kernel size.
>
> Because the firmware is stored in volitile memory on the card, and
> vanishes on a card reset or removal, and I would like to have it Just
> Work with the pcmcia-cs package with minimal changes.
>
> Having to remember "run this userspace tool after every card reset"
> (which includes power suspends and so forth) would be a major pain.
>

Have a userspace job which
1) sleeps in the kernel
2) when woken, delivers the data from the filesystem via ioctl to the driver
3) goes back to sleep

Have a driver which
1) wakes the user space job
2) receives the data via ioctl
3) reloads the card

The userspace job is started at boot and lives forever.
Its probably easiest to build the driver into the kernel.

	johna
