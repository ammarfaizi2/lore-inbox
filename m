Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUDLVHd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 17:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUDLVHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 17:07:33 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:50831
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S263117AbUDLVH3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 17:07:29 -0400
Subject: Re: NFS file handle cached incorrectly
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Mansfield <lkml@dm.cobite.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1081803713.7181.26.camel@lade.trondhjem.org>
References: <Pine.LNX.4.58.0404121407530.23214@dhcp07.cobite.com>
	 <1081803713.7181.26.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1081804045.7181.30.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 12 Apr 2004 14:07:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På m , 12/04/2004 klokka 14:01, skreiv Trond Myklebust:
> The problem here is rather that you are making remote modifications to
> the NFS server's directory within < 1second (which is the resolution on
> "mtime" on Linux 2.4.x) of the previous modification. Linux (and all
> other NFS clients that I'm aware of) uses the mtime in order to decide
> whether or not a file/directory/... has been modified since the cache
> was last updated (unless it is a modification that was made by this
> client).

Clarification: the problem is IOW the fact that the server will not
update mtime for any changes that are made within 1 second of one
another. The same client will work fine with any server that has better
resolution on mtime. Hence the suggestion:

> The only "solution" to your problem here is to upgrade the *server* to
> Linux-2.6.x: the latter has 1 nanosecond resolution on the "mtime", and
> so can register modifications that are far smaller than 1second.

Cheers,
  Trond
