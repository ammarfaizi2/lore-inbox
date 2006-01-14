Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWANOFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWANOFc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWANOFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:05:32 -0500
Received: from [62.38.115.213] ([62.38.115.213]:60565 "EHLO pfn3.pefnos")
	by vger.kernel.org with ESMTP id S1751465AbWANOFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:05:31 -0500
From: "P. Christeas" <p_christ@hol.gr>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Regression in Autofs, 2.6.15-git
Date: Sat, 14 Jan 2006 16:05:09 +0200
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>, hch@lst.de, linux-kernel@vger.kernel.org,
       raven@themaw.net
References: <200601140217.56724.p_christ@hol.gr> <20060114051737.6e49dffe.akpm@osdl.org> <20060114140122.GK27946@ftp.linux.org.uk>
In-Reply-To: <20060114140122.GK27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601141605.12355.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 January 2006 4:01 pm, Al Viro wrote:
> On Sat, Jan 14, 2006 at 05:17:37AM -0800, Andrew Morton wrote:
> > You oopsed accessing 0x00000030, and offsetof(super_block, s_flags) is
> > 0x30.  So autofs4 has passed in a dentry which has a NULL
> > dentry->d_inode->i_sb and the new code didn't expect that.
>
> It's not just new code...  inode->i_sb should _never_ be NULL, period.
> We set it immediately after memory had been allocated by alloc_inode()
> and never modify afterwards, let alone reset to NULL.

Andrew's fix didn't work, so I'm seeking it further..
