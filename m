Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264263AbUEXMJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264263AbUEXMJH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 08:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUEXMJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 08:09:07 -0400
Received: from canuck.infradead.org ([205.233.217.7]:53767 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S264263AbUEXMI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 08:08:59 -0400
Date: Mon, 24 May 2004 08:08:58 -0400
From: hch@infradead.org
To: "Peter J. Braam" <braam@clusterfs.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       "'Phil Schwan'" <phil@clusterfs.com>
Subject: Re: [PATCH/RFC] Lustre VFS patch
Message-ID: <20040524120858.GE26863@infradead.org>
Mail-Followup-To: hch@infradead.org, "Peter J. Braam" <braam@clusterfs.com>,
	torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
	'Phil Schwan' <phil@clusterfs.com>
References: <20040524114009.96CE13100E2@moraine.clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524114009.96CE13100E2@moraine.clusterfs.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> vfs-raw_ops-vanilla-2.6.patch
> 
>   This adds raw operations for setattr, mkdir, rmdir, mknod, unlink,
>   symlink, link and rename.  The raw operations look up the parent
>   directories (but not leaf nodes) involved in the operation and then
>   ask the file system to execute the operation.  These methods allow
>   us to delegate the execution of these functions to the server, and
>   instantiate no dentries for leaf nodes, leaf nodes will only enter
>   the dcache on subsequent lookups.  This patch dramatically
>   simplifies the client/server lock management, particularly for
>   rename.
>  
>   In Ottawa Linus suggested that we could maybe do this with intents
>   instead.  I feel that both are ugly, both are possible but intents
>   looked akward.


This is complete crap.  We don't want to methods for every namespace
operation.  Please try to work out a scheme that needs only one method
fitting both lustre and normal filesystems (I guess by passing struct
nameidata everywhere instead of just the dentry and allowing no instanciation
for special filesystems).  But this is major surgery and makes only sense
for 2.7.x and if you actually want to merge lustre (or another filesystem
makign use of it) into mainline.

