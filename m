Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWHIV5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWHIV5N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 17:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWHIV5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 17:57:13 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:56292 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751394AbWHIV5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 17:57:12 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] ReiserFS: Make sure all dentries refs are released before calling kill_block_super() [try #2]
Date: Wed, 9 Aug 2006 23:56:13 +0200
User-Agent: KMail/1.9.3
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, Olof Johansson <olof@lixom.net>
References: <32278.1155057836@warthog.cambridge.redhat.com> <20060804192540.17098.39244.stgit@warthog.cambridge.redhat.com> <912.1155131006@warthog.cambridge.redhat.com>
In-Reply-To: <912.1155131006@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608092356.13246.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 15:43, David Howells wrote:
> 
> Make sure all dentries refs are released before calling kill_block_super() so
> that the assumption that generic_shutdown_super() can completely destroy the
> dentry tree for there will be no external references holds true.
> 
> What was being done in the put_super() superblock op, is now done in the
> kill_sb() filesystem op instead, prior to calling kill_block_super().
> 
> 
> Changes made in [try #2]:
> 
>  (*) reiserfs_kill_sb() now checks that the superblock FS info pointer is set
>      before trying to dereference it.

This one works on my box just fine.

Thanks,
Rafael
