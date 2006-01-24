Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbWAXHHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWAXHHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 02:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWAXHHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 02:07:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39583 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932239AbWAXHHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 02:07:21 -0500
Subject: Re: [PATCH/RFC] Shared page tables
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Ray Bryant <raybry@mpdtxmail.amd.com>, Dave McCracken <dmccr@us.ibm.com>,
       Robin Holt <holt@sgi.com>, Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <200601240210.04337.ak@suse.de>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
	 <200601240139.46751.ak@suse.de>
	 <200601231853.54948.raybry@mpdtxmail.amd.com>
	 <200601240210.04337.ak@suse.de>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 08:06:37 +0100
Message-Id: <1138086398.2977.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The randomization is not for cache coloring, but for security purposes
> (except for the old very small stack randomization that was used
> to avoid conflicts on HyperThreaded CPUs). I would be surprised if the
> mmap made much difference because it's page aligned and at least
> on x86 the L2 and larger caches are usually PI.

randomization to a large degree is more important between machines than
within the same machine (except for setuid stuff but lets call that a
special category for now). Imo prelink is one of the better bets to get
"all code for a binary/lib on the same 2 mb page", all distros ship
prelink nowadays anyway (it's too much of a win that nobody can afford
to not ship it ;) and within prelink the balance between randomization
for security and 2Mb sharing can be struck best. In fact it needs know
about the 2Mb thing anyway to place it there properly and for all
binaries... the kernel just can't do that.

