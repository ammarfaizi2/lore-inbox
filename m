Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVFZQqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVFZQqR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 12:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVFZQqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 12:46:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38787 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261396AbVFZQqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 12:46:12 -0400
Date: Sun, 26 Jun 2005 17:46:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Alexander Zarochentsev <zam@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       reiserfs-list@namesys.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
Message-ID: <20050626164606.GA18942@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hans Reiser <reiser@namesys.com>,
	Alexander Zarochentsev <zam@namesys.com>,
	Jeff Garzik <jgarzik@pobox.com>, reiserfs-list@namesys.com,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org> <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com> <200506221824.32995.zam@namesys.com> <20050622142947.GA26993@infradead.org> <42BA2ED5.6040309@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BA2ED5.6040309@namesys.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 08:39:01PM -0700, Hans Reiser wrote:
> Correct me if I am wrong:
> 
> What exists currently in VFS are vector instances, not classes. Plugins,
> selected by pluginids, are vector classes, with each pluginid selecting
> a vector class. You propose to have the vector class layer (aka plugin
> layer) in reiser4 export the vector instance to VFS for VFS to handle
> for each object, rather than having VFS select reiser4 and reiser4
> selecting a vector class (aka plugin) which selects a method.
> 
> If we agree on the above, then I will comment further.

I'm a bit confused about what you're saying here.  What does the 'vector'
in all these expressions mean?

In OO terminology our *_operation structures are interfaces.  Each particular
instance of such a struct that is filled with function pointers is a class.
Each instance of an inode/file/dentry/superblock/... that uses these operation
vectors is an object.

What I propose (or rather demand ;-)) is that you don't duplicate this
infrastructure, and add another dispath layer below these objects but instead
re-use it for what it is done and only handle things specific to reiser4
in your own code. 
