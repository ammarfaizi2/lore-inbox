Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265019AbSLLTK7>; Thu, 12 Dec 2002 14:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbSLLTK7>; Thu, 12 Dec 2002 14:10:59 -0500
Received: from host136-27.pool217141.interbusiness.it ([217.141.27.136]:14606
	"EHLO mdvsrvsmtp01.north.h3g.it") by vger.kernel.org with ESMTP
	id <S264877AbSLLTK5> convert rfc822-to-8bit; Thu, 12 Dec 2002 14:10:57 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Kernel bug handling TCP_RTO_MAX?
Date: Thu, 12 Dec 2002 20:15:42 +0100
Message-ID: <047ACC5B9A00D741927A4A32E7D01B73D66176@RMEXC01.h3g.it>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel bug handling TCP_RTO_MAX?
thread-index: AcKiEsQqYuHs0uDZQieYDM6iK+0WiQ==
From: "Andreani Stefano" <stefano.andreani.ap@h3g.it>
To: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
X-OriginalArrivalTime: 12 Dec 2002 19:15:42.0468 (UTC) FILETIME=[DD3D2C40:01C2A212]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem: I need to change the max value of the TCP retransmission timeout. 

Background: According to Karn's exponential backoff algorithm, when the receiver doesn't acknowledge packets for a while, the sender should retransmit the latest not acknowledged packet several times increasing the delay (RTO) since this delay reaches the Max Retransmission Timeout Value. 

Testing environment: Red Hat Linux release 7.2 (Enigma), Kernel 2.4.7-10 on an i686, Kernel 2.4.7-10.

Test details: I supposed this timeout in Linux was TCP_RTO_MAX, so I changed in /include/net/tcp.h the following line:

#define TCP_RTO_MAX	((unsigned)(6*HZ)) //It was: ((unsigned)(120*HZ))

Then I recompiled the kernel, rebooted the machine and tested the solution. The result I obtained was the same I had before this modification. 

I'm confident there isn't an error in the testing procedure because I already tested with a Solaris server the same procedure (changing the tcp_rexmit_interval_max variable) and it works. I'm just trying to reproduce the modification of that parameter in Linux. 

Could it be a bug on the RTO calculation algorithm, or there is something I mistook?

This is the first time I get into the linux kernel, so please be patient!

Thanks,

Stefano.

-------------------------------
        Stefano Andreani
    Freelance ICT Consultant
      H3G IOT Team - Italy
      tel. +39 347 8215965
   stefano.andreani.ap@h3g.it

