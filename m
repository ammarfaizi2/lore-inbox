Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261729AbSJUWEF>; Mon, 21 Oct 2002 18:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbSJUWEF>; Mon, 21 Oct 2002 18:04:05 -0400
Received: from ausadmmsrr503.aus.amer.dell.com ([143.166.83.90]:32016 "HELO
	AUSADMMSRR503.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S261729AbSJUWED>; Mon, 21 Oct 2002 18:04:03 -0400
X-Server-Uuid: 91331657-2068-4fb8-8b09-a4fcbc1ed29f
Message-ID: <20BF5713E14D5B48AA289F72BD372D68C1EA2E@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: andmike@us.ibm.com, cliffw@osdl.org
cc: linux-kernel@vger.kernel.org, linux-megaraid-devel@dell.com
Subject: RE: 2.5.44 compile problem: MegaRAID driver
Date: Mon, 21 Oct 2002 17:10:05 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 11AAA4B41769635-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The scsi host interface change in 2.5.44. The megaraid driver wanted
> direct access to this list to reorder it. This cannot be done 
> anymore as we try get list coherence under control.
> The patch below removes the reorder as I could not see why reorder the
> list. It also replaces some other traverse loops with a 
> direct access to the host pointer copy.

The host reordering is to solve the same problem that EDD helps us solve now
- it makes sure that in systems with megaraid adapters that also have BIOS
enabled (thus have the bootable logical drive on that card) that it shows up
first (/dev/sda) on the host list instead of later.   Fortunately, newer
megaraid cards support EDD properly, some older ones don't :-(    All that
code is a figment of the need to know where the boot disk is, and to project
it first in the order.

For now, yes, the right thing is to delete those routines and get the
megaraid driver functional again sans adapter reordering.  In megaraid2 for
2.5.x we'll need to figure out a better way to handle this - maybe we won't
have to if EDD works as advertised. :-)

> The maintainer of the driver will need to ok and comment on any side
> effects. I will look at the driver some more to see if I 
> understand the reorder.

linux-megaraid-devel@dell.com has the right people subscribed (subscribe at
http://lists.us.dell.com) - it's really LSI's driver and I want them to be
the folks maintaining it.  I've just helped out now and again...  LSI hasn't
had time to look at 2.5.x at all.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

