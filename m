Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030740AbWKOR2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030740AbWKOR2V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030745AbWKOR2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:28:21 -0500
Received: from gw.goop.org ([64.81.55.164]:3805 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030743AbWKOR2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:28:16 -0500
Message-ID: <455B4E2F.7040408@goop.org>
Date: Wed, 15 Nov 2006 09:28:15 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andi Kleen <ak@suse.de>, Eric Dumazet <dada1@cosmosbay.com>, akpm@osdl.org,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386-pda UP optimization
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <1158047806.2992.7.camel@laptopd505.fenrus.org> <200611151227.04777.dada1@cosmosbay.com> <200611151232.31937.ak@suse.de> <20061115172003.GA20403@elte.hu>
In-Reply-To: <20061115172003.GA20403@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> Eric's test shows a 5% slowdown. That's far from cheap.
>   

It seems like an absurdly large difference.  PDA references aren't all
that common in the kernel; for the %gs prefix on PDA accesses to be
causing a 5% overall difference in a test like this means that the
prefixes would have to be costing hundreds or thousands of cycles, which
seems absurd.  Particularly since Eric's patch doesn't touch head.S, so
the %gs save/restore is still being executed.

Are we sure this isn't a cache layout issue?  Eric, did you try evicting
your executable from pagecache between runs to see if you get variation
depending on what physical pages it gets put into?  (Making several
copies of the executable should have the same effect.)

    J
