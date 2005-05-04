Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVEDVgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVEDVgu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 17:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVEDVgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 17:36:43 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:43691 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261666AbVEDVfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 17:35:10 -0400
Subject: Re: [PATCH] VFS bugfix: two read_inode() calles without
	clear_inode() call between
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: dedekind@infradead.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20050504130450.7c90a422.akpm@osdl.org>
References: <1114607741.12617.4.camel@sauron.oktetlabs.ru>
	 <E1DQoui-0002In-00@dorka.pomaz.szeredi.hu>
	 <1114618748.12617.23.camel@sauron.oktetlabs.ru>
	 <E1DQqZu-0002Rf-00@dorka.pomaz.szeredi.hu>
	 <1114673528.3483.2.camel@sauron.oktetlabs.ru>
	 <20050428003450.51687b65.akpm@osdl.org>
	 <1115209055.8559.12.camel@sauron.oktetlabs.ru>
	 <20050504130450.7c90a422.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 04 May 2005 22:35:07 +0100
Message-Id: <1115242507.12012.394.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-04 at 13:04 -0700, Andrew Morton wrote:
> This sounds more like a bug in the iget() caller to me.
> 
> Question is: if the inode has zero refcount and is unhashed then how
> did the caller get its sticky paws onto the inode* in the first place?
> 
> If the caller had saved a copy of the inode* in local storage then the
> caller should have taken a ref against the inode.
> 
> If the caller had just looked up the inode via hastable lookup via
> iget_whatever() then again the caller will have a ref on the inode.
> 
> So.  Please tell us more about how the caller got into this situation.

I could explain in detail how JFFS2 garbage collection works, moving log
entries out of the way by calling iget() on the inode to which they
belong.... or I could just say "NFS".

-- 
dwmw2


