Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVEFNkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVEFNkF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 09:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVEFNjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 09:39:54 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:62736 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261161AbVEFNj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 09:39:27 -0400
To: dwmw2@infradead.org
CC: akpm@osdl.org, dedekind@infradead.org, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1115386405.16187.196.camel@hades.cambridge.redhat.com> (message
	from David Woodhouse on Fri, 06 May 2005 14:33:24 +0100)
Subject: Re: [PATCH] __wait_on_freeing_inode fix
References: <E1DU1Hy-00060Q-00@dorka.pomaz.szeredi.hu> <1115386405.16187.196.camel@hades.cambridge.redhat.com>
Message-Id: <E1DU32M-00068d-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 06 May 2005 15:38:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's all well and good if it's actually generic_delete_inode() which
> removes the inode from the hash chain. But if it's prune_icache() which
> does that, you don't get the wakeup.
> 
> Applying Artem's patch will fix that.

I think it should work without Artem's patch too, since prune_icache()
removes the inode from the hash chain at the same time (under
inode_lock) as changing it's state to I_FREEING.  So the pruned inode
will never be seen by iget().

Miklos
