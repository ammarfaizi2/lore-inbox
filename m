Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbTDXVWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264455AbTDXVWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:22:22 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:21128 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264451AbTDXVWU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:22:20 -0400
Date: Thu, 24 Apr 2003 22:34:18 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ian Jackson <ijackson@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: rename("a","b") succeeds multiple times race
Message-ID: <20030424213418.GJ30082@mail.jlokier.co.uk>
References: <16039.53523.533498.354359@chiark.greenend.org.uk> <20030424143058.GC23247@spackhandychoptubes.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424143058.GC23247@spackhandychoptubes.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Sykes wrote:
> > I ran the system under strace, and saw (for example) the following, in
> > five straces of five different processes:
> > 
> >  02:11:47.293131 rename("q1988na-000xqY", "proc.1988na-000xqY") = 0
> >  02:11:47.354497 rename("q1988na-000xqY", "proc.1988na-000xqY") = 0
> >  02:11:47.412207 rename("q1988na-000xqY", "proc.1988na-000xqY") = 0
> >  02:11:47.414376 rename("q1988na-000xqY", "proc.1988na-000xqY") = 0
> >  02:11:47.414559 rename("q1988na-000xqY", "proc.1988na-000xqY") = 0
> 
> In rename(2):
> [1] "If  newpath  already exists it will be atomically replaced
>     (subject to a few conditions - see ERRORS below), so  that
>     there  is  no point at which another process attempting to
>     access newpath will find it missing."
> 
>  ...
> 
> [2] "However, when overwriting there will probably be a  window
>     in  which both oldpath and newpath refer to the file being
>     renamed."
> 
> Perhaps your program should link(2) the newpath to the oldpath, then
> on success unlink(2) the oldpath.  link(2) will fail should newpath
> already exist.  Of course this assumes that oldpath & newpath are on
> the same filesystem.

That would be most reliable, and you want to do that in case the
filesystem is NFS, too.  (On the other hand, there are filesystems
that support rename(2) but not link(2)).

However rename(2) should not successfully rename from the _old_ path
more than once, whether the new names are all the same or not.

-- Jamie
