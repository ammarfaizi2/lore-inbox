Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265829AbTIKAdi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 20:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265839AbTIKAdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 20:33:37 -0400
Received: from mail5.intermedia.net ([206.40.48.155]:60421 "EHLO
	mail5.intermedia.net") by vger.kernel.org with ESMTP
	id S265829AbTIKAdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 20:33:33 -0400
Subject: Re: [OOPS] Linux-2.6.0-test5-bk
From: Ranjeet Shetye <ranjeet.shetye2@zultys.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
In-Reply-To: <20030911002404.GA7178@kroah.com>
References: <1063232210.4441.14.camel@ranjeet-pc2.zultys.com>
	 <20030910154608.14ad0ac8.akpm@osdl.org>
	 <1063239544.1328.22.camel@ranjeet-pc2.zultys.com>
	 <20030911002404.GA7178@kroah.com>
Content-Type: text/plain
Organization: Zultys Technologies Inc.
Message-Id: <1063240611.1327.37.camel@ranjeet-pc2.zultys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 10 Sep 2003 17:36:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-10 at 17:24, Greg KH wrote:
> On Wed, Sep 10, 2003 at 05:19:05PM -0700, Ranjeet Shetye wrote:
> > 
> > Your changes fixed the issue. Thanks a lot for your help. I still get
> > this call trace, but no more OOPS on bootup.
> > 
> > kobject_register failed for Ensoniq AudioPCI (-17)
> > Call Trace:
> >  [<c026f45c>] kobject_register+0x50/0x59
> >  [<c02f8003>] bus_add_driver+0x4c/0xaf
> >  [<c02f8453>] driver_register+0x31/0x35
> >  [<c027c3bf>] pci_populate_driver_dir+0x29/0x2b
> >  [<c027c491>] pci_register_driver+0x5e/0x83
> >  [<c06a145f>] alsa_card_ens137x_init+0x15/0x41
> >  [<c068475a>] do_initcalls+0x2a/0x97
> >  [<c012e920>] init_workqueues+0x12/0x2a
> >  [<c01050a3>] init+0x39/0x196
> >  [<c010506a>] init+0x0/0x196
> >  [<c0108f31>] kernel_thread_helper+0x5/0xb
> 
> Odds are that the pci driver is trying to register 2 drivers with the
> pci core with the same name.  What does /sys/bus/pci/drivers show?
> 
> thanks,
> 
> greg k-h

Hi Greg,

I didn't find a /proc/sys/bus/pci/drivers, but I did find a
/proc/bus/pci/devices - which is what I am guessing you meant. If you
did in fact mean '/proc/sys/bus/pci/drivers' then I dont have any such
file. In fact I dont have a bus sub-directory under /proc/sys/

Anyways, here's the output:

cat /proc/bus/pci/devices

0000    80862560        0       f0000008        00000000       
00000000        00000000        00000000        00000000       
00000000        08000000        00000000   00000000       
00000000        00000000        00000000        00000000       
agpgart-intel

0010    80862562        10      e8000008        ff680000       
00000000        00000000        00000000        00000000       
00000000        08000000        00080000   00000000       
00000000        00000000        00000000        00000000

00e8    808624c2        10      00000000        00000000       
00000000        00000000        0000ff81        00000000       
00000000        00000000        00000000   00000000       
00000000        00000020        00000000        00000000        uhci-hcd

00e9    808624c4        13      00000000        00000000       
00000000        00000000        0000ff61        00000000       
00000000        00000000        00000000   00000000       
00000000        00000020        00000000        00000000        uhci-hcd

00ea    808624c7        12      00000000        00000000       
00000000        00000000        0000ff41        00000000       
00000000        00000000        00000000   00000000       
00000000        00000020        00000000        00000000        uhci-hcd

00ef    808624cd        17      ffa00800        00000000       
00000000        00000000        00000000        00000000       
00000000        00000400        00000000   00000000       
00000000        00000000        00000000        00000000        ehci_hcd

00f0    8086244e        0       00000000        00000000       
00000000        00000000        00000000        00000000       
00000000        00000000        00000000   00000000       
00000000        00000000        00000000        00000000

00f8    808624c0        0       00000000        00000000       
00000000        00000000        00000000        00000000       
00000000        00000000        00000000   00000000       
00000000        00000000        00000000        00000000

00f9    808624cb        12      00000000        00000000       
00000000        00000000        0000ffa1        10000000       
00000000        00000000        00000000   00000000       
00000000        00000010        00000400        00000000        PIIX IDE

00fb    808624c3        11      00000000        00000000       
00000000        00000000        0000dc81        00000000       
00000000        00000000        00000000   00000000       
00000000        00000020        00000000        00000000

00fd    808624c5        11      0000d801        0000dc41       
ffa00400        ffa00000        00000000        00000000       
00000000        00000100        00000040   00000200       
00000100        00000000        00000000        00000000        Intel
ICH

0138    16ae1141        10      f80fe008        00000000       
00000000        00000000        00000000        00000000       
00000000        00002000        00000000   00000000       
00000000        00000000        00000000        00000000

0140    10ec8139        11      0000ec01        ff8ffc00       
00000000        00000000        00000000        00000000       
00000000        00000100        00000100   00000000       
00000000        00000000        00000000        00000000        8139too

0160    8086100e        12      ff8c0000        00000000       
0000e8c1        00000000        00000000        00000000       
00000000        00020000        00000000   00000040       
00000000        00000000        00000000        00000000        e1000

thanks,

-- 

Ranjeet Shetye
Senior Software Engineer
Zultys Technologies
Ranjeet dot Shetye2 at Zultys dot com
http://www.zultys.com/
 
The views, opinions, and judgements expressed in this message are solely
those of the author. The message contents have not been reviewed or
approved by Zultys.


