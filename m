Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264281AbTDPKAV (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 06:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264282AbTDPKAV 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 06:00:21 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:29321
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S264281AbTDPKAS 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 06:00:18 -0400
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DMA transfers in 2.5.67
References: <yw1x3ckjfs2v.fsf@zaphod.guide>
	<1050438684.28586.8.camel@dhcp22.swansea.linux.org.uk>
	<yw1xy92be915.fsf@zaphod.guide>
	<1050439715.28586.17.camel@dhcp22.swansea.linux.org.uk>
	<yw1xptnne7lv.fsf@zaphod.guide>
	<20030416123654.A2629@jurassic.park.msu.ru>
	<yw1xk7duessc.fsf@zaphod.guide> <yw1xadeqes1s.fsf@zaphod.guide>
	<yw1x65peeqm4.fsf@zaphod.guide>
	<20030416140110.A642@jurassic.park.msu.ru>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 16 Apr 2003 12:11:02 +0200
In-Reply-To: <20030416140110.A642@jurassic.park.msu.ru>
Message-ID: <yw1x1y02eoqx.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky <ink@jurassic.park.msu.ru> writes:

> > I set the latency to 128 using setpci and now I get 66 MB/s.  Other
> > values give slower transfer rates.  Is there some other setting that
> > could improve it even more?
> 
> Interesting. Did you set latency 128 for all devices or only for
> 3Dlabs card?

Only the 3Dlabs.  The remaining cards are configured like this:

00:05.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Flags: bus master, medium devsel, latency 64, IRQ 25

00:06.0 Display controller: 3DLabs GLINT R3 (rev 01)
	Subsystem: 3DLabs: Unknown device 0121
	Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 27

00:07.0 RAID bus controller: Triones Technologies, Inc.: Unknown device 0008 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 26

00:07.1 RAID bus controller: Triones Technologies, Inc.: Unknown device 0008 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 26

00:08.1 IDE interface: Contaq Microsystems 82c693 (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 0

00:08.2 IDE interface: Contaq Microsystems 82c693 (prog-if 00 [])
	Flags: bus master, medium devsel, latency 0

00:08.3 USB Controller: Contaq Microsystems 82c693 (prog-if 10 [OHCI])
	Flags: bus master, medium devsel, latency 0

00:09.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Adaptec: Unknown device 0035
	Flags: bus master, medium devsel, latency 64, IRQ 24

00:09.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Adaptec: Unknown device 0035
	Flags: bus master, medium devsel, latency 64, IRQ 28

00:09.2 USB Controller: NEC Corporation: Unknown device 00e0 (rev 02) (prog-if 20)
	Subsystem: Adaptec: Unknown device 00e0
	Flags: bus master, medium devsel, latency 68, IRQ 32

As you can see, the good IDE controller (Triones/Highpoint hpt374) has
a latency of 120.  Disk transfer rates are still only half of what I
get with a 2.4 kernel.  What could be the cause of this?


-- 
Måns Rullgård
mru@users.sf.net
