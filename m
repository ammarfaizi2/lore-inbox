Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265911AbTGIKRk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268137AbTGIKRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:17:39 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:30892 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265911AbTGIKQR
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:16:17 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16139.61149.764358.333360@laputa.namesys.com>
Date: Wed, 9 Jul 2003 14:30:53 +0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel@vger.kernel.org
Subject: Re: [PATCH] 1/5 VM changes: zone-pressure.patch
In-Reply-To: <20030709032227.23ee4159.akpm@osdl.org>
References: <16139.54887.932511.717315@laputa.namesys.com>
	<20030709032227.23ee4159.akpm@osdl.org>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Nikita Danilov <Nikita@Namesys.COM> wrote:
 > >
 > >  +	if (priority < 0) {
 > >  +		for (i = 0; i < pgdat->nr_zones; i++) {
 > >  +			struct zone *zone = pgdat->node_zones + i;
 > >  +
 > >  +			if (zone->free_pages < zone->pages_high)
 > >  +				zone_adj_pressure(zone, -1);
 > >  +		}
 > >  +	}
 > 
 > What is this bit doing?

kswapd failed to balance some zone after going up to the maximal
priority (0), increase ->pressure on this zone.

In other words: zone->pressure is average of the scanning priority
required to free enough pages in this zone. As no scanning priority was
enough to free pages, zone->pressure should be extra high.

Nikita.

