Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVEFLJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVEFLJF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 07:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVEFLJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 07:09:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7405 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261211AbVEFLIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 07:08:55 -0400
Subject: Re: [PATCH] VFS bugfix: two read_inode() calles without
	clear_inode() call between
From: David Woodhouse <dwmw2@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, dedekind@infradead.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <E1DTj3z-0005By-00@dorka.pomaz.szeredi.hu>
References: <1114607741.12617.4.camel@sauron.oktetlabs.ru>
	 <E1DQoui-0002In-00@dorka.pomaz.szeredi.hu>
	 <1114618748.12617.23.camel@sauron.oktetlabs.ru>
	 <E1DQqZu-0002Rf-00@dorka.pomaz.szeredi.hu>
	 <1114673528.3483.2.camel@sauron.oktetlabs.ru>
	 <20050428003450.51687b65.akpm@osdl.org>
	 <1115209055.8559.12.camel@sauron.oktetlabs.ru>
	 <20050504130450.7c90a422.akpm@osdl.org>
	 <1115242507.12012.394.camel@baythorne.infradead.org>
	 <20050504145811.63e9bb10.akpm@osdl.org>
	 <1115284240.12012.416.camel@baythorne.infradead.org>
	 <E1DTj3z-0005By-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Fri, 06 May 2005 12:08:49 +0100
Message-Id: <1115377730.16187.189.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-05 at 18:18 +0200, Miklos Szeredi wrote:
> Using yield() to wait for a precisely defined event (clear_inode()
> finishing) doesn't seem like a very good idea.  Especially, since
> Artem's patch will probably make it trigger more often.

Agreed. Even before Artem's patch, we're still effectively busy-waiting
for something which calls back into the file system's clear_inode method
and may well sleep and perform I/O.

> How about this (totally untested) patch?  Even if I_LOCK is not set
> initially, wake_up_inode() should do the right thing and wake up the
> waiting task after clear_inode().  It shouldn't cause spurious
> wakeups, since there should be no other reference to the inode.

Since Artem introduced a wake_up_inode() in dispose_list(), your patch
seems reasonable.

-- 
dwmw2

