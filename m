Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWANOBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWANOBd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWANOBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:01:33 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:31880 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751242AbWANOBc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:01:32 -0500
Date: Sat, 14 Jan 2006 14:01:22 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: "P. Christeas" <p_christ@hol.gr>, hch@lst.de, linux-kernel@vger.kernel.org,
       raven@themaw.net
Subject: Re: Regression in Autofs, 2.6.15-git
Message-ID: <20060114140122.GK27946@ftp.linux.org.uk>
References: <200601140217.56724.p_christ@hol.gr> <200601141350.31033.p_christ@hol.gr> <20060114035456.3f50b0d8.akpm@osdl.org> <200601141456.55530.p_christ@hol.gr> <20060114051737.6e49dffe.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114051737.6e49dffe.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 05:17:37AM -0800, Andrew Morton wrote:
> You oopsed accessing 0x00000030, and offsetof(super_block, s_flags) is
> 0x30.  So autofs4 has passed in a dentry which has a NULL
> dentry->d_inode->i_sb and the new code didn't expect that.
 
It's not just new code...  inode->i_sb should _never_ be NULL, period.
We set it immediately after memory had been allocated by alloc_inode()
and never modify afterwards, let alone reset to NULL.
