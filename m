Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161350AbWJ3SuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161350AbWJ3SuR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161351AbWJ3SuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:50:17 -0500
Received: from smtpout.mac.com ([17.250.248.186]:52703 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1161350AbWJ3SuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:50:15 -0500
In-Reply-To: <20061030144259.GD10235@parisc-linux.org>
References: <200610282350.k9SNoljL020236@freya.yggdrasil.com> <Pine.LNX.4.64.0610281651340.3849@g5.osdl.org> <A2B15573-3DDD-4F70-AC04-C37DBA3AC752@mac.com> <20061030144259.GD10235@parisc-linux.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <87F87E8E-9434-4844-AA3F-ED850BEFAD29@mac.com>
Cc: Linus Torvalds <torvalds@osdl.org>, "Adam J. Richter" <adam@yggdrasil.com>,
       akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pavel@ucw.cz, shemminger@osdl.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
Date: Mon, 30 Oct 2006 13:47:53 -0500
To: Matthew Wilcox <matthew@wil.cx>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 30, 2006, at 09:42:59, Matthew Wilcox wrote:
> On Mon, Oct 30, 2006 at 09:23:10AM -0500, Kyle Moffett wrote:
>> recursive make invocations and nested directories).  Likewise in  
>> the context of recursively nested busses and devices; multiple PCI  
>> domains, USB, Firewire, etc.
>
> I don't think you know what a PCI domain is ...

Fair enough, I guess I don't, really...

>> Well, perhaps it does.  If I have (hypothetically) a 64-way system  
>> with several PCI domains, I should be able to not only start  
>> scanning each PCI domain individually,  but once each domain has  
>> been scanned it should be able to launch multiple probing threads,  
>> one for each device on the PCI bus.  That is, assuming that I have  
>> properly set up my udev to statically name devices.
>
> There's still one spinlock that protects *all* accesses to PCI  
> config space.  Maybe we should make it one per PCI root bridge or  
> something, but even that wouldn't help some architectures.

Well, yes, but it would help some architectures.  It would seem  
rather stupid to build a hardware limitation into a 64+ cpu system  
such that it cannot initialize or reconfigure multiple pieces of  
hardware at once.  It also would help for more "mundane" systems such  
as my "Quad" G5 desktop which takes an appreciable time to probe all  
the various PCI, USB, SATA, and  Firewire devices in the system.

Cheers,
Kyle Moffett
