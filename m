Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292650AbSCDSTq>; Mon, 4 Mar 2002 13:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292648AbSCDSTf>; Mon, 4 Mar 2002 13:19:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18952 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292650AbSCDST2>; Mon, 4 Mar 2002 13:19:28 -0500
Subject: Re: Gigabit Performance 2.4.19-preX - Excessive locks, calls, waits
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Mon, 4 Mar 2002 18:34:33 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020304104609.C31523@vger.timpanogas.org> from "Jeff V. Merkey" at Mar 04, 2002 10:46:09 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hxI9-00008m-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Thats up to the network adapter. In fact the Linux drivers mostly do 
> > keep preloaded with full sized buffers and only copy if the packet size
> > is small (and copying 1 or 2 cache lines isnt going to hurt anyone)
> 
> There's an increase in latency.  For my application, I have no 

A very tiny one (especially if you keep a small buffer pool around too).
To copy a packet is 2 cache line loads, which will dominate, some
writes that you wont be able to measure, and a writeback you won't be
able to instrument without a bus analyser.

For receive paths its up to the driver. The copy to smaller buffer is
something the driver can choose to do. It and it alone decide what skbuff
to throw at the kernel core

The bigger ring helping is interesting but itself begs a question. Do you
ever dirty rather than merely reference skbuff data. In that case a bigger
ring may simply be hiding the fact that the recycled skbuff has dirty
cached data that has to be written back. Does the combination of hardware
you have do the right thing when it comes to the invalidating  - and do
you ever DMA into a partial cache line ?

Alan
