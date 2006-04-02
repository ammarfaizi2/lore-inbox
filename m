Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWDBUZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWDBUZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 16:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWDBUZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 16:25:28 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:20478 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S932333AbWDBUZ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 16:25:28 -0400
Date: Sun, 02 Apr 2006 15:25:25 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Firewire problems, apparently since 2.6.13-rc1
In-reply-to: <1144004450.11043.1.camel@mindpipe>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200604021625.25594.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <200604021418.16263.gene.heskett@verizon.net>
 <1144004450.11043.1.camel@mindpipe>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 April 2006 15:00, Lee Revell wrote:
>On Sun, 2006-04-02 at 13:18 -0500, Gene Heskett wrote:
>> Greetings;
>>
>> How much trouble will I have if I take the current 2.6.16.1 kernel
>> src tree, nuke the ieee1394 directory of it, and bring the ieee1394
>> directory in from the 2.6.12 tarball?
>
>This has no chance of working.

As I found.  "time ./makeit" died a horrible death on the first module
of the ieee1394 stuffs.
>
>> At 2.6.12, all the firewire stuff I needed to import from my camera,
>> edit it, and make vcd's or dvd's out of it worked _flawlessly_. 
>> Now, at 2.6.16.1, and apparently since 2.6.13-rc1, kino is broken
>> and must be killed by the system when it hangs.  I figured it would
>> get sorted, but apparently not.
>
>That's always a bad assumption.  Bugs should be reported early and
>often.

I didn't have a good excuse to test it again till the missus asked 
me if I could put her vhs collection onto dvd's about a week ago.  
My camera was going to be the translator from its AV/IO to the 
firewire, hence to kino for encoding into dvd stuffs.  Other than 
that, I've had no excuse to test it since testing it will typically 
make multi-gigabyte files, and my 60GB /usr is at 89% right now.

I think its time I mounted a new SeaCrate 120GB and do an install
of FC5 on it just for frowns and screaming hissy fits.  I sure hope
its better than FC4 was cause I was never able to make an install 
of that actually get to the login screen but once.

>> I can recover from backups all the stuff I've overwritten in the
>> last 2 days trying to make it work.  That should make it all work
>> again IF the ieee1394 stuff was reverted to the 2.6.12 version.  Is
>> this feasable at all?
>
>No - it would be a much better use of your time to put together an
>actionable bug report.  The above is too vague... can you get an
> strace or GDB backtrace of the hung process, dmesg, etc

The logs seem to be relatively silent except for some stuff about 
a dma thats too slow or some such, lemme see if I can find a line from 
messages.1.

>From when I booted 2.6.16:
Mar 26 23:22:48 coyote kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[12]  MMIO=[ec004000-ec0047ff]  Max Packet=[2048]IR/IT contexts=[4/8]

And later but still doing init.d stuff:

Mar 26 23:22:33 coyote ieee1394.agent[1591]: ... no drivers for IEEE1394 product 0x/0x/0x
Mar 26 23:22:33 coyote ieee1394.agent[1605]: ... no drivers for IEEE1394 product 0x/0x/0x
Mar 26 23:22:33 coyote ieee1394.agent[1614]: ... no drivers for IEEE1394 product 0x000000/0x00005e/0x000001

Looks normal to me.
Then when I plug in the camera and turn it on (this is from 2.6.16.1):
Apr  1 13:10:21 coyote ieee1394.agent[15986]: ... no drivers for IEEE1394 product 0x/0x/0x
Apr  1 13:10:21 coyote ieee1394.agent[16000]: ... no drivers for IEEE1394 product 0x/0x/0x
Apr  1 13:10:21 coyote kernel: ieee1394: raw1394: /dev/raw1394 device initialized
Apr  1 13:14:01 coyote kernel: ieee1394: hpsb_update_config_rom() is deprecated
Apr  1 13:14:01 coyote kernel: ieee1394: Failed to generate Configuration ROM image for host 0

Which I don't understand at all, but I'm NOT a firewire guru either.

Then I turned on the debugging, which made copious output, but 
didn't seem to point any fingers.

Then I tried to plug in the camera, getting about the same 
as above except more verbose.

