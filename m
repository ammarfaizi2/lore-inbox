Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbUDMQ5i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 12:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbUDMQ5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 12:57:38 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:47491
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S263586AbUDMQ5c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 12:57:32 -0400
Subject: Re: NFS file handle cached incorrectly
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Mansfield <lkml@dm.cobite.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0404121736070.23214@dhcp07.cobite.com>
References: <Pine.LNX.4.58.0404121407530.23214@dhcp07.cobite.com>
	 <1081803713.7181.26.camel@lade.trondhjem.org>
	 <1081804045.7181.30.camel@lade.trondhjem.org>
	 <Pine.LNX.4.58.0404121736070.23214@dhcp07.cobite.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1081875450.2583.11.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Apr 2004 09:57:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På ty , 13/04/2004 klokka 07:25, skreiv David Mansfield:

> I don't think this is quite correct.  The 1 second or less gap is not 
> between two modifications of the directory.  It is between the initial 
> lookup and a remote modification.  The mtime IS being updated, it's 
> just not being checked. ie.

In my version of the patch (which I assume is what Steve grabbed) the
first thing nfs_cached_lookup() does is to call nfs_revalidate_inode(). 

It may well be that the directory attribute cache has not timed out yet.
If so, that will indeed cause the mtime not to be checked on the client.
If this really is a problem for you, then I suggest you make the
directory attribute caching less aggressive. 'man 5 nfs' and read up on
"acdirmin/acdirmax".

Cheers,
  Trond
