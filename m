Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276649AbRJBTsd>; Tue, 2 Oct 2001 15:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276653AbRJBTsY>; Tue, 2 Oct 2001 15:48:24 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:39165 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S276649AbRJBTsL>; Tue, 2 Oct 2001 15:48:11 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Tue, 2 Oct 2001 13:46:17 -0600
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: Ben Greear <greearb@candelatech.com>, Benjamin LaHaise <bcrl@redhat.com>,
        jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru, Ingo Molnar <mingo@elte.hu>, netdev@oss.sgi.com
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011002134617.J8954@turbolinux.com>
Mail-Followup-To: Robert Olsson <Robert.Olsson@data.slu.se>,
	Ben Greear <greearb@candelatech.com>,
	Benjamin LaHaise <bcrl@redhat.com>, jamal <hadi@cyberus.ca>,
	linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru,
	Ingo Molnar <mingo@elte.hu>, netdev@oss.sgi.com
In-Reply-To: <20011001210445.D15341@redhat.com> <Pine.GSO.4.30.0110012127410.28105-100000@shell.cyberus.ca> <20011002011351.A20025@redhat.com> <3BB956D3.AE0FCC54@candelatech.com> <15289.62283.695135.525478@robur.slu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15289.62283.695135.525478@robur.slu.se>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 02, 2001  19:03 +0200, Robert Olsson wrote:
> Jamal mentioned some about the polling efforts for Linux. I can give some
> experimental data here with GIGE. Motivation, implantation etc is in paper 
> to presented at USENIX Oakland. 

How do you determine the polling rate?  I take it that this is a different
patch than Ingo's?

> Iface   MTU Met  RX-OK RX-ERR RX-DRP RX-OVR  TX-OK TX-ERR TX-DRP TX-OVR Flags
> eth0   1500   0 4031309 7803725 7803725 5968699    22     0      0      0 BRU
> eth1   1500   0     18      0      0      0 4031305      0      0      0 BRU
> 
> The RX-ERR, RX-DRP are bugs from the e1000 driver. Anyway we getting 40% of 
> packet storm routed. With a estimated throughput is about 350.000 p/s 

Are you sure they are "bugs" and not dropped packets?  It seems to me that
RX-ERR == RX-DRP, which would seem to me that the receive buffers are full
on the card and are not being emptied quickly enough (or maybe that is
indicated by RX-OVR...)  I don't know whether it is _possible_ to empty
the buffers quickly enough, I suppose CPU usage info would also shed some
light on that.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

