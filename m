Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbVKAEHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbVKAEHe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 23:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbVKAEHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 23:07:34 -0500
Received: from smtpout.mac.com ([17.250.248.88]:40183 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965015AbVKAEHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 23:07:33 -0500
In-Reply-To: <200510311909.32694.david-b@pacbell.net>
References: <17253.43605.659634.454466@cargo.ozlabs.ibm.com> <200510311741.56638.david-b@pacbell.net> <1130812903.29054.408.camel@gaston> <200510311909.32694.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BC88D0A1-453F-4716-96E6-3C89B915C477@mac.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-usb-devel@lists.sourceforge.net,
       Paul Mackerras <paulus@samba.org>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [linux-usb-devel] Re: Commit "[PATCH] USB: Always do usb-handoff" breaks my powerbook
Date: Mon, 31 Oct 2005 23:06:53 -0500
To: David Brownell <david-b@pacbell.net>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 31, 2005, at 22:09:32, David Brownell wrote:
>>> Which logic?  The fundamental thing those USB handoff functions  
>>> do is make sure that BIOS code lets go of the host controllers.   
>>> The main reason it'd be using a controller is because of USB  
>>> keyboards, mice, or maybe boot disks.  Secondarily, that code  
>>> needs to make sure the controller is really quiesced before Linux  
>>> starts using it.
>>
>> So you rant about "ppc specific" whatever while the entire point  
>> of this code is to workaround x86 specific BIOS junk ...
>
> Actually any "sophisticated" boot loader nowadays will know  
> something about USB, to handle keyboards, mice, or maybe boot disks.

OpenFirmware is quite knowledgeable about USB devices, both disks,  
mice, keyboards, and IIRC there's even a USB<=>serial bridge useable  
as an OpenFirmware console.

> On some platforms, u-Boot understands OHCI ... so that's not just  
> x86 BIOS or other closed-source firmware.

On other platforms, OpenFirmware supports direct ELF loading without  
any extra code.  If you want initrd support, you need a little Forth  
script (IE: yaboot) to load it into some RAM first.

The difference is, OpenFirmware is nice and clean and stops messing  
with hardware before handing off to the new kernel.  If you ever try  
to boot from an invalid ELF file on an OpenFirmware machine, you'll  
see that's fairly obvious, because the screen flashes and changes  
state slightly during the failed boot attempt (after which it  
reconnects to the hardware again to display messages).

Why should x86-specific-BIOS-USB-handoff-specific-crap-PCI-quirks be  
even _compiled_ on PowerPC systems that have nothing remotely like  
the affected hardware (BIOS & PS/2 serio chip)?

Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay



