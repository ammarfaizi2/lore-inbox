Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314139AbSDVMSL>; Mon, 22 Apr 2002 08:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314140AbSDVMSK>; Mon, 22 Apr 2002 08:18:10 -0400
Received: from [193.154.7.22] ([193.154.7.22]:13934 "EHLO
	freedom.icomedias.com") by vger.kernel.org with ESMTP
	id <S314139AbSDVMSK> convert rfc822-to-8bit; Mon, 22 Apr 2002 08:18:10 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: AW: nbd + raid1 + 2.4.19-pre7
Date: Mon, 22 Apr 2002 14:18:00 +0200
Message-ID: <D143FBF049570C4BB99D962DC25FC2D2159B00@freedom.icomedias.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: nbd + raid1 + 2.4.19-pre7
Thread-Index: AcHp9CPH6gpf9BlWQ3OLtB/MPi5H4gAAwOdw
From: "Martin Bene" <martin.bene@icomedias.com>
To: "Thomas Zeitlhofer" <tzeitlho+lkml@nt.tuwien.ac.at>,
        <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

> The setup here:
> 
>    /dev/md106: raid1 over /dev/md6 (raid1 over two ide disks) and
>                           /dev/nd6 
>    using nbd-server and nbd-client from nbd-2.0 (sf.net/projects/nbd/)
> 
> When disconnecting the network link between nbd-server and nbd-client
> all processes attempting IO to /dev/nd6 are hanging in D state for
> exactly 15 minutes. During this time the load of the machine increases
> by about 2 for each IO attempt. Using the raid1 setup from above, all
> IO attempts to _other_ raid1 devices (e.g. /dev/md0 which is 
> raid1 over
> two ide disks) are hanging in D state, too. After the 15 minutes 
> period the load drops down and everything is working fine again -
> also /dev/nd6 has been marked faulty as expected.
> (same behavior in 2.4.18-ac3)
> 
> Any suggestions how to avoid this long time period before the machine
> becomes usable again?

Any special reason you're trying to do build your network replicated disk using nbd+raid1? I've found the drbd driver (http://www.linbit.com/en/drbd) quite useful for exactly this kind of setup. I think the standard raid1 driver is a poor choice in this setup becaus you can't tell it that there's a fairly severe performance penalty for access to one of the devices, so it sohould always read from the local device and just send updates to the remote one. drbd does just that.

Bye, Martin
