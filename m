Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423950AbWKAImi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423950AbWKAImi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 03:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423952AbWKAImi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 03:42:38 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:49606 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1423950AbWKAImh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 03:42:37 -0500
Date: Wed, 1 Nov 2006 08:42:34 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH] dont insert sockets/pipes dentries into dentry_hashtable.
Message-ID: <20061101084234.GT29920@ftp.linux.org.uk>
References: <20061025084726.GE18364@nuim.ie> <20061025.230615.92585270.davem@davemloft.net> <200610311948.48970.dada1@cosmosbay.com> <20061031.231954.23010447.davem@davemloft.net> <454858F2.5020206@cosmosbay.com> <20061101083811.GS29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101083811.GS29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 08:38:11AM +0000, Al Viro wrote:
> On Wed, Nov 01, 2006 at 09:21:06AM +0100, Eric Dumazet wrote:
> 
> > And " (deleted)" is correctly added to deleted files.
> 
> The hell it will.
> 
> touch a
> touch b
> exec 5<a
> mv b a
> ls -l /proc/$$/fd/5
> 
> With your patch and without it, please.

While we are at it,

touch a
rm a
touch a
ls -l /proc/self/fd/0 <a

With and without your patch.  Note that you never remove DCACHE_DELETED
after you've set it.
