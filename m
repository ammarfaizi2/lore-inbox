Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272561AbTHKMxr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 08:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272563AbTHKMxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 08:53:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26059 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272561AbTHKMxp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 08:53:45 -0400
Message-ID: <3F3791C8.4090903@pobox.com>
Date: Mon, 11 Aug 2003 08:53:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Tomas <bzzz@tmi.comex.ru>
CC: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] file extents for EXT3
References: <m3ptjcabey.fsf@bzzz.home.net>
In-Reply-To: <m3ptjcabey.fsf@bzzz.home.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
> hello all!
> 
> there are several problems with old good method ext2/ext3
> use to store map of block for an inode. for example, ext3's
> truncate is quite slow. I think extents could solve this
> and some other troubles. so ...
> 
> 
> in fact, design is taken from htree modern ext2/ext3 uses. in constrast with
> htree, it isn't backward-compatible.

Neat.  I really like extents, and think this is the best long-term 
approach.  Apparently the ext3 maintainers do, too, because tytso/sct's 
"ext roadmap" paper publishing a while ago describes extents, too.  (I 
wish I had a URL for that)

Anyway, something to keep in mind:

Changing the underlying disk format without bumping the filesystem 
revision is a hugely bad idea.  I disagreed with merging htree (even 
though its backward compat) without bumping the filesystem version, too.

Vendors, distributors, OEMs, etc. all test against existing on-disk 
formats, when they release their products.  When the filesystem format 
for an existing filesystem, in production, changes underneath them, they 
tend to get worried and annoyed.  So, to all ext developers,

Please add <it> to ext4 not ext3!

	Jeff



