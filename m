Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318964AbSHSSBN>; Mon, 19 Aug 2002 14:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318965AbSHSSBN>; Mon, 19 Aug 2002 14:01:13 -0400
Received: from air-2.osdl.org ([65.172.181.6]:15754 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S318964AbSHSSBM>;
	Mon, 19 Aug 2002 14:01:12 -0400
Date: Mon, 19 Aug 2002 11:10:58 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Adam Belay <ambx1@netscape.net>
cc: greg@kroah.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.31 driverfs: patch for your consideration
In-Reply-To: <3D5ECEFE.4020404@netscape.net>
Message-ID: <Pine.LNX.4.44.0208191103160.1048-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I downloaded my patches through the mailing list and applied them:
> 
> bash-2.05a$ cat ./driver.patch | patch -p1 -l -d linux
> patching file drivers/base/interface.c
> bash-2.05a$ cat ./driver2.patch | patch -p1 -l -d linux
> patching file drivers/base/base.h
> patching file drivers/base/core.c
> patching file drivers/base/interface.c
> 
> It applies cleanly but . . .

patch -l does not imply cleanly. That will ignore the whitespace munging 
that your MUA is doing. 

> You're right the tabs are gone although when I applied my originals they 
> weren't.  I hate netscape navigator.  I gzipped them so netscape can't 
> mess them up.  In the meantime I'm going to download mutt.  Thanks for 
> your help.  Let me know if the patch works this time.  Also after 
> looking at the interface code I realized that not just my code used 
> sprintf.  Do you think they should all use snprintf instead or is the 
> probability of a driver attribute exceeding the one page buffer size so 
> low that it doesn't matter?

They should use snprintf. Thanks for pointing that out. 

> Also I was wondering if you think resource management variables (irq,
> io, dma, etc) should live in the device structure like power management
> variables do?  Global resource management seams interesting to me,
> although there already is a proc interface that does list resources, I'm
> wondering if the driver model is a good place to put such an interface?

Yes. We talked about doing that from the very beginning, and were going to 
see how things worked out. There was some dicussion about this at OLS, 
too. But, I'm not sure it's ready for it yet.

What would be nice would be some way to cleanly represent conditional 
attributes of devices, like resource and power management. I think I 
almost have something with the device interface stuff, but I fear it's a 
fine line to cross over into Abstraction Hell... 

</tangent>

	-pat

