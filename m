Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262959AbSJDR6t>; Fri, 4 Oct 2002 13:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262960AbSJDR6s>; Fri, 4 Oct 2002 13:58:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63750 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262959AbSJDR6q>;
	Fri, 4 Oct 2002 13:58:46 -0400
Message-ID: <3D9DD801.4090603@pobox.com>
Date: Fri, 04 Oct 2002 14:03:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
References: <Pine.LNX.4.44.0210040930581.1723-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Thu, 3 Oct 2002, Greg KH wrote:
> 
>>Here's some changesets that remove the pcibios_find_class(),
>>pci_find_device(), and pcibios_present() functions.  These functions
>>have been marked as obsolete since the 2.2 kernel, so it's about time
>>that we removed them.
> 
> 
> They are still in use by a lot of drivers.. I hate to break even more 
> drivers at this point in 2.5.x, and so quite frankly I'd rather just do 
> this in early 2.7.x instead. Unless somebody really steps up to the plate 
> and also fixes the drivers ("it's a ton of fun, and imagine all the 
> adoration you'll get from teenage girls/boys/ninja turtles for doing it")


Removing pcibios_present() makes a lot of sense, I have considered it 
deprecated for quite a while now.

Further (more a note to Greg), often the pci[bios]_present() call can be 
removed completely:  when it is followed by a pci_find_xxx or 
pci_register_driver() probe, which will obviously not find anything if 
PCI bus is absent, the pci_present() call can be removed completely.

I would love to deprecate pcibios_{read,write}_foo but I don't think we 
can remove them yet.  Likewise for pcibios_find_xxx... I haven't look at 
all the examples, but I would be worried about breaking ancient (but 
working) code.

That said, if you wanna do the cleanup, I wouldn't object to removing 
pcibios_find_xxx...

	Jeff


