Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVEFNuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVEFNuY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 09:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVEFNuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 09:50:24 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:46354 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261199AbVEFNuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 09:50:19 -0400
To: dedekind@infradead.org
CC: dwmw2@infradead.org, akpm@osdl.org, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1115387072.27158.31.camel@sauron.oktetlabs.ru>
	(dedekind@infradead.org)
Subject: Re: [PATCH] __wait_on_freeing_inode fix
References: <E1DU1Hy-00060Q-00@dorka.pomaz.szeredi.hu>
	 <1115386405.16187.196.camel@hades.cambridge.redhat.com>
	 <E1DU32M-00068d-00@dorka.pomaz.szeredi.hu> <1115387072.27158.31.camel@sauron.oktetlabs.ru>
Message-Id: <E1DU3Cv-0006AZ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 06 May 2005 15:49:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I think it should work without Artem's patch too, since prune_icache()
> > removes the inode from the hash chain at the same time (under
> > inode_lock) as changing it's state to I_FREEING.  So the pruned inode
> > will never be seen by iget().
> > 
> I suppose this doesn't mean that your patch fixes my problem (it mustn't
> I believe) ?

You are right.  They are completely orthogonal, except the fact that
with your patch, the iget() clear_inode() collision will be more
frequent, and thus the yield() hack would trigger more often.

Miklos
