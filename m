Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264702AbSLBOga>; Mon, 2 Dec 2002 09:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbSLBOga>; Mon, 2 Dec 2002 09:36:30 -0500
Received: from fmr02.intel.com ([192.55.52.25]:51670 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S264702AbSLBOg3>; Mon, 2 Dec 2002 09:36:29 -0500
Message-ID: <A5974D8E5F98D511BB910002A50A66470580D41F@hdsmsx103.hd.intel.com>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'Justin T. Gibbs'" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: AIC79xx driver question
Date: Mon, 2 Dec 2002 06:45:51 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin,

I was looking at the code for aic79xx, and it appears that the channel is
hard-coded to 'A' in a number of places, rather than using SCB_GET_CHANNEL()
(e.g.: calls to ahd_reset_channel in aic79xx_core.c).  Was this
intentional?  Is there only one channel per aic79xx host? 

Andy 

-----Original Message-----
[...]

Updated aic7xxx and aic79xx drivers for 2.4 and 2.5 can be found here:

http://people.FreeBSD.org/~gibbs/linux/tarballs

Notable changes:

o Both drivers support Domain Validation
o Memory mapped I/O is now a config option
o New memory mapped I/O register test that will hopefully
  weed out broken VIA chipsets
o The reboot notifier hook has been disabled.  The driver wants
  to shut itself down prior to reboot, but the reboot notifier is
  now called too early in 2.5.X for this to be effective.  It looks
  like it might be possible for the driver to grow a device shutdown
  routine, but it was not obvious with a quick look at this new feature
  how to ensure that the [sd, sr, etc.] driver's shutdown routines
  would be called prior to the aic7xxx driver's routine.  Some guidance
  in this area would be appreciated.
o Tag depth changes are now communicated to the midlayer.
 
--
Justin

