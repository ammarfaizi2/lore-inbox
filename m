Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTLQGqe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 01:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbTLQGqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 01:46:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:27862 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263645AbTLQGqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 01:46:32 -0500
Date: Tue, 16 Dec 2003 22:46:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
cc: arjanv@redhat.com, Gabriel Paubert <paubert@iram.es>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Martin Mares <mj@ucw.cz>, zaitcev@redhat.com, hch@infradead.org
Subject: Re: PCI Express support for 2.4 kernel
In-Reply-To: <3FDFF81F.7040309@intel.com>
Message-ID: <Pine.LNX.4.58.0312162240040.8541@home.osdl.org>
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com> 
 <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>  <3FDDACA9.1050600@intel.com>
 <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com>
 <Pine.LNX.4.58.0312151154480.1631@home.osdl.org> <3FDEDC77.9010203@intel.com>
 <Pine.LNX.4.58.0312160844110.1599@home.osdl.org> <3FDFF81F.7040309@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Dec 2003, Vladimir Kondratiev wrote:
> 
> Hopefully, they (or we, should I count myself?) are not completely brain
> dead. Old method still works.

Good. I just wanted to check from a timing perspective - it means that
this won't be an issue for most people for a while (ie until we start
seeing actual PCI-X-specific hardware and drivers rather than just the
support chipsets - and I obviously have no idea how long that will take)

So if this will only matter for PCI-X drivers and not for discovery etc, I
wonder if it wouldn't make sense to have this as a totally separate
function? Instead of trying to make the existing "pci_config_xxxx()" 
stuff work with PCI-X, wouldn't it be nicer to have the driver just map 
its config space on probe?

That way there would be no scalability issues (only as many pages mapped 
as there are actual physical PCI-X devices that care) _and_ there would be 
no performance issues (the users would not need to walk page tables or 
flush the TLB - they'd just have a direct-mapped pointer).

You could do it with just ioremap(), but you'd really want to abstract it 
out a bit, and have a "[un]map_pcix_config()" function?

			Linus
