Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316773AbSFVRWi>; Sat, 22 Jun 2002 13:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316649AbSFVRWh>; Sat, 22 Jun 2002 13:22:37 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:64762 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S316608AbSFVRWf>; Sat, 22 Jun 2002 13:22:35 -0400
Date: Sat, 22 Jun 2002 10:24:31 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] /proc/scsi/map
To: Nick Bellinger <nickb@attheoffice.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Message-id: <3D14B2CF.90002@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On the other hand there is the obvious fact that an iSCSI initiator
> driver is not attached to a bus, and assuming /root/iSCSI.target/disk1
> etc, is out of the question.  There is a real need for a solution to
> handle virtual devices (as stated your previous message) that are not
> assoicated with any physical connectors.  

There are those who see the IP stack as a kind of logical bus ... :)
It's just not tied any specific hardware interface; it's "multipathed" in
some sense. Linking it to an eth0 entry in $DRIVERFS/root/pci0/00:10.0
would be wrong, since it can also be accessed through eth2.

Why shouldn't there be a $DRIVERFS/net/ipv4@10.42.135.99/... style hookup
for iSCSI devices?  Using whatever physical addressing the kernel uses
there, which I assume wouldn't necessarily be restricted to ipv4.  (And
not exposing physical network topology -- routing! -- in driverfs.)


On a related topic ... if driverfs is going to be providing a nice unique
ID for the controller ($DRIVERFS/root/pci0/00:02.0/02:0f.0/03:07.0 for
Linus' behind-two-bridges case), why are people talking as if the SCSI
layer's arbitrary "controller number" should still be getting pushed as
part of user visible names?

That is, I'd sure hope the standard policy for assigning driverfs names
would avoid _all_ IDs that are derived from enumeration order.  Otherwise
it'll be hard to store those names for (re)use by user mode tools.

To be sure, those IDs can still be exposed when needed, since in the
"very big picture" attribute-based names end up being the only really
scalable model.  But putting unstable attributes into path names just
causes trouble.  (Much like putting device types in path names.)  If
they're really necessary (why?) driverfs makes it easy to expose them
in better ways.

- Dave


