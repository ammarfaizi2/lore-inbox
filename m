Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268159AbUI2C2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268159AbUI2C2X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 22:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268164AbUI2C1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 22:27:08 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:10368 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268155AbUI2CZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 22:25:02 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE Hotswap
Date: Wed, 29 Sep 2004 03:54:38 +0200
User-Agent: KMail/1.6.2
Cc: Suresh Grandhi <Sureshg@ami.com>,
       "'linux-ide@vger.kernel.org'" <linux-ide@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <8CCBDD5583C50E4196F012E79439B45C069657DB@atl-ms1.megatrends.com> <200409282338.10456.bzolnier@elka.pw.edu.pl> <1096407955.14083.45.camel@localhost.localdomain>
In-Reply-To: <1096407955.14083.45.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200409290354.38440.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 September 2004 23:45, Alan Cox wrote:
> On Maw, 2004-09-28 at 22:38, Bartlomiej Zolnierkiewicz wrote:
> > No and such workaround won't work anyway because
> > re-register operation is nothing else but unregister+register.
> 
> If you grab the 2.6.8.1-ac patch you can do IDE controller hotplugging
> and a few other things but not yet drive hotplugging. 2.4 can do drive
> hotplug although you need a small -ac patch if you see wrong disk
> geometry data.
> 
> For new controllers (ie SATA ones) use Jeff Garzik's serial ATA layer as
> that is a lot cleaner and the SCSI layer already has a good basic
> understanding of hotplug management.
> 
> > Any help/support is appreciated.
> 
> Except for the dynamic stuff I consider the problem solved. Its up to
> you when and what you merge and I understand why you want to get stuff
> like sysfs there. 

Your patch is a nice start but it don't solve main issues, not to even
mention minor stuff like leaving /proc/ide/<chipset> around.

Merging it now is asking for problems.

> For drive level hotplug its actually a lot easier and I guess that is
> the case most users care about. The changes done for 2.6 clean up stuff

drive level hotplug is actually much harder
and it is _required_ for controller level hotplug, no? :)

> like suspend mean the nasties in 2.4 for sequencing have gone away. No
> refcounting needed since the block and fs layer are doing it all for

It helps but you still get bunch of races.  Refcounting is _really_ needed.

> you. TTY layer, revoke(), and some other current critical bonfires first
> before I can help with that however.

Fine.

Bartlomiej
