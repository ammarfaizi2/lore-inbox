Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbUCKTmq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUCKTmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:42:46 -0500
Received: from dh197.citi.umich.edu ([141.211.133.197]:52097 "EHLO
	nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S261674AbUCKTll convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:41:41 -0500
Subject: Re: UID/GID mapping system
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: =?ISO-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1078993757.1576.41.camel@quaoar>
References: <1078775149.23059.25.camel@luke> <04031009285900.02381@tabby>
	 <1078941525.1343.19.camel@homer>  <04031015412900.03270@tabby>
	 <1078958747.1940.80.camel@nidelv.trondhjem.org>
	 <1078993757.1576.41.camel@quaoar>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1079034097.5205.37.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 14:41:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 11/03/2004 klokka 03:29, skreiv Søren Hansen:
> > If you really need uid/gid mapping for NFSv2/v3 too, why not just build
> > on the existing v4 upcall/downcall mechanisms?
> 
> Because that would require changes to both ends of the wire. I want this
> to:
> 1. Work for ALL filesystems (NFS, smbfs, ext2(*) etc.)
> 2. Be transparent for the server.

No... I said to build on the upcall/downcall mechanism. I said nothing
about modifying the on-the-wire protocol.

My point is that we have evolved more or less GENERIC mechanisms for
calling up to userland with a string/number and having it mapped into
something else via a downcall. (worse: in fact we have 2 mechanisms for
doing it - one that is used by the client, the other by the server).

The only way in which we fail to meet the above requirements are that
the code to do it is in the NFS/RPC layers. Move it out of there, and it
could be reused by everybody.
No need for a third upcall/downcall mechanism that does the same thing.

Cheers,
  Trond
