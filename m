Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262917AbUKYCNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbUKYCNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 21:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbUKYCMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 21:12:16 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:55671 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262914AbUKYCMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 21:12:05 -0500
To: Greg KH <greg@kroah.com>
Cc: Johannes Erdfelt <johannes@erdfelt.com>, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <20041122713.SDrx8l5Z4XR5FsjB@topspin.com>
	<20041122713.g6bh6aqdXIN4RJYR@topspin.com>
	<20041122222507.GB15634@kroah.com> <527jodbgqo.fsf@topspin.com>
	<20041123064120.GB22493@kroah.com> <52hdnh83jy.fsf@topspin.com>
	<20041123072944.GA22786@kroah.com>
	<20041123175246.GD4217@sventech.com>
	<20041123183813.GA31068@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 24 Nov 2004 11:23:37 -0800
In-Reply-To: <20041123183813.GA31068@kroah.com> (Greg KH's message of "Tue,
 23 Nov 2004 10:38:14 -0800")
Message-ID: <52u0rfyrt2.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [openib-general] Re: [PATCH][RFC/v1][4/12] Add InfiniBand SA
 (Subnet Administration) query support
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 24 Nov 2004 19:23:42.0649 (UTC) FILETIME=[1BFABA90:01C4D25B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> No.  RCU is covered by a patent that only allows for it to
    Greg> be implemented in GPL licensed code.  If you want to use RCU
    Greg> in non-GPL code, you need to sign a license agreement with
    Greg> the holder of the RCU patent.

Not to stir up the flames any further (and this is really a moot point
since I got rid of our use of RCU)...

But given that I could implement the same API as in rcupdate.h as
below without using IBM's patented technique, how does merely using
this API cause code to require a patent license?

Thanks,
 Roland

/*
 * Copyright (c) 2004 Topspin Communications.  All rights reserved.
 * 
 * Usage of the works is permitted provided that this instrument is
 * retained with the works, so that any entity that uses the works is
 * notified of this instrument.
 *
 * DISCLAIMER: THE WORKS ARE WITHOUT WARRANTY.
 */

#ifndef MYRCU_H
#define MYRCU_H

struct rcu_head { };

#define rcu_read_lock		lock_kernel()
#define rcu_read_unlock		unlock_kernel()

#define rcu_dereference(p)	(p)
#define rcu_assign_pointer(p,v)	do { \
	lock_kernel(); \
	(p) = (v); \
	unlock_kernel(); \
} while (0)

static inline void call_rcu(struct rcu_head *head,
			    void (*func)(struct rcu_head *head))
{
	lock_kernel();
	func(head);
	unlock_kernel();
}

#endif /* MYRCU_H */
