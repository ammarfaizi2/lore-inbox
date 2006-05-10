Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbWEJXsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbWEJXsv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 19:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWEJXsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 19:48:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49825 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965086AbWEJXsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 19:48:50 -0400
Date: Wed, 10 May 2006 16:45:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: davem@davemloft.net, dwalker@mvista.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Message-Id: <20060510164554.27a13ca9.akpm@osdl.org>
In-Reply-To: <20060510232042.GJ27946@ftp.linux.org.uk>
References: <20060510162106.GC27946@ftp.linux.org.uk>
	<20060510150321.11262b24.akpm@osdl.org>
	<20060510221024.GH27946@ftp.linux.org.uk>
	<20060510.153129.122741274.davem@davemloft.net>
	<20060510224549.GI27946@ftp.linux.org.uk>
	<20060510160548.36e92daf.akpm@osdl.org>
	<20060510232042.GJ27946@ftp.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:
>
> On Wed, May 10, 2006 at 04:05:48PM -0700, Andrew Morton wrote:
> > Sure - it's sad and we need some workaround.
> > 
> > The init_self() thingy seemed reasonable to me - it shuts up the warning
> > and has no runtime cost.  What we could perhaps do is to make
> > 
> > #define init_self(x) (x = x)
> > 
> > only if the problematic gcc versions are detected.  Later, if/when gcc gets
> > fixed up, we use
> 
> Sorry, no - it shuts up too much.  Look, there are two kinds of warnings
> here.  "May be used" and "is used".  This stuff shuts both.  And unlike
> "may be used", "is used" has fairly high S/N ratio.
> 
> Moreover, once you do that, you lose all future "is used" warnings on
> that variable.  So your ability to catch future bugs is decreased, not
> increased.

Only for certain gcc versions.  Other people use other versions, so it'll
be noticed.  If/when gcc gets fixed, more and more people will see the real
warnings.

Look, of course it has problems.  But the current build has problems too. 
It's a question of which problem is worse..
