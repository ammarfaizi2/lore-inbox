Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270686AbTGUTBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270687AbTGUTBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:01:17 -0400
Received: from netrealtor.ca ([216.209.85.42]:51218 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S270686AbTGUTBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:01:13 -0400
Date: Mon, 21 Jul 2003 15:16:02 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: RAMON_GARCIA_F <RAMON_GARCIA_F@terra.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suggestion for a new system call: convert file handle to a cookie for transfering file handles between processes.
Message-ID: <20030721191602.GB16814@mark.mielke.cc>
References: <5f3d05a5f5.5a5f55f3d0@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f3d05a5f5.5a5f55f3d0@teleline.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What part of this cannot be implemented from user space using unix sockets?

Consider that an implementing using a user space daemon and unix sockets
would be portable to any system that implemented either ioctl(I_SENDFD)
or cmsg(SCM_CREDENTIALS). The former should function properly on all
operating systems that fully implements streamio support, such as Solaris
and HP-UX.

Your proposed solution unnecessary complicates the kernel, and ensures
that the feature cannot be used on any other platform except Linux, and
even then, only versions of Linux that include your patch.

Why restrict yourself like this?

mark


On Mon, Jul 21, 2003 at 06:55:24PM +0200, RAMON_GARCIA_F wrote:
> My proposal is useful for cases where the server program is running with
> a different priviledge from the user invoking it. Examples where this
> behaviour is useful are writting CDs, saving man pages, saving TeX cache
> files, where full access to a resource would be unsafe, but limited
> access through an intermediate server is safe.
> 
> In addition, this proposal is useful for cases where the server process
> cannot access the named file, becaue it does not have permission to do
> so, or because it is anonymous (example: a pipe).
> 
> I can't see why cookies introduce circular references. A cookie referes
> to an inode, but an inode does not refer to a file.
> 
> However, a cookie introduces a permanent reference to a file handle.
> This reference is not destroyed until the cookie is used. Therefore,
> cookies should have a timeout associated with them, so that if they
> are not consumed they should be destroyed.
> 
> Ramon
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

