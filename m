Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTFJRbV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 13:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbTFJRbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 13:31:21 -0400
Received: from mail.ithnet.com ([217.64.64.8]:10244 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263738AbTFJRbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 13:31:17 -0400
Date: Tue, 10 Jun 2003 19:44:29 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org, willy@w.ods.org, gibbs@scsiguy.com,
       marcelo@conectiva.com.br, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030610194429.615c0e93.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.50.0306100949040.19137-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030605181423.GA17277@alpha.home.local>
	<20030608131901.7cadf9ea.skraw@ithnet.com>
	<20030608134901.363ebe42.skraw@ithnet.com>
	<20030609171011.7f940545.skraw@ithnet.com>
	<Pine.LNX.4.50.0306092135000.19137-100000@montezuma.mastecende.com>
	<20030610123015.4242716e.skraw@ithnet.com>
	<Pine.LNX.4.50.0306100847580.19137-100000@montezuma.mastecende.com>
	<20030610153815.57f7a563.skraw@ithnet.com>
	<Pine.LNX.4.50.0306100949040.19137-100000@montezuma.mastecende.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jun 2003 09:51:34 -0400 (EDT)
Zwane Mwaikambo <zwane@linuxpower.ca> wrote:

> > Reading around the whole interrupt stuff I came across a very simple idea
> > which I am going to test right now. See you in some hours ;-)

I now tried rc7+aic20030603 SMP apic _but_ interrupts from aic only bound to
single cpu. I did this with help of irqbalance from Arjan.

/proc/interrupts:

           CPU0       CPU1       
  0:       5148     571297    IO-APIC-edge  timer
  1:       9733         97    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
 12:      43720       1271    IO-APIC-edge  PS/2 Mouse
 15:          4          4    IO-APIC-edge  ide1
 17:       1297    1336383   IO-APIC-level  3ware Storage Controller
 18:        344      16447   IO-APIC-level  eth0, eth1
 20:        570          3   IO-APIC-level  fcpcipnp
 21:      57292        340   IO-APIC-level  eth2
 22:     443161       2776   IO-APIC-level  aic7xxx
 23:         31    2005037   IO-APIC-level  aic7xxx
 26:          0          0   IO-APIC-level  EMU10K1
NMI:     593524     582633 
LOC:     576356     576330 
ERR:          0
MIS:          0

The controller used is the second aic7xxx. The 31 interrupts on CPU0 have
occured before the test. This setup fails during verify (data corruption).

I would say that the interrupt code of the aic in itself is therefore ok with
SMP. If it were a SMP race condition inside the interrupt routine this test
should have been ok (as only one CPU is used).

Regards,
Stephan




