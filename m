Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314596AbSGIMSB>; Tue, 9 Jul 2002 08:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314602AbSGIMSA>; Tue, 9 Jul 2002 08:18:00 -0400
Received: from oak.sktc.net ([208.46.69.4]:42759 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id <S314596AbSGIMR7>;
	Tue, 9 Jul 2002 08:17:59 -0400
Message-ID: <3D2AD518.6090706@sktc.net>
Date: Tue, 09 Jul 2002 07:20:40 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020612
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Driverfs updates
References: <Pine.LNX.3.95.1020709073843.24291A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been following this thread for some time, and one aspect of it 
disturbs me - the principle of symmetry.

I've found that generally, in design thing should be symmetric - if you 
can turn a thing on, you could be able to turn it off, if you can heat a 
thing, you should be able to cool it, and if you can load a thing, you 
should be able to unload it.

In the old days, a computer was "complete" when it booted - all things 
that ever would be in the machine during that run were present at boot, 
and the only way something could be added would be to turn the machine 
off. In such an environment, a monolithic kernel loaded at boot made sense.

Now, we have things like Firewire, USB, Bluetooth, PCMCIA, Hot-Plug PCI 
and TCP/IP attached devices, all of which can come and go as they 
please. Loadable modules made supporting such things easy - witness the 
trouble WinNT had dealing with PCMCIA vs. Linux.

However, if you cannot unload modules, then the kernel grows without 
bound - the mere fact that a Bluetooth camera came into range causes the 
kernel to grow as the driver gets loaded. True, you could go in as root 
and clean up, but it seems to me that requiring root to do that sort of 
periodic maintainance prevents Linux from being able to be the Energizer 
Bunny OS - "it keeps going and going...." without much diddling.

It seems to me the problem is in designing modules to unload, and saying 
"Then don't unload them" is not even a band-aid - it is willful 
ignorance. If there is a potential race condition unloading a module, 
then the module is BROKEN.

