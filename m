Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752021AbWICELM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbWICELM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 00:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752020AbWICELM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 00:11:12 -0400
Received: from pat.uio.no ([129.240.10.4]:19686 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1752018AbWICELK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 00:11:10 -0400
Subject: Re: [PATCH 04/22][RFC] Unionfs: Common file operations
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
In-Reply-To: <20060902024747.GA11964@filer.fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
	 <20060901014138.GE5788@fsl.cs.sunysb.edu>
	 <1157149200.5628.38.camel@localhost>
	 <20060902024747.GA11964@filer.fsl.cs.sunysb.edu>
Content-Type: text/plain
Date: Sun, 03 Sep 2006 00:10:59 -0400
Message-Id: <1157256659.5637.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.199, required 12,
	autolearn=disabled, AWL 1.80, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 22:47 -0400, Josef Sipek wrote:

> From what I can see, the solution to this would be to pass the lookup
> intents in unionfs_lookup down to the lower filesystem (the way it should be
> done in the first place). Then, we could use the dentry here without any
> problems. Is that all that needs to be done or am I forgetting something?

That sounds correct. If you pass the lookup intents down to the
underlying filesystem while doing the lookup, then all should be well:
NFS will actually open the file for you at that point too, whereas most
other filesystems will just look it up and return the dentry.

In any case, you avoid the race, because you lookup/revalidate the
underlying dentry at the same time as you lookup/revalidate the unionfs
dentry.

Cheers,
  Trond


-- 
VGER BF report: H 0
