Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWDXVZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWDXVZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWDXVZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:25:35 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:18879 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751302AbWDXVYx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:24:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ft827kx/CwSAOByutHiJgJbOWYY1yL8DdhI27HmLnL1ANM03N5wzjUqB8FSYooAW8d1lOanlvNzCuBvQMwS8Blw+yy0u4+S/aUhqIrvpKDOymnlQZ/eSpAxuDNgEcUiLOKnQzI98564WWcsoEBEeIRzV6ZPBuJBZsj8drtFjF9o=
Message-ID: <bda6d13a0604241424r503d1b87jb44d1df1a11feb3b@mail.gmail.com>
Date: Mon, 24 Apr 2006 14:24:47 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: Filesystem & mutex
In-Reply-To: <84144f020604240419w190d03cdld53432da8df6277b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bda6d13a0604232154r28f23212o55b15a065fe6d648@mail.gmail.com>
	 <84144f020604240419w190d03cdld53432da8df6277b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> Hi,
>
> On 4/24/06, Joshua Hudson <joshudson@gmail.com> wrote:
> > My filesystem has need of an extra mutex in the extended inode data area.
> > From what I understand, the mutex can be initalized in inode_init_once, but
> > I cannot determine how to free it.
> >
> > It looks wrong to destroy the mutex by just destroying the slab.
> > It is wrong to destroy the inode in destroy_inode. Badness when
> > an inode is reused.
>
> There's no need to 'release' a mutex. If the mutex is unlocked, you
> can do kmem_cache_free() on the owning inode. You need to do
> mutex_init() in the object cache constructor (init_once) only because
> the memory given to you can be arbitrary state. After the mutex has
> been initialized, it will never go into an illegal state on its own
> assuming you remember to unlock it before freeing the inode.
>
>                                             Pekka
Tx. Your solution worked.
