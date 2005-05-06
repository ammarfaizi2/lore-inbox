Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVEFNwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVEFNwi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 09:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVEFNwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 09:52:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51331 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261226AbVEFNwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 09:52:24 -0400
Subject: Re: [PATCH] __wait_on_freeing_inode fix
From: David Woodhouse <dwmw2@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, dedekind@infradead.org, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1DU32M-00068d-00@dorka.pomaz.szeredi.hu>
References: <E1DU1Hy-00060Q-00@dorka.pomaz.szeredi.hu>
	 <1115386405.16187.196.camel@hades.cambridge.redhat.com>
	 <E1DU32M-00068d-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Fri, 06 May 2005 14:52:17 +0100
Message-Id: <1115387537.16187.209.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-06 at 15:38 +0200, Miklos Szeredi wrote:
> I think it should work without Artem's patch too, since prune_icache()
> removes the inode from the hash chain at the same time (under
> inode_lock) as changing it's state to I_FREEING.  So the pruned inode
> will never be seen by iget().

Doh. Yes, of course -- it had temporarily escaped my notice that the
whole _point_ of Artem's patch is that prune_icache() is currently
broken in precisely the way you describe.

-- 
dwmw2

