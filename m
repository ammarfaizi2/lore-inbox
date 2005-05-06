Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVEFNgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVEFNgm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 09:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVEFNgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 09:36:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18819 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261235AbVEFNdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 09:33:31 -0400
Subject: Re: [PATCH] __wait_on_freeing_inode fix
From: David Woodhouse <dwmw2@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, dedekind@infradead.org, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1DU1Hy-00060Q-00@dorka.pomaz.szeredi.hu>
References: <E1DU1Hy-00060Q-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Fri, 06 May 2005 14:33:24 +0100
Message-Id: <1115386405.16187.196.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-06 at 13:46 +0200, Miklos Szeredi wrote:
> The solution is to restore the old behavior, of unconditionally
> waiting on the waitqueue.  It doesn't matter if I_LOCK is not set
> initally, the task will go to sleep, and wake up when wake_up_inode()
> is called from generic_delete_inode() after removing the inode from
> the hash chain.

That's all well and good if it's actually generic_delete_inode() which
removes the inode from the hash chain. But if it's prune_icache() which
does that, you don't get the wakeup.

Applying Artem's patch will fix that.

-- 
dwmw2

