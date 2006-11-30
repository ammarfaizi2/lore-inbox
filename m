Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031283AbWK3Tob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031283AbWK3Tob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 14:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031284AbWK3Tob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 14:44:31 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:1015 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1031283AbWK3Toa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 14:44:30 -0500
Message-ID: <456F34BE.5050303@cfl.rr.com>
Date: Thu, 30 Nov 2006 14:45:02 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Matt Garman <matthew.garman@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: What happened to CONFIG_TCP_NAGLE_OFF?
References: <bdd6985b0611281405j3e731e3xc7973c0365428663@mail.gmail.com>  <456DE85F.50806@cfl.rr.com> <bdd6985b0611300921u1a88f410vdaf9051c220719e1@mail.gmail.com>
In-Reply-To: <bdd6985b0611300921u1a88f410vdaf9051c220719e1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Nov 2006 19:45:27.0617 (UTC) FILETIME=[15D50B10:01C714B8]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14844.003
X-TM-AS-Result: No--16.830700-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Garman wrote:
> I don't want to change the API at all.  I'm using a closed-source, 3rd
> party library.  Using strace, I can see that the library does *not* do
> a setsockopt(...TCP_NODELAY...) on opened sockets.  Since I can't
> change the library, I would like to patch and/or configure my kernel
> so that all TCP/IP sockets default to TCP_NODELAY.

That _IS_ changing the api.  Applications that wish to use nagle will no 
longer be able to because you will have changed the api to always 
disable nagle.

> Also, if my understanding of Nagle is correct, I think you have that
> backwards: Nagle should be disabled (i.e. TCP_NODELAY) for telnet,
> mouse movements, etc: we always want to send our packets, regardless
> of size or previous packet ACK.

No, nagle was invented specifically for telnet.  Without nagle, every 
character you type is sent in its own packet, which gives around 50,000% 
overhead.  Nagle was created to compact most of your keystrokes into a 
single packet.

Things like mouse movements should not be sent over TCP at all.  UDP 
makes a much better protocol for that kind of data since if a packet is 
lost, there is no need to retransmit the same data; instead you just get 
the next position update and don't care about where the mouse was during 
the dropped packet.


