Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293030AbSBVWfk>; Fri, 22 Feb 2002 17:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293031AbSBVWfa>; Fri, 22 Feb 2002 17:35:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48394 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293030AbSBVWfO>;
	Fri, 22 Feb 2002 17:35:14 -0500
Message-ID: <3C76C7A1.4389A375@mandrakesoft.com>
Date: Fri, 22 Feb 2002 17:35:13 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
CC: Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjanv@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <20020221221145.I1742-100000@gerard>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gérard Roudier wrote:
> 
> On Fri, 22 Feb 2002, Jeff Garzik wrote:
> 
> > Gérard Roudier wrote:
> > > Basically at the moment, if the driver allows upper 'seeming cleaner and
> > > smarter' PCI probing things to deal with the HBA attachment order, at
> > > least all my machines running Linux will not even reboot.
> > >
> > > Being smart is doing what user expects, here.
> >
> > Oh come on, how hard is the following?
> >
> > > static int __init foo_init(void)
> > > {
> > >     int rc = pci_module_init(&sym2_pci_driver);
> > >     if (rc) return rc;
> > >     do_deferred_work();
> > > }
> > > module_init(foo_init);
> >
> > You have tons of flexibility you are ignoring here...  For the
> > non-hotplug hosts (ie. present at boot), just use pci_driver::probe to
> > register hosts on a list, and little other work.  do_deferred_work()
> > handles the list in a manner that ensures proper boot and/or host
> > ordering.
> >
> > So for non-hotplug hosts you do a init_module time:
> >       register N hosts with PCI API
> >       register N hosts with SCSI API
> >
> > And hotplugged hosts would do the same, with N==1.
> >
> > What you describe -is- supported with the PCI API.
> 
> At the time I investigated the API it just mixed the probing and the
> registering by performing some auto-registration based on return value.
> May-be the API did evolve since that time or I missed something important.
> 
> For now I will be in vacation for 1 week. I will re-investigate this when
> I will be back.

Thanks!

One thing that is slowly becoming apparently to me during this thread is
the importance of separating ordering [of hosts, of disks] from the
registration of the resource itself.

Thinking about the problem a bit more (NVRAM boot disk ordering, etc.) I
believe that what I describe above might be considered a transition
step...  In Step Two, do_deferred_work() [above] would likely be moved
to userspace, running on initramfs.

	Jeff



-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
