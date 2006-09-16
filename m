Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWIPAe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWIPAe0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 20:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWIPAe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 20:34:26 -0400
Received: from mail1.webmaster.com ([216.152.64.169]:5638 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S932267AbWIPAeZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 20:34:25 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <xixi.limeng@gmail.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: UDP question.
Date: Fri, 15 Sep 2006 17:33:30 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEDAOHAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <a885b78b0609151702r3b4086c4l3bb79c2e5c9ddf4a@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 15 Sep 2006 17:36:34 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 15 Sep 2006 17:36:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Let me explain my network environment, My program is running on a two
> adapters machine, whose IP is 192.168.0.1/8 and 192.168.0.2/8, then,
> my destination is two machine, whose IP is 192.168.0.3/8 and
> 192.168.0.4/8. I use four 100M exchange and a 1000M exchange cennected
> them to ensure the choke point is not at network  equipment.

So both interfaces are part of the same network, and the machines are not
connected to the Internet? (The host ns4.bbn.com is 192.1.122.13, for
example.)

> when I use two socket without bonding, one socket is bind
> 192.168.0.1/8 and sendto 192.168.0.3/8, the other is bind
> 192.168.0.2/8 and sendto 192.168.0.4/8, but, as you see, I get a
> result that the speed of send by two adapters is equal to the only one
> adapter's.

None of your code gives the kernel any reason to prefer one interface over
the other. Why would an interface bound to 192.168.0.1 be better than one
for 192.168.0.2 if you're sending to 192.168.0.3?

> yesterday. I got an uncertain idea, is the problem that IP layer is
> separate with Eth layer ? when I bind src IP, it just do helpful to IP
> layer, not real bind the adapter? when I send, the real ethreal
> adapter is select by IP route? If the two interface can go
> destinnation both, IP layer will choose the frist, not use both? Am I
> right?

Correct, you are binding to the adapter's address, not to the adapter. The
IP routing layer still determines which interface a packet is transmitted
on.

> If so, when I use bonding, the adapter's physical address is the frist
> one, Do this means that all of the packet come to my machine will go
> through in the frist one adapter?

It depends how you have the IP routing layer configured. You can configure
it to select the adapter based on the source address if you want to.

DS


