Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292984AbSBVUPe>; Fri, 22 Feb 2002 15:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292985AbSBVUPZ>; Fri, 22 Feb 2002 15:15:25 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:44322 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S292984AbSBVUPO> convert rfc822-to-8bit; Fri, 22 Feb 2002 15:15:14 -0500
Date: Thu, 21 Feb 2002 22:14:47 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjanv@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <3C76A262.558BA821@mandrakesoft.com>
Message-ID: <20020221221145.I1742-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Feb 2002, Jeff Garzik wrote:

> Gérard Roudier wrote:
> > Basically at the moment, if the driver allows upper 'seeming cleaner and
> > smarter' PCI probing things to deal with the HBA attachment order, at
> > least all my machines running Linux will not even reboot.
> >
> > Being smart is doing what user expects, here.
>
> Oh come on, how hard is the following?
>
> > static int __init foo_init(void)
> > {
> >	int rc = pci_module_init(&sym2_pci_driver);
> >	if (rc) return rc;
> >	do_deferred_work();
> > }
> > module_init(foo_init);
>
> You have tons of flexibility you are ignoring here...  For the
> non-hotplug hosts (ie. present at boot), just use pci_driver::probe to
> register hosts on a list, and little other work.  do_deferred_work()
> handles the list in a manner that ensures proper boot and/or host
> ordering.
>
> So for non-hotplug hosts you do a init_module time:
> 	register N hosts with PCI API
> 	register N hosts with SCSI API
>
> And hotplugged hosts would do the same, with N==1.
>
> What you describe -is- supported with the PCI API.

At the time I investigated the API it just mixed the probing and the
registering by performing some auto-registration based on return value.
May-be the API did evolve since that time or I missed something important.

For now I will be in vacation for 1 week. I will re-investigate this when
I will be back.

Thanks,
  Gérard.

