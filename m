Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267746AbTBGJBd>; Fri, 7 Feb 2003 04:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267747AbTBGJBd>; Fri, 7 Feb 2003 04:01:33 -0500
Received: from mail.ithnet.com ([217.64.64.8]:41738 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S267746AbTBGJBc>;
	Fri, 7 Feb 2003 04:01:32 -0500
Date: Fri, 7 Feb 2003 10:10:52 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: rossb@google.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
Message-Id: <20030207101052.538ac3c5.skraw@ithnet.com>
In-Reply-To: <1044572658.6330.51.camel@zion.wanadoo.fr>
References: <20030202161837.010bed14.skraw@ithnet.com>
	<3E3D4C08.2030300@pobox.com>
	<20030202185205.261a45ce.skraw@ithnet.com>
	<3E3D6367.9090907@pobox.com>
	<20030205104845.17a0553c.skraw@ithnet.com>
	<1044443761.685.44.camel@zion.wanadoo.fr>
	<3E414243.4090303@google.com>
	<1044465151.685.149.camel@zion.wanadoo.fr>
	<20030206132043.1896a1c2.skraw@ithnet.com>
	<1044572658.6330.51.camel@zion.wanadoo.fr>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Feb 2003 00:04:18 +0100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2003-02-06 at 13:20, Stephan von Krawczynski wrote:
> > On 05 Feb 2003 18:12:31 +0100
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > 
> > > Stephan: Can you try editing ide-dma.c, function
> > > __ide_dma_test_irq(), and remove that line:
> > > 
> > > -	drive->waiting_for_dma++;
> > > 
> > > And tell us if it helps in any way.
> > > 
> > > Ben.
> > 
> > Hello Ben,
> > 
> > as requested I tried the above "patch" and had no problem so far. Current
> > situation is:
> > (ide2, ide3 are PDC, eth2 is tg3)
> 
> Ok, well, if it' still stable by now, I beleive we can safely remove
> that line from ide_dma_test_irq(). AFAIK, it really have nothing to do
> here.

Hello all,

it is still working ok, currently we are at:

           CPU0       
  0:   13848205          XT-PIC  timer
  1:      54117          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  EMU10K1
  7:      27260          XT-PIC  HiSax
  9:   67048861          XT-PIC  ide2, ide3, aic7xxx, aic7xxx, eth0, eth1, eth2
 12:     765541          XT-PIC  PS/2 Mouse
 15:        229          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

Regards,
Stephan


