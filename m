Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTLUBJz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 20:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTLUBJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 20:09:55 -0500
Received: from imladris.surriel.com ([66.92.77.98]:8840 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S262030AbTLUBJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 20:09:52 -0500
Date: Sat, 20 Dec 2003 20:10:13 -0500 (EST)
From: Rik van Riel <riel@surriel.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, ak@suse.de, mbligh@us.ibm.com
Subject: Re: [PATCH] make try_to_free_pages walk zonelist
In-Reply-To: <20031220170042.3feb6aa7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.55L.0312202001120.31547@imladris.surriel.com>
References: <Pine.LNX.4.55L.0312201928530.31547@imladris.surriel.com>
 <20031220170042.3feb6aa7.akpm@osdl.org>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Dec 2003, Andrew Morton wrote:

> hm, OK, so this should be a no-op for non-NUMA setups.

Exactly, the zonelist is equivalent to the classzone on non-NUMA.

> Could you suggest a suitable worklaod for Andi and Martin to test sometime?

It would have to be something where kswapd can't keep
up and the workload benefits from having memory allocated
from all zones/nodes in the zone list.

OTOH, if the workload didn't benefit from allocating memory
from multiple nodes, maybe the zonelist shouldn't include
zones from other nodes in the first place ? ;)

I'm not quite sure exactly what workload to test here...

One way to artificially test this code path would be by
setting lower_zone_protection to 2 on an AMD64 system with
two equally sized zones, while running a single threaded
memory intensive workload.  Very artificial, though.

> Meanwhile, I'll mmify it for a bit of soak testing, thanks.

Thanks.

Rik
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
