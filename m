Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUDPQTD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263371AbUDPQTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:19:03 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:10881
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S262406AbUDPQTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:19:00 -0400
Subject: Re: NFS export ... again
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: fabian.frederick@prov-liege.be
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <S262454AbUDPHML/20040416071211Z+2733@vger.kernel.org>
References: <S262454AbUDPHML/20040416071211Z+2733@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082132338.2581.42.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Apr 2004 09:18:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-16 at 00:05, fabian.frederick@prov-liege.be wrote:
> Trond, Chris,
> 
>      AFAICS, nfsd/export code already does some nfs cache poll through RPC to generate /proc/nfs/exports .... But content appears broken to me as it relates progressive mounting points but never umounts.We only have to fix this in my opinion ... or maybe I'm lured by multi-versioning there ... 

/proc/nfs/exports is a server-side thing, and just reflects the kernel's
cache of currently exported filesystems. It is controlled by mountd by
means of a syscall...

I don't see what you are getting at here. There is no such thing as a
reliable way of ensuring that the server has a fully uptodate list of
all clients that are currently mounting a filesystem: Clients can and do
crash. When they do, they will fail to send a "umount" call to the
server. When that happens, the reference count in /var/lib/nfs/rmtab
will be wrong, and so all these lists from /proc/fs/nfs/exports to
"showmount" will show clients that are no longer there.

Just don't rely on that information: it will never be completely
correct.

Cheers,
  Trond
