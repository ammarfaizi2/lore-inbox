Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281330AbRKTUPQ>; Tue, 20 Nov 2001 15:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281332AbRKTUPI>; Tue, 20 Nov 2001 15:15:08 -0500
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:61448
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S281330AbRKTUOx>; Tue, 20 Nov 2001 15:14:53 -0500
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200111201951.fAKJp1d08155@www.hockin.org>
Subject: Re: A return to PCI ordering problems...
To: root@chaos.analogic.com
Date: Tue, 20 Nov 2001 11:51:01 -0800 (PST)
Cc: amon@vnl.com (Dale Amon), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1011120144925.14138A-100000@chaos.analogic.com> from "Richard B. Johnson" at Nov 20, 2001 03:03:23 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	NIC on motherboard, Realtek
> > 	NIC on PCI card, Realtek
> > 	Motherboard must be set to eth0
> > The PCI search order always makes the PCI card 
> > eth0.

I'd say your motherboard was broken for setting up the device select lines
that way.  Slots should always be higher than on-boards, IMHO.

In this case, linux is correct. A different example :

onboard natsemi
slotted eepro100

Both eepro100 and natsemi compiled monolithic.  I'd want the probe routine
to find the first device first.  That is, recognize that natsemi has the
lower PCI id, and run the natsemi probe first.  Last I looked, linux just
inits them in the order the _probe() routines are called.

