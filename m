Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271774AbTGRMgK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 08:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271777AbTGRMgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 08:36:10 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:28102 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271774AbTGRMfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 08:35:40 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Fri, 18 Jul 2003 14:50:33 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: mason@suse.com, andrea@suse.de, riel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
Message-Id: <20030718145033.5ff05880.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.55L.0307180921120.6642@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307150859130.5146@freak.distro.conectiva>
	<1058297936.4016.86.camel@tiny.suse.com>
	<Pine.LNX.4.55L.0307160836270.30825@freak.distro.conectiva>
	<20030718112758.1da7ab03.skraw@ithnet.com>
	<Pine.LNX.4.55L.0307180921120.6642@freak.distro.conectiva>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003 09:23:10 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> 
> CCed lkml for obvious reasons
> 
> On Fri, 18 Jul 2003, Stephan von Krawczynski wrote:
> 
> > On Wed, 16 Jul 2003 08:37:51 -0300 (BRT)
> > Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> >
> > >
> > > Stephan, can you reproduce it easily?
> >
> > Hello,
> >
> > there is definitely something about it. pre6 froze after 2 days of
> > testing. I guess I was unlucky this time with logfiles, no messages
> > there.  There is something severe. You may call it reproducable, but not
> > easy.
> 
> Stephan,
> 
> What is your workload?
> 
> I'll try to reproduce it.

You need heavy NFS action and I/O load. Its the same box I use for
server-scenario tests. 3 GB RAM, SMP, 320 GB RAID5 (3ware), SDLT tape drive, 2
x 1000 TX. In detail:

00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
00:04.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon
7500]
00:05.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:05.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
00:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 05)
00:0f.3 Host bridge: ServerWorks GCLE Host Bridge
01:02.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
01:03.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH
Fritz!PCI v2.0 ISDN (rev 01)
01:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit
Ethernet (rev 15)
02:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit
Ethernet (rev 15)
02:03.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
02:03.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)

Take several NFS clients and write to this box some GBs (all at same time),
then copy these files around on the box or tar them. You should see collapses
like from the BUG I posted lately up to complete freeze.
I have continuous cpu load above 2.0 upto about 8.0

Regards,
Stephan

