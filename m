Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbUKLK2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbUKLK2s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 05:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbUKLK2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 05:28:47 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:36529 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262497AbUKLK2W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 05:28:22 -0500
In-Reply-To: <OF66747F56.DA01CD7C-ON42256F4A.00376891-42256F4A.0037821E@LocalDomain>
Subject: Re: [patch 4/10] s390: network driver.
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF88EC0E9F.DE8FC278-ONC1256F4A.0038D5C0-C1256F4A.00398E11@de.ibm.com>
From: Thomas Spatzier <thomas.spatzier@de.ibm.com>
Date: Fri, 12 Nov 2004 11:28:39 +0100
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.0.2CF2HF259 | March 11, 2004) at
 12/11/2004 11:28:19
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> You should be using netif_carrier_{on,off} properly, and not drop the
> packets.  When (if) link comes back, you requeue the packets to hardware
> (or hypervisor or whatever).  Your dev->stop() should stop operation and
> clean up anything left in your send/receive {rings | buffers}.
>

When we do not drop packets, but call netif_stop_queue the write queues
of all sockets associated to the net device are blocked as soon as they
get full. This causes problems with programs such as the zebra routing
daemon. So we have to keep the netif queue running in order to not block
any programs.
We also had a look at some other drivers and the common behaviour seems to
be that packets are lost if the network cable is pulled out.

Regards,
Thomas.

