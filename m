Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272356AbTGaDsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 23:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272366AbTGaDsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 23:48:25 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:10113 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S272356AbTGaDsY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 23:48:24 -0400
Message-ID: <3F28923F.8000107@pacbell.net>
Date: Wed, 30 Jul 2003 20:51:27 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net> <20030726210123.GD266@elf.ucw.cz> <3F288CAB.6020401@pacbell.net>
In-Reply-To: <3F288CAB.6020401@pacbell.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

> The pm_*() is how a handful of sound drivers and other random
> stuff register themselves -- and how PCI does it.

To clarify, before someone jumps all over me:  look inside
the PCI code, you'll see that PCI as a whole is registered
using the pm_*() stuff for power management.  Yes, when
those callbacks get made, they morph into driver model calls.

Which means that PCI devices (like OHCI) don't fit into the
suspend/resume sequence in the way one would expect.  It
might explain why I'm still seeing two equivalent suspend
notifications in the OHCI code...

- Dave


> I'd sure have expected PCI to only use the driver model stuff,
> and I'll hope all those users will all be phased out by the
> time that 2.6 gets near the end of its test cycle.

