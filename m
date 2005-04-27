Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVD0Jh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVD0Jh7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 05:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVD0Jh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 05:37:59 -0400
Received: from gate.in-addr.de ([212.8.193.158]:35259 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261329AbVD0Jht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 05:37:49 -0400
Date: Wed, 27 Apr 2005 11:37:34 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: "Charles P. Wright" <cwright@cs.sunysb.edu>,
       "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
Cc: Jamie Lokier <jamie@shareable.org>, Ville Herva <v@iki.fi>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
Message-ID: <20050427093734.GK4431@marowsky-bree.de>
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com> <20050426134629.GU16169@viasys.com> <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru> <1114530002.29907.21.camel@polarbear.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1114530002.29907.21.camel@polarbear.fsl.cs.sunysb.edu>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-26T11:40:02, "Charles P. Wright" <cwright@cs.sunysb.edu> wrote:

> Atomicity is difficult, because you have lots of caches each with their
> own bits of state (e.g., the inode/dentry caches).  Assuming your
> transaction is committed that isn't so much of a problem, but once you
> have on rollback you need to undo any changes to those caches.
> 
> Isolation (this is the property that says that concurrent transactions
> should be the same as if there was a serial execution) is also tricky to
> get right.  A transaction can touch any number of objects, and user-
> applications may not respect any lock ordering --- which means you will
> have deadlocks, and you must detect and resolve them (probably by
> aborting one of the transactions).

Just as a weird idea, spawned by the FUSE thread.

"Transactions happen in their own namespace".

Besides having a namespace_(create|join) as needed for FUSE (or
similar), there'd be a privileged namespace_replace(target, source) (or
_merge, if you prefer - that however seems to imply that a namespace was
actually forked off another).

So, you want transactions for testing some software update, you create
your new one, mount stuff, do the update, and then "commit" it by
replacing the global namespace by it.

If you want to discard, just exit it. As soon as no further references
to a namespace exist, it can be cleaned up (and non-persistent
transactions will be 'unrolled' and thrown away).

Now where's that pipe of mine... ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

