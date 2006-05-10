Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbWEJXUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbWEJXUs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 19:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWEJXUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 19:20:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53938 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965070AbWEJXUr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 19:20:47 -0400
Date: Thu, 11 May 2006 00:20:42 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: davem@davemloft.net, dwalker@mvista.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Message-ID: <20060510232042.GJ27946@ftp.linux.org.uk>
References: <20060510162106.GC27946@ftp.linux.org.uk> <20060510150321.11262b24.akpm@osdl.org> <20060510221024.GH27946@ftp.linux.org.uk> <20060510.153129.122741274.davem@davemloft.net> <20060510224549.GI27946@ftp.linux.org.uk> <20060510160548.36e92daf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510160548.36e92daf.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 04:05:48PM -0700, Andrew Morton wrote:
> Sure - it's sad and we need some workaround.
> 
> The init_self() thingy seemed reasonable to me - it shuts up the warning
> and has no runtime cost.  What we could perhaps do is to make
> 
> #define init_self(x) (x = x)
> 
> only if the problematic gcc versions are detected.  Later, if/when gcc gets
> fixed up, we use

Sorry, no - it shuts up too much.  Look, there are two kinds of warnings
here.  "May be used" and "is used".  This stuff shuts both.  And unlike
"may be used", "is used" has fairly high S/N ratio.

Moreover, once you do that, you lose all future "is used" warnings on
that variable.  So your ability to catch future bugs is decreased, not
increased.
