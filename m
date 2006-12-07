Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162629AbWLGSIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162629AbWLGSIj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 13:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163135AbWLGSIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 13:08:39 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:2770 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162629AbWLGSIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 13:08:37 -0500
Date: Thu, 7 Dec 2006 18:08:33 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Jeff Garzik <jeff@garzik.org>, Andy Fleming <afleming@freescale.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       David Howells <dhowells@redhat.com>, rdreier@cisco.com,
       ben.collins@ubuntu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export current_is_keventd() for libphy
In-Reply-To: <457849E2.3080909@garzik.org>
Message-ID: <Pine.LNX.4.64N.0612071754500.22220@blysk.ds.pg.gda.pl>
References: <20061206234942.79d6db01.akpm@osdl.org> <1165125055.5320.14.camel@gullible>
 <20061203011625.60268114.akpm@osdl.org> <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
 <20061205123958.497a7bd6.akpm@osdl.org> <6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
 <20061205132643.d16db23b.akpm@osdl.org> <adaac22c9cu.fsf@cisco.com>
 <20061205135753.9c3844f8.akpm@osdl.org> <Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
 <20061206075729.b2b6aa52.akpm@osdl.org> <Pine.LNX.4.64.0612060822260.3542@woody.osdl.org>
 <Pine.LNX.4.64.0612061719420.3542@woody.osdl.org> <20061206224207.8a8335ee.akpm@osdl.org>
 <9392.1165487379@redhat.com> <20061207024211.be739a4a.akpm@osdl.org>
 <457849E2.3080909@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006, Jeff Garzik wrote:

> Looking into libphy's workqueue stuff, it has the following sequence:
> 
> 	disable interrupts
> 	schedule_work()
> 
> 	... time passes ...
> 	... workqueue routine is called ...
> 
> 	enable interrupts
> 	handle interrupt
> 
> I really have to question if a workqueue was the best choice of direction for
> such a sequence.  You don't want to put off handling an interrupt, with
> interrupts disabled, for a potentially unbounded amount of time.

 This is because to ack the interrupt in the device the MDIO bus has to be 
accessed and I gather for some implementations it may be too obnoxiously 
slow for the interrupt context to cope with.  Note that only the interrupt 
line used for the PHY is disabled (though obviously with consequences to 
any sharers).

 Andy, could you please comment?

  Maciej
