Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbTIPQqW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 12:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbTIPQqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 12:46:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:6870 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261858AbTIPQqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 12:46:21 -0400
Date: Tue, 16 Sep 2003 09:53:27 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Ramon Casellas <casellas@infres.enst.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bug/Oops Power Management with linux-2.6.0-test5-mm2
In-Reply-To: <Pine.SOL.4.40.0309161819150.7029-100000@gervaise.enst.fr>
Message-ID: <Pine.LNX.4.44.0309160949140.26788-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> When suspending to mem, actually it "looks like" it suspends. The only
> thing is that the LCD stays "light grey" (yep, I know it is not a
> technical description... :). In order to resume, I have to press the
> thinkpad power button (tap it, if I hold it for several seconds, it just
> powers off). When resuming, there must be a problem with interrumpts (NIC
> and Trackpoint stop working). So, it is not "immediate"

Ok, that's almost expected behavior. 

I cannot explain why the LCD stays on, besides the fact that something on 
the ACPI side of things is not working correctly. Though, it appears to be 
performing the entire suspend/resume cycle.

Drivers are still an issue. The current work around is to try removing all 
modules before suspending. There is also an issue with reinitializing the 
ACPI IRQ routing links, which will be addressed shortly. 

> pmdisk is not supported with high- or discontig-mem.

> (1 Gb RAM)
> 
> In both cases, when suspending to disk, it returns immediately.

Sorry, I missed that line in the logs before. You need HIGHMEM enabled to 
support the full 1GB of RAM, but the suspend-to-disk code is not prepared 
to handle high pages yet. It will be addressed, but probably not for 
another few weeks. 

Thanks,


	Pat

