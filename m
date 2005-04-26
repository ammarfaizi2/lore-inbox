Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVDZPvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVDZPvM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVDZPuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:50:23 -0400
Received: from webmail.houseafrika.com ([12.162.17.52]:49429 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S261625AbVDZPtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:49:19 -0400
To: Libor Michalek <libor@topspin.com>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       timur.tabi@ammasso.com
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace
 verbs implementation
X-Message-Flag: Warning: May contain useful information
References: <20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com> <20050425151459.1f5fb378.akpm@osdl.org>
	<426D6D68.6040504@ammasso.com> <20050425153256.3850ee0a.akpm@osdl.org>
	<52vf6atnn8.fsf@topspin.com> <20050425171145.2f0fd7f8.akpm@osdl.org>
	<52acnmtmh6.fsf@topspin.com> <20050425173757.1dbab90b.akpm@osdl.org>
	<52wtqpsgff.fsf@topspin.com> <20050426084234.A10366@topspin.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 26 Apr 2005 08:49:17 -0700
In-Reply-To: <20050426084234.A10366@topspin.com> (Libor Michalek's message
 of "Tue, 26 Apr 2005 08:42:34 -0700")
Message-ID: <52mzrlsflu.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Apr 2005 15:49:17.0565 (UTC) FILETIME=[80FE72D0:01C54A77]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Libor>   Do you mean that the set/clear parameters to do_mlock()
    Libor> are the actual flags which are set/cleared by the caller? 
    Libor> Also, the issue remains that the flags are not reference
    Libor> counted which is a problem if you are dealing with
    Libor> overlapping memory region, or even if one region ends and
    Libor> another begins on the same page. Since the desire is to be
    Libor> able to pin any memory that a user can malloc this is a
    Libor> likely scenario.

Good point... we need to figure out how to handle:

    a) app registers 0x0000 through 0x17ff
    b) app registers 0x1800 through 0x2fff
    c) app unregisters 0x0000 through 0x17ff
    d) the page at 0x1000 must stay pinned

hmm...

 - R.
