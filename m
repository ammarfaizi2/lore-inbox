Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbUCJVea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbUCJVea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:34:30 -0500
Received: from mail.shareable.org ([81.29.64.88]:64905 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262840AbUCJVe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 16:34:28 -0500
Date: Wed, 10 Mar 2004 21:34:27 +0000
From: Jamie Lokier <jamie@shareable.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for testing] cow behaviour for hard links
Message-ID: <20040310213427.GB7341@mail.shareable.org>
References: <20040310193429.GB4589@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040310193429.GB4589@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> Yeah, well, here it is, sortof.  It works on file granularity instead
> of block, doesn't do the cow part inside the kernel (userspace get's
> an error and has to do it).  But it works for ext2 and ext3 and is
> relatively short.
> 
> Interna:
> I introduced a new flag for inodes, switching between normal behaviour
> and cow for hard links.  Flag can be changed and queried per fcntl().
> Ext[23] needed a bit of tweaking to write this flag to disk.  open()
> will fail, when a) cowlink flags is set, b) inode has more than one
> link and c) write access is requested.

I like the idea!

I keep many hard-linked kernel trees, and local version management is
done by "cp -rl" to make new trees and then change a few files in
those trees, compile, test etc.  To prevent changes in one tree
accidentally affecting other trees, I "chmod -R a-r" all but the tree
I'm currently working on.

Thats works quite nicely, but it'd be even nicer to not need the
"chmod", and just be confident that writes won't clobber files in
another tree by accident.

-- Jamie
