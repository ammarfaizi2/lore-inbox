Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268270AbUHXUZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268270AbUHXUZd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268277AbUHXUZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:25:33 -0400
Received: from verein.lst.de ([213.95.11.210]:4007 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268270AbUHXUZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:25:28 -0400
Date: Tue, 24 Aug 2004 22:25:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, reiser@namesys.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: silent semantic changes with reiser4
Message-ID: <20040824202521.GA26705@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	reiser@namesys.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After looking trough the code and mailinglists I'm quite unhappy with
a bunch of user-visible changes that Hans sneaked in and make reiser4
incompatible with other filesystems and have a slight potential to break
even in the kernel.

 o files as directories
   - O_DIRECTORY opens succeed on all files on reiser4.  Besides breaking
     .htaccess handling in apache and glibc compilation this also renders
     this flag entirely useless and opens up the races it tries to
     prevent against cmpletely useless
   - meaning of the -x permission.  This one has different meanings on
     directories vs files on UNIX systems.  If we want to support
     directories as files we'll probably have to find a way to work
     around this.
   - dentry aliasing.  I can't find a formal guarantee in the code this
     can't happen
 
 o metafiles - ..metas as a magic name that's just taken out of the
   namespace doesn't sound like a good idea.  If we want this it should
   be a VFS-level option and there should be a translation-layer to
   xattrs.  Not doing this will again confuse applications greatly that
   expect uniform filesystem behaviour.

Given these problems I request that these interfaces are removed from
reiser4 for the kernel merge, and if added later at the proper VFS level
after discussion on linux-kernel and linux-fsdevel, like we did for
xattrs.
