Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276384AbRJPQPL>; Tue, 16 Oct 2001 12:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbRJPQPC>; Tue, 16 Oct 2001 12:15:02 -0400
Received: from inway98.cdi.cz ([213.151.81.98]:31728 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S276384AbRJPQOz>;
	Tue, 16 Oct 2001 12:14:55 -0400
Posted-Date: Tue, 16 Oct 2001 18:15:22 +0200
Date: Tue, 16 Oct 2001 18:15:22 +0200 (CEST)
From: Martin Devera <devik@cdi.cz>
To: Francois Romieu <romieu@cogenit.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: sendto syscall is slow
In-Reply-To: <20011016175908.A2258@se1.cogenit.fr>
Message-ID: <Pine.LNX.4.10.10110161803270.13894-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you have the same profile for sendto when Rx/Tx isn't short 
> connected ?

I have not. I have only one computer and one 100Mbit eth card
at home. But I've got the same results when I used loopback
driver.
But without loopback wires it goes like this:
 41.03      4.34     4.34   478200     0.01     0.01  sendto
 29.52      7.46     3.12   481389     0.01     0.01  poll
 14.70      9.02     1.55   478200     0.00     0.00  setsockopt

> You may consider polling for Tx/Rx completion in the Tx path at the
> driver level. If your cpu isn't too much powered it will make
> a difference.

Are you speaking about rewriting nic driver ? Like try to drain
waiting packet from nic's memory while enqueuing new one ?

IMHO the bottleneck will be probably in send syscall (probably
syscall overhead).
I'm thinking about hack which will allow me to send() large
buffer and kernel code will break it into smaller ones and
device_queue_xmit them at once.

devik

