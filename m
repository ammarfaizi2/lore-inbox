Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVD3Qop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVD3Qop (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 12:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVD3Qn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 12:43:29 -0400
Received: from mail.shareable.org ([81.29.64.88]:51627 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261286AbVD3QnJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 12:43:09 -0400
Date: Sat, 30 Apr 2005 17:42:58 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050430164258.GA6498@mail.shareable.org>
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <E1DPofK-0000Yu-00@localhost> <20050425071047.GA13975@vagabond> <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu> <20050430083516.GC23253@infradead.org> <E1DRoDm-0002G9-00@dorka.pomaz.szeredi.hu> <20050430094218.GA32679@mail.shareable.org> <E1DRoz9-0002JL-00@dorka.pomaz.szeredi.hu> <20050430143609.GA4362@mail.shareable.org> <E1DRuNU-0002el-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DRuNU-0002el-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > Actually, in terms of complexity, it's not much different from using
> > bind mounts.
> 
> As has been suggested by Pavel, bind mounting foreign namespaces could
> just be done with a new bind_fd(fd, path) syscall and file descriptor
> passing with SCM_RIGHTS.

Yes, he's right.

But you don't need a new system call to bind an fd.

"mount --bind /proc/self/fd/N mount_point" works, try it.

> That sounds to me orders of magnitude less complex (on the kernel side
> at least) than sb sharing.

In terms of what happens in the kernel, they're almost exactly the
same: either way, a super block ends up shared by two mounts.  That's
what I meant.

I agree that in terms of what userspace has to do, if just binding
works that's simpler.  And it does seem to work with the above mount
command.

-- Jamie
