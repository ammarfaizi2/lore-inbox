Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbVJ0Qsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVJ0Qsw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 12:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVJ0Qsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 12:48:52 -0400
Received: from pat.qlogic.com ([198.70.193.2]:49883 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S1751268AbVJ0Qsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 12:48:51 -0400
Date: Thu, 27 Oct 2005 09:48:50 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: Linux-SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc5-mm1
Message-ID: <20051027164850.GJ7889@plap.qlogic.org>
References: <20051024014838.0dd491bb.akpm@osdl.org> <1130186927.6831.23.camel@localhost.localdomain> <20051024141646.6265c0da.akpm@osdl.org> <20051027152637.GC7889@plap.qlogic.org> <1130427867.23729.73.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130427867.23729.73.camel@localhost.localdomain>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 27 Oct 2005 16:48:50.0916 (UTC) FILETIME=[4EE28A40:01C5DB16]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2005, Badari Pulavarty wrote:
> On Thu, 2005-10-27 at 08:26 -0700, Andrew Vasquez wrote:
> > qlogicfc attaches to both 2100 and 2200 ISPs.  It seems you're then
> > trying to load qla2xxx driver along with the 2300 and 2200 firmware
> > loader modules.  The pci_request_regions() call during 2200 probing
> > fails.
> 
> Hmm. This is happening because I have both qlogicfc and qla2200 as
> modules ?

Yes.  You don't need (unless there is a compeling reason) to compile
qlogicfc (CONFIG_SCSI_QLOGIC_FC) as the qla2xxx driver along with the
2200 and 2300 firmware mofules:

	CONFIG_SCSI_QLA2XXX=m
	CONFIG_SCSI_QLA22XX=m
	CONFIG_SCSI_QLA2300=m

will be fine.

> > Badari, is there some reason you are using qlogicfc?  THe qla2xxx
> > driver supports all QLogic ISP parts.
> 
> Not intentionally. I have qla2200, qla2300 cards in my machine.
> I build all the qlogic drivers as modules.

Could you send me your .config file?  I have a fealing you have and
entry similar to the following:

	CONFIG_SCSI_QLOGIC_FC=m

in there.  Don't compile the qlogicfc driver.

> I hate to admit it - but I do use modules for qlogic disks.

Thats fine.

> I can't seem to compile the qlogic drivers (2200, 2300) into the
> kernel and boot without problems (consistently on all my machines 
> - I run into few issues):
> 
> (1) Between kernels, sometimes probing order changes and my local
> disks get probed last and screws up my boot process - I don't
> think this is a qlogic problem.

Not sure there, but the removal of the qlogicfc driver could help
clear up some of the noise, like...

> (2) Sometimes, one of the driver complains something like 
> "PCI region already in use" and hangs on boot.

this.  the qlogicfc driver is being loaded before qla2xxx and the
supporting 2200 firmware module.

> BTW, (2) happens even if its modules and I can't boot my
> machine. Sometimes I had to boot with old kernel and hide
> the modules - so boot process can't find them to workaround
> the problem.
> 
> Is there a "dont-load-modules" option or don't load a specific
> module option on boot ?

--
Andrew Vasquez
