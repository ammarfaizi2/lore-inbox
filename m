Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbUKOWgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUKOWgn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 17:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbUKOWgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 17:36:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:33935 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261440AbUKOWfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 17:35:25 -0500
Date: Mon, 15 Nov 2004 14:35:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
In-Reply-To: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Nov 2004, Miklos Szeredi wrote:
> 
> Please consider adding the FUSE filesystem to the mainline kernel.

Quite frankly I think it's too messy.

I'd like FUSE a whole lot more if it _only_ did the general page cache 
reading, but it seems to do a whole lot more, most of it broken.

In other words, I think it's fundamentally wrong to not have a special
"fuse_file_read". If it isn't just "generic_file_read()" (possibly
together with a re-validation callback but even that is very debatable 
indeed) there's something wrong with it imho.

The code looks like it was started before the page cache was all done, and 
nobody ever cleaned it up to use the full VFS power - or for some suspect 
reason decided that they wanted to support insane filesystems.

Together with removing the 2.4.x code and sending a real patch that has 
the cleanups, and maybe I'd reconsider.

		Linus
