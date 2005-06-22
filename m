Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262463AbVFVBVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVFVBVu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 21:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVFVBVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 21:21:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65258 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262463AbVFVBVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 21:21:42 -0400
Date: Tue, 21 Jun 2005 18:18:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: hch@infradead.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
Message-Id: <20050621181802.11a792cc.akpm@osdl.org>
In-Reply-To: <42B8B9EE.7020002@namesys.com>
References: <20050620235458.5b437274.akpm@osdl.org>
	<42B831B4.9020603@pobox.com>
	<42B87318.80607@namesys.com>
	<20050621202448.GB30182@infradead.org>
	<42B8B9EE.7020002@namesys.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
> What is wrong with having an encryption plugin implemented in this
>  manner?  What is wrong with being able to have some files implemented
>  using a compression plugin, and others in the same filesystem not.
> 
>  What is wrong with having one file in the FS use a write only plugin, in
>  which the encrypion key is changed with every append in a forward but
>  not backward computable manner, and in order to read a file you must
>  either have a key that is stored on another computer or be reading what
>  was written after the moment of cracking root?
> 
>  What is wrong with having a set of critical data files use a CRC
>  checking file plugin?

I think the concern here is that this is implemented at the wrong level.

In Linux, a filesystem is some dumb thing which implements
address_space_operations, filesystem_operations, etc.

Advanced features such as those which you describe are implemented on top
of the filesystem, not within it.  reiser4 turns it all upside down.

Now, some of the features which you envision are not amenable to
above-the-fs implementations.  But some will be, and that's where we should
implement those.

