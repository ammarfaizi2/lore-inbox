Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946274AbWJTQLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946274AbWJTQLa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946423AbWJTQLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:11:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:37998 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946274AbWJTQL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:11:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hi4WdTAv/krYkvXTotQuZFJ59BnMFLFdwyzmJQCRLffx4zZc/bqNFnSzZtJUicR5skgxY6bpwnZtx1Oew6vr6MJ+Vc6F5r3/0WZo0xNh2yfiw3JivYEsAZscWKICF/Rjd+5aLXgdHPWnfRN1nxw70AMgGh0p2hiAC1M3+OjNapM=
Message-ID: <91705d080610200911k3f24a088l233f0a73746bf6da@mail.gmail.com>
Date: Fri, 20 Oct 2006 09:11:26 -0700
From: "Dan Nicholson" <dbn.lists@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Sundance driver fails to report carrier correctly
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In attempting to add carrier status to my networking scripts, I
realized that the info exported through
/sys/class/net/<interface>/carrier is not updated for my network card.
This file always lists 1 whether the network cable is connected or
not.

[cable plugged in]
$ cat /sys/class/net/eth0/carrier
1
[cable unplugged]
$ cat /sys/class/net/eth0/carrier
1

At first I thought maybe this was just a sysfs issue, but ip and
ifconfig never list NO-CARRIER either.

The card is a D-Link DFE-550TX using the sundance driver. Here's what
lspci has to say about the card:

00:0f.0 Ethernet controller: D-Link System Inc DL10050 Sundance
Ethernet (rev 12)
        Subsystem: D-Link System Inc DFE-550TX
        Flags: bus master, medium devsel, latency 80, IRQ 10
        I/O ports at 1000 [size=128]
        Memory at e000a400 (32-bit, non-prefetchable) [size=512]
        [virtual] Expansion ROM at 30000000 [disabled] [size=64K]
        Capabilities: <access denied>

I'm running 2.6.18.1 right now. dmesg reports nothing unusual about
the driver/card/interface AFAIK.

...
sundance.c:v1.1 27-Jun-2006  Written by Donald Becker
  http://www.scyld.com/network/sundance.html
...
eth0: D-Link DFE-550TX FAST Ethernet Adapter at 00011000,
00:05:5d:e5:ae:08, IRQ 10.
eth0: MII PHY found at address 1, status 0x782d advertising 01e1.
eth0: MII PHY found at address 0, status 0x782d advertising 01e1.
...
eth0: Link changed: 100Mbps, full duplex
...

I also tried 2.6.19-rc2 briefly since I saw there had been some
changes in drivers/net/sundance.c, but the behavior is the same. Same
behavior on 2.6.17.10, too. I have a couple older kernels (2.6.12,
2.6.14 and 2.6.16 series) that I haven't checked. I took a look at the
code, but I'm in way over my head.

Any ideas? If anyone would like more information, please let me know. Thanks.

--
Dan
