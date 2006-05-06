Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWEFQhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWEFQhl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 12:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWEFQhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 12:37:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39846 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750759AbWEFQhk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 12:37:40 -0400
Date: Sat, 6 May 2006 17:37:37 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Daniel Aragon?s <danarag@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH/RFC] minix filesystem update to V3 diffed to 2.6.17-rc3
Message-ID: <20060506163737.GP27946@ftp.linux.org.uk>
References: <44560796.8010700@gmail.com> <20060506162956.GO27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060506162956.GO27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2006 at 05:29:56PM +0100, Al Viro wrote:
> Ouch...  So you want
> 	1024 => 0
> 	2048 => 1
> 	4096 => 2
> 	8192 => 3
> 	16384 => 4
> 	anything else => junk?
> 
> IOW, you are creating cascade of ifs and shifts instead of
> 	ffs(sb->s_blocksize) - 11
> (ffs(1<<n) == n + 1).  ffs() is far more efficient and readable...

Or, better yet, sb->s_blocksize_bits - 10.  End of story.
