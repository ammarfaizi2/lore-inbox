Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbTKBJh6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 04:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTKBJh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 04:37:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:64964 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261601AbTKBJh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 04:37:57 -0500
Date: Sun, 2 Nov 2003 01:40:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at
 fs/buffer.c:431"
Message-Id: <20031102014011.09001c81.akpm@osdl.org>
In-Reply-To: <20031102092723.GA4964@gondor.apana.org.au>
References: <20031029141931.6c4ebdb5.akpm@osdl.org>
	<E1AGCUJ-00016g-00@gondolin.me.apana.org.au>
	<20031101233354.1f566c80.akpm@osdl.org>
	<20031102092723.GA4964@gondor.apana.org.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Sat, Nov 01, 2003 at 11:33:54PM -0800, Andrew Morton wrote:
> > 
> > aargh.  I thought Debian's 2.6 kernels were unmodified.  Are they carrying
> > any other changes?
> 
> Yes we are.  You can find the changes in
> 
> http://http.us.debian.org/debian/pool/main/k/kernel-source-2.6.0-test9/

Where are the separated patches?

That's 170k of stuff you're sitting on.  Is there any plan to get it synced
up?

> > That _should_ work.  The pagecache pages should be in such a state that all
> > buffers are freeable and yes, we can leave the pagecache there.  But this
> > could cause problems if the device was repartitioned in between, or if it
> > was hotswapped.  I don't think we shoot down pagecache anywhere else for
> > this.
> 
> Yes, however it should be safe to stop set_blocksize from calling
> truncate_inode_pages, right?

No, because _something_ has to rub out the wrong-sized buffer_heads.  One
could add some new function which walks the pagecache and removes the
buffer_heads from the pages, leaving the pages there.  There doesn't seem a
lot of point in it though?


