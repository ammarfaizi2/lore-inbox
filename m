Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVAMPgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVAMPgP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 10:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVAMPdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 10:33:21 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:44886 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261657AbVAMPc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 10:32:28 -0500
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <20051121347.kR765yQEXhqhoLHL@topspin.com>
	<20051121347.vxtR3merv690zIQY@topspin.com>
	<20050113094532.GA31298@mellanox.co.il>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 13 Jan 2005 07:32:15 -0800
In-Reply-To: <20050113094532.GA31298@mellanox.co.il> (Michael S. Tsirkin's
 message of "Thu, 13 Jan 2005 11:45:32 +0200")
Message-ID: <52acrds5ts.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [openib-general] [PATCH][5/18] InfiniBand/mthca: add needed
 rmb() in event queue poll
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 13 Jan 2005 15:32:21.0054 (UTC) FILETIME=[128EEDE0:01C4F985]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Michael> Since we are using the eqe here, it seems that
    Michael> read_barrier_depends shall be sufficient (as well as in
    Michael> the cq case)?

    Michael> However, I see that read_barrier_depends is a nop on ppc,
    Michael> and the comment indicates that problems were seen on ppc
    Michael> 970.  What gives? do I misunderstand what a dependency
    Michael> is?

There is no dependency between the EQE ownership field and the rest of
the EQE, so read_barrier_depends() is not sufficient.  I think you are
misunderstanding what a dependency is.  The comments in
asm-i386/system.h or http://lse.sourceforge.net/locking/wmbdd.html may
help clear things up.

 - R.
