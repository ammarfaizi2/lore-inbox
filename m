Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVETQRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVETQRj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 12:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVETQRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 12:17:39 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:62732 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261491AbVETQRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 12:17:36 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
CC: akpm@osdl.org, dhowells@redhat.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <20050520144737.GR29811@parcelfarce.linux.theplanet.co.uk>
	(message from Al Viro on Fri, 20 May 2005 15:47:37 +0100)
Subject: Re: [PATCH] namespace.c: cleanup in mark_mounts_for_expiry()
References: <E1DZ7xj-0003ol-00@dorka.pomaz.szeredi.hu> <20050520144737.GR29811@parcelfarce.linux.theplanet.co.uk>
Message-Id: <E1DZAAs-000418-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 20 May 2005 18:16:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks sane.  However, we still have a problem here - just what would
> happen if vfsmount is detached while we were grabbing namespace
> semaphore?  Refcount alone is not useful here - we might be held by
> whoever had detached the vfsmount.  IOW, we should check that it's
> still attached (i.e. that mnt->mnt_parent != mnt).  If it's not -
> just leave it alone, do mntput() and let whoever holds it deal with
> the sucker.  No need to put it back on lists.

Right.  I'll fix that too.

On a bit unrelated node, in do_unmount() why is that
DQUOT_OFF()/acct_auto_close() thing only called for the base of a tree
being detached, and not for any submounts?  Is that how it's supposed
to work?

Miklos
