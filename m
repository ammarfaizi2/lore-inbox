Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161315AbWGNW3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161315AbWGNW3T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 18:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161316AbWGNW3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 18:29:19 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:45539 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1161315AbWGNW3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 18:29:19 -0400
Subject: Re: 2.6.17-rc6-mm1/pktcdvd - BUG: possible circular locking
From: Arjan van de Ven <arjan@linux.intel.com>
To: Peter Osterlund <petero2@telia.com>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>, axboe@suse.de
In-Reply-To: <m3odvrc2vo.fsf@telia.com>
References: <448875D1.5080905@free.fr> <448D84C0.1070400@linux.intel.com>
	 <m3sllxtfbf.fsf@telia.com> <1151000451.3120.56.camel@laptopd505.fenrus.org>
	 <m3u05kqvla.fsf@telia.com> <1152884770.3159.37.camel@laptopd505.fenrus.org>
	 <m3odvrc2vo.fsf@telia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 15 Jul 2006 00:29:13 +0200
Message-Id: <1152916153.3159.51.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> In the first call chain, do_open -> pkt_open, the bd_mutex object that
> is being locked corresponds to a pktcdvd block device, because those
> are the only devices that have their open method set to pkt_open.
> 
> In the second call chain, pkt_ctl_ioctl -> pkt_new_dev -> do_open, the
> bd_mutex object that is being locked *does not* correspond to a
> pktcdvd block device, because pkt_new_dev will bail out with a "Can't
> chain pktcdvd devices" error if you call it with "dev" set to a
> pktcdvd device.
> 
> Therefore, there is no AB-BA deadlock possibility. The locking
> dependencies are A -> B and B -> A', where it is known that A, B and
> A' are all different.
> 
> So the claim from the lockdep code, "BUG: possible circular locking
> deadlock detected!", is a false alarm.

ok I'll try to find a annotation for that that works
