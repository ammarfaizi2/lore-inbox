Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUJWDpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUJWDpG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266888AbUJVTkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:40:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64704 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267250AbUJVTdh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:33:37 -0400
Message-ID: <41796083.9060301@pobox.com>
Date: Fri, 22 Oct 2004 15:33:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com> <4177DF15.8010007@techsource.com> <4177E50F.9030702@sover.net> <200410220238.13071.jk-lkml@sci.fi> <41793C94.3050909@techsource.com> <417955D3.5020206@pobox.com> <41795DEA.8050309@techsource.com>
In-Reply-To: <41795DEA.8050309@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> AGP and PCI are very similar in terms of the state machine, although the 
> signal drivers are different.  I expect we'll come out with PCI and AGP 
> versions first and then PCIE soon after.  Any "early access" developer 
> boards would be PCI-only.

That's certainly quite reasonable.



> At this moment, I'm taking a cue from the Linux driver ABI and thinking 
> that standardizing the interface would be more limiting than helpful. 

No offense, but I strongly disagree :)

Standardizing the hardware interface lowers the cost of doing an OS 
driver for every chip maker that implements the interface.  The more 
chip makers that implement the interface, the greater the cost savings.

Concrete examples:
* IDE BMDMA interface on PCI.  Practically every ATA chipset in 
production supports this interface.  As a consequence, each individual 
ATA driver mainly involves setting chip-specific timings, and not much else.

* tulip (ethernet MAC).  Its ring and register designs were widely 
imitated across ethernet NICs; as a result, each ethernet driver is 
mainly a "paint by numbers" affair.

* the new AHCI SATA interface, which Intel has on all its new 
motherboards, and SiS soon will as well (as will others, I hope).


> While it might be a pain to have to carry around multiple driver 
> versions, the fact that it's all open source kinda makes it easy to make 
> drastic changes without hurting anything.

Ever-changing hardware and firmware interfaces are a huge pain.  I've 
been writing and maintaining drivers for years... I feel this pain every 
day :)

You want to design a hardware interface that allows you to upgrade and 
enhance your hardware over time, while keeping the changes to the 
hardware<->OS interface itself to a _bare minimum_.  That's why I 
suggested the microcontroller+GPU approach.  The microcontroller's 
firmware can be used to mask the transition between GPU revisions.

Drivers live for many years, even decades, and long after the hardware 
they support has been EOL'd.  It's in everybody's best interests to keep 
the changes to the drivers to a minimum.


> Plus, I don't expect to get it perfect the first time.  The first design 

Part of open source is open development.  If you develop the hardware 
interface in public, actively soliciting feedback during development, 
you'll wind up with a much better interface.

Regards,

	Jeff


