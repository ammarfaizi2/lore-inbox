Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVDZRY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVDZRY7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVDZRYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:24:34 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:8122 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S261690AbVDZRWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:22:53 -0400
Subject: Re: filesystem transactions API
From: "Charles P. Wright" <cwright@cs.sunysb.edu>
To: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
Cc: Jamie Lokier <jamie@shareable.org>, Ville Herva <v@iki.fi>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <426E6731.5000703@oktetlabs.ru>
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk>
	 <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com>
	 <20050426134629.GU16169@viasys.com>
	 <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru>
	 <1114530002.29907.21.camel@polarbear.fsl.cs.sunysb.edu>
	 <426E6731.5000703@oktetlabs.ru>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 13:22:44 -0400
Message-Id: <1114536164.1932.1.camel@polarbear.fsl.cs.sunysb.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-14) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 20:07 +0400, Artem B. Bityuckiy wrote:
> Charles P. Wright wrote:
> > Atomicity is difficult, because you have lots of caches each with their
> > own bits of state (e.g., the inode/dentry caches).  Assuming your
> > transaction is committed that isn't so much of a problem, but once you
> > have on rollback you need to undo any changes to those caches.
> I guess if you do synchronization before unlocking all is OK. Roll-back 
> means deleting partially written things and restore old things, then run 
> fsyncs. Whys this may be not enough?
That would be fine for the on-disk image of the file system, but the in-
memory image also needs to be handled.  Keeping track of all of these
objects and their changes is not a simple task.

Charles

