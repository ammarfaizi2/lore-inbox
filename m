Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVD1Hoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVD1Hoy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbVD1Hoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:44:34 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:3752 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262128AbVD1HmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:42:04 -0400
To: dedekind@infradead.org
CC: linux-kernel@vger.kernel.org, dwmw2@infradead.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org
In-reply-to: <1114673528.3483.2.camel@sauron.oktetlabs.ru>
	(dedekind@infradead.org)
Subject: Re: [PATCH] VFS bugfix: two read_inode() calles without
	clear_inode() call between
References: <1114607741.12617.4.camel@sauron.oktetlabs.ru>
	 <E1DQoui-0002In-00@dorka.pomaz.szeredi.hu>
	 <1114618748.12617.23.camel@sauron.oktetlabs.ru>
	 <E1DQqZu-0002Rf-00@dorka.pomaz.szeredi.hu> <1114673528.3483.2.camel@sauron.oktetlabs.ru>
Message-Id: <E1DR3ei-0005OC-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 28 Apr 2005 09:41:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Why do you need to move it from prune_icache() to dispose_list()?
> > For the hash list it's the right thing, but for sb_list it's not
> > needed, is it?
> Yes, it is not needed but harmless. I did it only because i_hash &
> i_sb_list insertions/deletions always come in couple. So I decided move
> them both, to be more consistent, to make code less complicated.
> 
> If you regard this hazardous I might split these removals. But IMHO, my
> variant is a bit more pleasant.

It's not just pleasentness.  You should be _very_ careful with any
changes you make to this kind of code, and have a very clear
explanation why the change is needed, and why it won't do any trouble.

I didn't actually think about the sb_list stuff, but my feeling is you
should not move it unless there's a very clear reason to do so.

Miklos
