Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbVLFRy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVLFRy5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbVLFRy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:54:57 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:60561 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S964785AbVLFRy4 (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 6 Dec 2005 12:54:56 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17301.53377.614777.913013@gargle.gargle.HOWL>
Date: Tue, 6 Dec 2005 20:55:13 +0300
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH 01/16] mm: delayed page activation
In-Reply-To: <20051205014842.GA5103@mail.ustc.edu.cn>
References: <20051203071444.260068000@localhost.localdomain>
	<20051203071609.755741000@localhost.localdomain>
	<17298.56560.78408.693927@gargle.gargle.HOWL>
	<20051204134818.GA4305@mail.ustc.edu.cn>
	<17299.1331.368159.374754@gargle.gargle.HOWL>
	<20051205014842.GA5103@mail.ustc.edu.cn>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang writes:
 > On Sun, Dec 04, 2005 at 06:03:15PM +0300, Nikita Danilov wrote:
 > >  > inter-reference distance, and therefore should be better protected(if ignore
 > >  > possible read-ahead effects). If we move re-accessed pages immediately into
 > >  > active_list, we are pushing them closer to danger of eviction.
 > > 
 > > Huh? Pages in the active list are closer to the eviction? If it is
 > > really so, then CLOCK-pro hijacks the meaning of active list in a very
 > > unintuitive way. In the current MM active list is supposed to contain
 > > hot pages that will be evicted last.
 > 
 > The page is going to active list anyway. So its remaining lifetime in inactive
 > list is killed by the early move.

But this change increased lifetimes of _all_ pages, so this is
irrelevant. Consequently, it has a chance of increasing scanning
activity, because there will be more referenced pages at the cold tail
of the inactive list.

And --again-- this erases information about relative order of
references, and this is important. In the past, several VM modifications
(like split inactive_clean and inactive_dirty lists) were tried that had
various advantages over current scanner, but maintained weaker LRU, and
they all were found to degrade horribly under certain easy triggerable
conditions.

 > 
 > Thanks,
 > Wu

Nikita.
