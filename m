Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbUDZK3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUDZK3P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 06:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbUDZK3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 06:29:15 -0400
Received: from ns.suse.de ([195.135.220.2]:54997 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261989AbUDZK2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 06:28:48 -0400
Subject: [PATCH 0/11] nfsacl
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1082975143.3295.68.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 26 Apr 2004 12:28:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is the nfsacl protocol extension that implements setting/retrieving
acls over NFSv3. (It has nothing to do with NFSv4 acls, which are very
different.) Any chance we can get this into -mm, and into mainline after
some more exposure? The patches are:

sunrpc-enosys-when-unavail
   Differentiate between program/procedure not available and
   other errors. Required so that nfs clients know whether or
   not the server supports nfsacl.

sunrpc-multiple-programs
   Support multiple program numbers on one RPC transport. The nfs
   and nfsacl RPC programs both run on the same transport, so
   we need to multiplex.

rpcsvc-pages
   Add a page to an rpc reply from the allocated pool.

sunrpc-xdr-words
   Encode 32-bit words in xdr_buf's. The code is modeled after the
   decode functions already in 2.6.6-rc2.

sunrpc-xdr-arrays
   sunrpc: Encode/decode arrays that may become large.

nfsacl-lazy-alloc
   Allow to allocate pages in the receive buffers lazily. ACLs may have
   up to 1024 entries in nfsacl but usually are small, so allocating
   space for them on demand makes sense.

nfs-access-acl
   NFS mount parameter noacl: Allow clients to mount without using
   the ACCESS remote procedure call.

qsort
   Add qsort, needed for decoding acls from nfsacl.

xfs-no-qsort
   Remove qsot from xfs. Without, qsort would be defined twice in the
   kernel.

nfsd-acl
   Server nfsacl support.

nfs-acl
   Client nfsacl support.


Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

