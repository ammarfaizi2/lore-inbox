Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318129AbSGRPK0>; Thu, 18 Jul 2002 11:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318127AbSGRPJw>; Thu, 18 Jul 2002 11:09:52 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:12419 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id <S318122AbSGRPJd>; Thu, 18 Jul 2002 11:09:33 -0400
Message-ID: <180577A42806D61189D30008C7E632E87939A6@boca213a.boca.ssc.siemens.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: "'Maksim (Max) Krasnyanskiy'" <maxk@qualcomm.com>, kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: RE: Networking question
Date: Thu, 18 Jul 2002 11:11:31 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried both methods and they work. I would of course like to use the
most real-time efficient and "Kernel standard" methods. Looking into the
code code of netif_rx_ni seems to be logically the most correct way since it
will trigger do_softirq directly after the call to netif_rx.

Jack Bloch
Siemens Carrier Networks
e-mail    : jack.bloch@icn.siemens.com
phone     : (561) 923-6550


-----Original Message-----
From: Maksim (Max) Krasnyanskiy [mailto:maxk@qualcomm.com]
Sent: Wednesday, July 17, 2002 6:32 PM
To: kuznet@ms2.inr.ac.ru; Bloch, Jack
Cc: linux-kernel@vger.kernel.org
Subject: Re: Networking question



> > the priority of the softirq daemon or ensure that it is always awoken 
> when a
> > netif_rx is called?
>
>You should suppound it with local_bh_disable()/enable(), when using
>from process context.
Actually he should call netif_rx_ni() instead of netif_rx().
_ni stands for non-interrupt context.

Max
