Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263092AbUC2TR7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 14:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUC2TR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 14:17:59 -0500
Received: from ns.suse.de ([195.135.220.2]:41623 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263092AbUC2TR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 14:17:57 -0500
Subject: Re: [EXT3/JBD] Periodic journal flush not enough?
From: Chris Mason <mason@suse.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Herbert Xu <herbert@gondor.apana.org.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andreas Dilger <adilger@clusterfs.com>
In-Reply-To: <1080586577.2285.107.camel@sisko.scot.redhat.com>
References: <20040326231958.GA484@gondor.apana.org.au>
	 <20040326154851.7a3ad417.akpm@osdl.org>
	 <1080586577.2285.107.camel@sisko.scot.redhat.com>
Content-Type: text/plain
Message-Id: <1080587796.28604.12.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 14:16:36 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 13:56, Stephen C. Tweedie wrote:

> Sounds like it's due to the "b_committed_data" avoidance code.  Ext3
> cannot immediately reuse disk space after a delete, because of lazy
> writeback --- until the final writeback of the delete hits disk, we have
> to be able to undo it.  And because in non-data-journaled modes we allow
> new disk writes to hit disk before a transaction commit, that means we
> can't reuse deleted blocks until after they are committed.
> 
> I've never seen it reported as a problem outside of artificial test
> scenarios, but if it is something we need to address, Andreas Dilger's
> patch looks good.

Just FYI, reiserfs does something slightly different.  When
reiserfs_file_write and get_block routines see -ENOSPC, they get things
into a consistent state, commit the running transaction and try again
(once).  It didn't end up very complex...

-chris


