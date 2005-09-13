Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbVIMWM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbVIMWM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 18:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbVIMWM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 18:12:56 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:14807 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932504AbVIMWMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 18:12:55 -0400
Subject: Re: SCSI issue with 2.6.14-rc1
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: Burton Windle <bwindle@fint.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <17191.19125.826388.938552@wombat.chubb.wattle.id.au>
References: <Pine.LNX.4.63.0509131202170.1684@postal>
	 <17191.19125.826388.938552@wombat.chubb.wattle.id.au>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 17:12:31 -0500
Message-Id: <1126649551.4809.70.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 07:55 +1000, Peter Chubb wrote:
> Burton> Dell Poweredge 1300, MegaRAID SCSI with hardware RAID1. With
> Burton> 2.6.13, system was fine, but on 2.6.14-rc1, it sees the RAID
> Burton> array as a 0mb drive with 1 512-byte sector, and seems to have
> Burton> a bit of a problem mounting /
> 
> This sounds like the same problem I saw with the IA64 simscsi driver
> --- the READ_CAPACITY scsi command now generates a scatterlist, and
> some drivers don't cope.
> 
> I don't know whether the right fix is to change all the drivers to
> understand a scatterlist, or to change sd_read_capacity() to not use 
> scsi_execute_command().

There's a fix for the megaraid issue floating around on this list.

The correct solution is for all drivers to understand scatterlists.
This is actually true of most of them; there are just a few scsi
emulators that didn't for certain commands.  These emulators are already
broken, since if these commands came via SG_IO, they'd be scatterlist
based, so the correct fix is in the emulators.

James


