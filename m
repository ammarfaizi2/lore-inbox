Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbWEJXJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWEJXJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 19:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbWEJXJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 19:09:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39060 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965068AbWEJXJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 19:09:10 -0400
Date: Wed, 10 May 2006 16:05:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: davem@davemloft.net, dwalker@mvista.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Message-Id: <20060510160548.36e92daf.akpm@osdl.org>
In-Reply-To: <20060510224549.GI27946@ftp.linux.org.uk>
References: <20060510162106.GC27946@ftp.linux.org.uk>
	<20060510150321.11262b24.akpm@osdl.org>
	<20060510221024.GH27946@ftp.linux.org.uk>
	<20060510.153129.122741274.davem@davemloft.net>
	<20060510224549.GI27946@ftp.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:
>
> On Wed, May 10, 2006 at 03:31:29PM -0700, David S. Miller wrote:
> > From: Al Viro <viro@ftp.linux.org.uk>
> > Date: Wed, 10 May 2006 23:10:24 +0100
> > 
> > > But that's the argument in favour of using diff, not shutting the
> > > bogus warnings up...
> > 
> > IMHO, the tree should build with -Werror without exception.
> > Once you have that basis, new ones will not show up easily
> > and the hard part of the battle has been won.
> > 
> > Yes, people will post a lot of bogus versions of warning fixes, but
> > we're already good at flaming those off already :-)
> 
> Alternatively, gcc could get saner.  Seriously, some very common patterns
> trigger that shit - e.g. function that returns error or 0 and stores
> value to *pointer_argument in case of success.  It's a clear regression
> in 4.x and IMO should be treated as gcc bug.

Sure - it's sad and we need some workaround.

The init_self() thingy seemed reasonable to me - it shuts up the warning
and has no runtime cost.  What we could perhaps do is to make

#define init_self(x) (x = x)

only if the problematic gcc versions are detected.  Later, if/when gcc gets
fixed up, we use

#define init_self(x)	x

Or something.  Probably a more specific name than "init_self" is needed in
this case - something that indicates that it's a specific workaround for
specific gcc versions.

