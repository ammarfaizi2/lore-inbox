Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbTFJUSt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbTFJUPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:15:50 -0400
Received: from [212.18.235.100] ([212.18.235.100]:42512 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S262318AbTFJUPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 16:15:23 -0400
Subject: Re: siI3112 crash on enabling dma
From: Justin Cormack <justin@street-vision.com>
To: apeeters@lashout.net
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1055261120.28365.40.camel@localhost>
References: <1054929160.1793.121.camel@localhost> 
	<1055261120.28365.40.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 10 Jun 2003 21:29:10 +0100
Message-Id: <1055276951.2046.5.camel@lotte>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 17:05, Adriaan Peeters wrote:
> On Fri, 2003-06-06 at 21:52, Adriaan Peeters wrote:
> > Hello,
> > 
> > I'm using 2.4.20-ac2, when I boot the system, SATA disks on a sil3112
> > controller (IWill IS150-R) are detected, but dma is not enabled.
> > The disks work perfectly in raid 1 mode, and I can enable dma using 
> > hdparm -X66 -d1 /dev/hda
> > hdparm -X66 -d1 /dev/hdc
> > 
> > But sometimes this fails and the entire system hangs. I suspect it
> > happens when I enable dma mode while there is some harddisk activity.
> 
> The system seemed to be stable for a few days, but then the following
> happened:
> - First I got read-only filesystem messages
> - a few seconds later I/O errors
> - After rebooting, the root filesystem (ext3) could not be mounted
> - After fscking and a lot of deleted inodes, large portions of the
> filesystem were gone to lost+found (/etc, /bin, ...)
> 
> I can only relate this to the driver, it seems very unstable :(
> 
> Some info: 2.4.20-ac2, asus a7v8x motherboard (onboard promise raid not
> used), iwill IS150-R raid controler, 2 Maxtor 6Y080M0 SATA disks in
> raid1.

I got severe filesystem corruption on an Sii3112 system (Supermicro
E7505 with 2 onboard SiI3112) but I later memtested the machine and
found bad ram, so I dont think it is a valid example of corruption.
However I am still slightly suspicious. Did you have 
echo "max_kb_per_request:15" > /proc/ide/hdXX/settings
set for the relevant drives? This is a known bug (I didnt have this
either, another reason why this is not a valid datapoint...)


Justin


