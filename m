Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVETMHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVETMHr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 08:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVETMHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 08:07:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51674 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261438AbVETMHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 08:07:39 -0400
Date: Fri, 20 May 2005 13:08:01 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linuxram@us.ibm.com, dhowells@redhat.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH retry 2] namespace.c: fix race in mark_mounts_for_expiry()
Message-ID: <20050520120801.GN29811@parcelfarce.linux.theplanet.co.uk>
References: <E1DZ5EX-0003cN-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DZ5EX-0003cN-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 01:00:01PM +0200, Miklos Szeredi wrote:
> I'll get there, I know!
> 
> This patch fixes a race found by Ram in mark_mounts_for_expiry() in
> fs/namespace.c.
> 
> The bug can only be triggered with simultaneous exiting of a process
> having a private namespace, and expiry of a mount from within that
> namespace.  It's practically impossible to trigger, and I haven't even
> tried.  But still, a bug is a bug.
> 
> The race happens when put_namespace() is called by another task, while
> mark_mounts_for_expiry() is between atomic_read() and get_namespace().
> In that case get_namespace() will be called on an already dead
> namespace with unforeseeable results.

ACK, provided that situation with extern vfsmount_lock is sorted out.
There's no need to declare it in namespace.h; it's already done in
mount.h and namespace.h includes the sucker.

IOW, lose that extern in namespace.h and you've got an ACK.
