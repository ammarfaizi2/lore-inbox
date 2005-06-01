Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVFAISj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVFAISj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 04:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVFAISh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 04:18:37 -0400
Received: from odin2.bull.net ([192.90.70.84]:52438 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261249AbVFAISY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 04:18:24 -0400
Subject: Re: RT : 2.6.12rc5 + realtime-preempt-2.6.12-rc5-V0.7.47-15
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1117568825.23283.5.camel@mindpipe>
References: <1117551231.19367.48.camel@ibiza.btsn.frna.bull.fr>
	 <1117568825.23283.5.camel@mindpipe>
Content-Type: text/plain; charset=iso-8859-15
Organization: BTS
Message-Id: <1117613246.5580.70.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Wed, 01 Jun 2005 10:07:27 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar 31/05/2005 à 21:47, Lee Revell a écrit :
> On Tue, 2005-05-31 at 16:53 +0200, Serge Noiraud wrote:
> > I have a test program which made a loop in RT to mesure the system
> > perturbation.
> > It works finely in a tty environment.
> > When I run it in an X environment ( xterm ), I get something like if I
> > click the Enter key in the active window.
> > If I open a new xterm, this is the new active window which receive these
> > events.
> > These events stop when the program stop.
> > 
> > I tried with X in RT and no RT : I have the problem.
> 
> Try adding:
> 
> Option "NoAccel"
Same problem.
I have this problem with two graphic card on three different machines :
On the fisrt one  ( IBM Intellistation Mpro ) :
#lspci
...
01:00.0 VGA compatible controller: nVidia Corporation NV28GL [Quadro4
980 XGL] (rev a1)
...
#lshw
...
        *-pci:0
             description: PCI bridge (Normal decode)
             product: 82875P Processor to AGP Controller
             vendor: Intel Corp.
             physical id: 1
             bus info: pci@00:01.0
             version: 02
             clock: 66MHz
             capabilities: pci normal_decode bus_master
           *-display UNCLAIMED
                description: VGA compatible controller (VGA)
                product: NV28GL [Quadro4 980 XGL]
                vendor: nVidia Corporation
                physical id: 0
                bus info: pci@01:00.0
                version: a1
                size: 128MB
                clock: 66MHz
                capabilities: vga bus_master cap_list
                resources: iomemory:f8000000-f8ffffff
iomemory:f0000000-f7ffffff irq:145
...

On the second machine ( IBM Intellistation Zpro ) :
#lspci
01:00.0 VGA compatible controller: nVidia Corporation NV28GL [Quadro4
980 XGL] (rev a1)
#lshw
        *-pci:0
             description: PCI bridge (Normal decode)
             product: E7505/E7205 PCI-to-AGP Bridge
             vendor: Intel Corp.
             physical id: 1
             bus info: pci@00:01.0
             version: 03
             clock: 66MHz
             capabilities: pci normal_decode bus_master cap_list
             resources: iomemory:f0000000-f3ffffff
           *-display
                description: VGA compatible controller (VGA)
                product: NV28GL [Quadro4 980 XGL]
                vendor: nVidia Corporation
                physical id: 0
                bus info: pci@01:00.0
                version: a1
                size: 128MB
                clock: 66MHz
                capabilities: vga bus_master cap_list
                configuration: driver=nvidia
                resources: iomemory:f8000000-f8ffffff
iomemory:e8000000-efffffff irq:201
...

On the third machine ( Force Computers - 2 ways ):
#lspci
...
00:05.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
...
#lshw
...
     *-pci:0
          description: Host bridge
          product: CMIC-WS Host Bridge (GC-LE chipset)
          vendor: ServerWorks
          physical id: 100
          bus info: pci@00:00.0
          version: 13
          clock: 33MHz
        *-display UNCLAIMED
             description: VGA compatible controller (VGA)
             product: Rage XL
             vendor: ATI Technologies Inc
             physical id: 5
             bus info: pci@00:05.0
             version: 27
             size: 16MB
             clock: 33MHz
             capabilities: vga bus_master cap_list
             resources: iomemory:fb000000-fbffffff ioport:1000-10ff
iomemory:fc000000-fc000fff irq:9
...
> 
> to the Driver section of your X config.
> 
> Some buggy video drivers can stall the PCI bus for tens or hundreds of
> *milliseconds*.  The "via" driver had this problem until I identified
> the problem and the Unichrome guys fixed it.  If it goes away with
> "NoAccel", then you are having the same problem.
> 
> For details search the unichrome-devel archives for "losing interrupts".
I'll look at this :
Dragging window in X causes soundcard interrupts to be lost

They play with the mouse.
In my case, I do nothing. I launch the test then wait. I have <Enter
Key> events in my active window when I look at it the hand in the back!

> 
> Lee

