Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265774AbUEZTG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265774AbUEZTG6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 15:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbUEZTG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 15:06:58 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:8224 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265774AbUEZTGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 15:06:34 -0400
Date: Wed, 26 May 2004 20:06:23 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: j-nomura@ce.jp.nec.com, <linux-kernel@vger.kernel.org>, <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [2.4] heavy-load under swap space shortage
In-Reply-To: <20040526124104.GF6439@logos.cnet>
Message-ID: <Pine.LNX.4.44.0405261934250.740-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004, Marcelo Tosatti wrote:

> Andrea, Hugh, Jun'ichi,
> 
> I think we can merge this patch.

I guess so.  I'm unenthusiastic since I've never worked out whether
it's _right_, or just an ad hoc hack that happens to work around
more fundamental issues, quite successfully in some workloads.

Andrea seems to have devised it to reduce pagemap_lru_lock
contention on bigiron, yet here it's solving a different problem.
Which may be a sign that it's a great patch, or a sign that we
(I!) don't understand what goes on here well enough.

Please don't count me as against it: I just don't know.

(My involvement was earlier when Jun'ichi reported page_table_lock
contention there.  We were working together on an entirely different
kind of patch addressing that issue, when Andrea suggested he try this
vm_anon_lru patch.  As I understand it, that solved Jun'ichi's particular
problem much more satisfactorily than our own dabblings; but I rather
dropped out at that point.)

> Its very safe - default behaviour unchanged. 

Yes, but please update the comments to reflect that, they imply
vm_anon_lru 0 by default, presumably how it was in Andrea's tree.

The tunability, of course, does unfairly make it look more like a
hack than it is; but if we're uncertain, yes, a tunable hack is
much better than a wrong decision now.

Hugh