Fireing up kino then generated several hundred kilobytes of 
what to me is confusing. Here's a sample:

Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: IntEvent: 00020010
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: irq_handler: Bus reset requested
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Cancel request received
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Got RQPkt interrupt status=0x00008409
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Single packet rcv'd
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Single packet rcv'd
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: IntEvent: 00010000
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: SelfID interrupt received (phyid 1, root)
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: SelfID packet 0x807f0882 received
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: SelfID packet 0x817f8c74 received
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: SelfID for this node is 0x817f8c74
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: SelfID complete
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: PhyReqFilter=ffffffffffffffff
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Cycle master enabled
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Inserting packet for node 0-00:0000, tlabel=0, tcode=0x0, speed=0
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Starting transmit DMA ctx=0
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: IntEvent: 00000001
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Got reqTxComplete interrupt status=0x00008011
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Packet sent to node 0 tcode=0xE tLabel=0 ack=0x11 spd=0 data=0x00000000 ctx=
0
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Inserting packet for node 0-00:1023, tlabel=6, tcode=0x4, speed=0
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Waking transmit DMA ctx=0
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: IntEvent: 00000001
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Got reqTxComplete interrupt status=0x00008012
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Packet sent to node 0 tcode=0x4 tLabel=6 ack=0x12 spd=0 data=0x00000000 ctx=
0
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: IntEvent: 00000020
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Got RSPkt interrupt status=0x00008411
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Single packet rcv'd
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Packet received from node 0 ack=0x11 spd=0 tcode=0x6 length=20 ctx=0 tlabel=
6
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Inserting packet for node 0-00:1023, tlabel=7, tcode=0x4, speed=0
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Waking transmit DMA ctx=0
Apr  1 11:26:15 coyote ieee1394.agent[4163]: ... no drivers for IEEE1394 product 0x/0x/0x
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: IntEvent: 00000001
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Got reqTxComplete interrupt status=0x00008012
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Packet sent to node 0 tcode=0x4 tLabel=7 ack=0x12 spd=0 data=0x00000000 ctx=
0
Apr  1 11:26:15 coyote ieee1394.agent[4177]: ... no drivers for IEEE1394 product 0x/0x/0x
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: IntEvent: 00000020
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Got RSPkt interrupt status=0x00008411
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Single packet rcv'd
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Packet received from node 0 ack=0x11 spd=0 tcode=0x6 length=20 ctx=0 tlabel=
7
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Inserting packet for node 0-00:1023, tlabel=8, tcode=0x4, speed=0
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Waking transmit DMA ctx=0
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: IntEvent: 00000001
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Got reqTxComplete interrupt status=0x00008012
Apr  1 11:26:15 coyote kernel: ohci1394: fw-host0: Packet sent to node 0 tcode=0x4 tLabel=8 ack=0x12 spd=0 data=0x00000000 ctx=0

Rinse, repeat till bored, no video is shown by kino-7.5 and its crashed.
I've updated the libraw and libdv stuff, installed the iec6**** stuff, 
then tried to build kino-0.8 and I'm in dependency hell as it needs a 
newer libglade and that seems to need about 6 other packages I can't find.

And to add to the misery, yum is now broken due to a Config.py it doesn't
like.  And No Damned Idea where that came from.  Looking at them, none of
them are new enough to have caused yum to break in the last 2 days:

[root@coyote /]# ls -l `locate Config.py`
-rw-r--r--  1 root root  6411 Jan 16  2003 /usr/lib/python2.3/site-packages/Ft/Server/Server/GlobalConfig.py
-rw-r--r--  1 root root  5658 Mar  4  2004 /usr/lib/python2.3/site-packages/Ft/Server/Server/GlobalConfig.pyc
-rw-r--r--  1 root root  5930 Mar  4  2004 /usr/lib/python2.3/site-packages/Ft/Server/Server/GlobalConfig.pyo
-rw-r--r--  1 root root  2636 Jun 10  2002 /usr/lib/python2.3/site-packages/Ft/Server/Server/ServerConfig.py
-rw-r--r--  1 root root  3304 Mar  4  2004 /usr/lib/python2.3/site-packages/Ft/Server/Server/ServerConfig.pyc
-rw-r--r--  1 root root  3508 Mar  4  2004 /usr/lib/python2.3/site-packages/Ft/Server/Server/ServerConfig.pyo
-rw-r--r--  1 root root 24323 Nov 24  2004 /usr/lib/python2.3/site-packages/pychecker/Config.py
-rw-r--r--  1 root root 20800 Feb 23  2004 /usr/lib/python2.3/site-packages/pychecker/Config.pyc
-rw-r--r--  1 root root 21340 Feb 23  2004 /usr/lib/python2.3/site-packages/pychecker/Config.pyo
-rw-r--r--  1 root root 17703 Nov 17  2003 /usr/lib/python2.3/site-packages/pychecker/Config.py-old
-rwxr-xr-x  1 root root  6966 Jan 22  2004 /usr/share/rhn/up2date_client/sourcesConfig.py
-rw-r--r--  1 root root  8347 May 11  2004 /usr/share/rhn/up2date_client/sourcesConfig.pyc
-rw-r--r--  1 root root 24495 Jul 28  2004 /usr/share/rpmlint/Config.py
-rw-r--r--  1 root root 24058 Mar  4  2005 /usr/share/rpmlint/Config.pyo


I've got just about a 6-pack of beer, but I don't think thats going 
to be enough for this headache...

>Lee

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
