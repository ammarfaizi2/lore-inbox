Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268868AbUIBTaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268868AbUIBTaf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 15:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268474AbUIBTaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 15:30:35 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:16955 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268868AbUIBT3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:29:43 -0400
Message-ID: <2c6b3ab004090212293b394b41@mail.gmail.com>
Date: Fri, 3 Sep 2004 00:59:42 +0530
From: Amit Gud <amitgud@gmail.com>
Reply-To: Amit Gud <amitgud@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Using filesystem blocks
Cc: gud@eth.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if this has been already discussed on the list before.

Is it wise enough to abstract away the usage of blocks for storing
extended attributes? I mean can the code  - of using filesystem
blocks, putting headers and all data in place within the blocks,
managing the block boundaries, padding ... - be taken away from within
the xattr code. I know xattr is filesystem specific, but if most of
filesystems are using blocks not associated with any inode to store
xattr-specifc information it could well be taken to a different layer
- just like mbcache. Almost only ext2/3 uses mbcache - and that too
only for xattr - but it is implemented at an abstract level.

Not only this would add to the modularization, this can help other
filesystems if they want to use filesystem blocks. Like if one wishes
to implement distributed filesystem, he may prefer to store the FS
metadata in blocks rather than in files. Is it advisible for him to
redo the code, which is very beautifully written in ext2/3 ? I think
not.

AG
