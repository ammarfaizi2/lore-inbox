Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVAJIft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVAJIft (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 03:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVAJIfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 03:35:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21921 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262147AbVAJIfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 03:35:40 -0500
Date: Mon, 10 Jan 2005 02:35:24 -0600
From: Ken Preslan <kpreslan@redhat.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Arjan van de Ven <arjan@infradead.org>, viro@zenII.uk.linux.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: make flock_lock_file_wait static
Message-ID: <20050110083524.GA9750@potassium.msp.redhat.com>
References: <20050109194209.GA7588@infradead.org> <1105310650.11315.19.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105310650.11315.19.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 05:44:10PM -0500, Trond Myklebust wrote:
> su den 09.01.2005 Klokka 19:42 (+0000) skreiv Arjan van de Ven:
> > Hi,
> > 
> > the patch below makes flock_lock_file_wait static, because it is only used
> > (once) in fs/locks.c. Making it static allows gcc to generate better code
> > (partial or entirely inlining it, gcc 3.4 also optimizes the calling
> > convention for static functions which are guaranteed only local to the file)
> 
> Veto. That function is also there for those filesystems that need to
> mirror their locks in the VFS. I believe the GFS people are already
> using it (they implemented all this anyway), and sooner or later, NFS is
> going to have to do it too...

I second the veto.  GFS does use this interface.

-- 
Ken Preslan <kpreslan@redhat.com>

