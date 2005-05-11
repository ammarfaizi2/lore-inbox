Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVEKOT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVEKOT6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 10:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVEKOT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 10:19:58 -0400
Received: from holomorphy.com ([66.93.40.71]:16008 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261194AbVEKOTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 10:19:34 -0400
Date: Wed, 11 May 2005 07:19:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, dwmw2@infradead.org, dedekind@infradead.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] __wait_on_freeing_inode fix
Message-ID: <20050511141910.GE9304@holomorphy.com>
References: <E1DU1Hy-00060Q-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DU1Hy-00060Q-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2005 at 01:46:38PM +0200, Miklos Szeredi wrote:
> If I_LOCK was not set it called yield(), effectively busy waiting for
> the removal of the inode from the hash.  This change was introduced
> within "[PATCH] eliminate inode waitqueue hashtable" Changeset
> 1.1938.166.16 last october by wli.
> The solution is to restore the old behavior, of unconditionally
> waiting on the waitqueue.  It doesn't matter if I_LOCK is not set
> initally, the task will go to sleep, and wake up when wake_up_inode()
> is called from generic_delete_inode() after removing the inode from
> the hash chain.

I was trying to preserve some (possibly misinterpreted) behavior but I
can't remember what anymore. Anyway, since it's misbehaving, nuke it.


-- wli
