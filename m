Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268191AbUHFRc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268191AbUHFRc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268227AbUHFRbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:31:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10924 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268191AbUHFRZq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:25:46 -0400
Date: Fri, 6 Aug 2004 18:23:23 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: d_path errors
Message-ID: <20040806172321.GR12308@parcelfarce.linux.theplanet.co.uk>
References: <20040806152356.GD2514@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806152356.GD2514@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 05:23:56PM +0200, Andrea Arcangeli wrote:
 
> on a slightly different topic, Al, could you suggest how to hack d_path
> so that it provides an absolute path with respect to the init_task root
> directory?

Simple: you don't.
	a) filesystem may be mounted more than once in init_task's namespace
	b) filesystem may be not mounted there at all.
	c) different subtrees of filessytem might be mounted there and
full tree might be not among them; your file might be covered by some of
them.

What you are asking for is about as feasible as "I have an unlinked file.
Show me a pathname of existing link to it".  The best answer will be
along the lines of "use find(1) if you are that desperate".  And if
vfsmount/dentry did *not* give you an absolute pathname, you are in
situation equivalent to that.

No way in hell it's getting shoved in d_path() and I'm very sceptical
about any code that really needs that.
