Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbTKCVzo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 16:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263456AbTKCVzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 16:55:44 -0500
Received: from palrel12.hp.com ([156.153.255.237]:54493 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263454AbTKCVzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 16:55:33 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16294.52938.599699.302478@napali.hpl.hp.com>
Date: Mon, 3 Nov 2003 13:55:22 -0800
To: "Noah J. Misch" <noah@caltech.edu>
Cc: Matthew Wilcox <willy@debian.org>, linux-ia64@linuxia64.org,
       linux-kernel@vger.kernel.org
Subject: Re: IA64/simulators - Kconfig logic for drivers/*
In-Reply-To: <Pine.GSO.4.58.0311012038250.20298@sue>
References: <Pine.GSO.4.58.0310251706470.15711@inky>
	<20031102031644.GB3824@parcelfarce.linux.theplanet.co.uk>
	<Pine.GSO.4.58.0311011945190.18996@sue>
	<20031102043402.GF3824@parcelfarce.linux.theplanet.co.uk>
	<Pine.GSO.4.58.0311012038250.20298@sue>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 1 Nov 2003 22:41:07 -0800 (PST), "Noah J. Misch" <noah@caltech.edu> said:

  Noah> On Sun, 2 Nov 2003, Matthew Wilcox wrote:
  >> > Why not include drivers/Kconfig and scrap the individual subdirectory
  >> > includes, as i386 does?

  >> At that time, I hadn't done the work to create drivers/Kconfig ;-)
  >> The main problem for ia64 is the simulator stuff.  Maybe something like:

  >> if !IA64_HP_SIM
  >> source "drivers/Kconfig"
  >> endif

  >> if IA64_HP_SIM
  >> source "drivers/base/Kconfig"
  >> source "drivers/scsi/Kconfig"
  >> source "net/Kconfig"
  >> source "drivers/block/Kconfig"
  >> source "arch/ia64/hp/sim/Kconfig"
  >> endif

  Noah> I would guess that everyone who uses a simulator is a kernel
  Noah> developer or maybe an application developer.  I worry that the
  Noah> risk of hiding useful configs from simulator users by lax
  Noah> maintenance of that block of Kconfig logic exceeds the risk of
  Noah> those people trying to build a simulator kernel with all kinds
  Noah> of hardware drivers and finding that it doesn't work.  A
  Noah> quieter configuration is nice, however.  Hmmm.

I suspect it should be possible to do this much cleaner with the new
Kconfig system.  For example, if all PCI-dependent drivers really do
specify "depends on PCI" (or something equivalent), then a good
portion of the hopeless drivers would automagically go away from the
simulator configuration.  What's there now "works", but it clearly
could stand some modernization.

	--david
