Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268274AbUHQOrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268274AbUHQOrh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268272AbUHQOrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:47:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19603 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268248AbUHQOrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:47:06 -0400
Date: Tue, 17 Aug 2004 10:46:04 -0400
From: Alan Cox <alan@redhat.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Message-ID: <20040817144604.GA30778@devserv.devel.redhat.com>
References: <20040815151346.GA13761@devserv.devel.redhat.com> <200408171512.26568.bzolnier@elka.pw.edu.pl> <20040817140533.GB2019@devserv.devel.redhat.com> <200408171630.07979.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408171630.07979.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 04:30:07PM +0200, Bartlomiej Zolnierkiewicz wrote:
> You forgot about the sad fact that most host drivers can be modular
> thanks to prematuraly making them modular in 2.4. :/

If they are modular their order already changes in some case

> ide_match_hwif() checks for hwif->chipset - ordering will not be the same
> i.e. you load driver for some IDE PCI controller which doesn't have drives 
> attached to it, unload it, load some other driver - hwifs will be reused - 
> some sequence in 2.4 will possibly leave you with different ordering because 
> hwif->chipset will stay as ide_pci not ide_unknown

You can't unload them in 2.4. 

> There are other much more crazy scenerios when you consider using 
> HDIO_SCAN_HWIF nad HDIO_UNREGISTER_HWIF ioctls. ;)

Those cases yes

> > Once you have drive and controller hot plug you don't need them. Until then
> 
> Yep, please tell me how are you going to support drive hot plug?

We can do it the 2.4-ac way - that works with the locking I think. What
might be nicer if it works out is to follow the shutdown/suspend code
approach so that we actually queue the "unplug" into the command stream.

> > some laptop users rely on them. I'd prefer to ignore the issue (its a
> > privileged code path) until the hotplug is there, or patch it up by
> > allowing unregister only of SCAN_HWIF added hwifs ?
> 
> I prefer short deprecation -> removal -> forgetting about them. :)

Ditto but I need the thinkpad docking bay working somehow.

Alan

