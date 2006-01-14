Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751531AbWANO3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbWANO3L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbWANO3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:29:11 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:65287 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751526AbWANO3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:29:10 -0500
Date: Sat, 14 Jan 2006 22:28:07 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, "P. Christeas" <p_christ@hol.gr>,
       hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: Regression in Autofs, 2.6.15-git
In-Reply-To: <20060114140122.GK27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0601142225580.2593@eagle.themaw.net>
References: <200601140217.56724.p_christ@hol.gr> <200601141350.31033.p_christ@hol.gr>
 <20060114035456.3f50b0d8.akpm@osdl.org> <200601141456.55530.p_christ@hol.gr>
 <20060114051737.6e49dffe.akpm@osdl.org> <20060114140122.GK27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2006, Al Viro wrote:

> On Sat, Jan 14, 2006 at 05:17:37AM -0800, Andrew Morton wrote:
> > You oopsed accessing 0x00000030, and offsetof(super_block, s_flags) is
> > 0x30.  So autofs4 has passed in a dentry which has a NULL
> > dentry->d_inode->i_sb and the new code didn't expect that.
>  
> It's not just new code...  inode->i_sb should _never_ be NULL, period.
> We set it immediately after memory had been allocated by alloc_inode()
> and never modify afterwards, let alone reset to NULL.
> 

I don't do such things in the autofs4 module either.
I'm puzzled by this?

Ian

