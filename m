Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVDDOWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVDDOWx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 10:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVDDOWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 10:22:53 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:32649 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S261244AbVDDOWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 10:22:45 -0400
Subject: Re: [PATCH] Fix SELinux for removal of i_sock
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "David S. Miller" <davem@davemloft.net>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       matthew@wil.cx
In-Reply-To: <20050401123520.7532528b.davem@davemloft.net>
References: <1112385997.14481.192.camel@moss-spartans.epoch.ncsc.mil>
	 <20050401123520.7532528b.davem@davemloft.net>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 04 Apr 2005 10:13:53 -0400
Message-Id: <1112624033.7629.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-14) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-01 at 12:35 -0800, David S. Miller wrote:
> On Fri, 01 Apr 2005 15:06:37 -0500
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > This patch against -bk eliminates the use of i_sock by SELinux as it
> > appears to have been removed recently, breaking the build of SELinux in
> > -bk.  Simply replacing the i_sock test with an S_ISSOCK test would be
> > unsafe in the SELinux code, as the latter will also return true for the
> > inodes of socket files in the filesystem, not just the actual socket
> > objects IIUC.  Hence this patch reworks the SELinux code to avoid the
> > need to apply such a test in the first place, part of which was
> > obsoleted anyway by earlier changes to SELinux.  Please apply.
> > 
> > Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
> > Signed-off-by:  James Morris <jmorris@redhat.com>
> 
> Applied, thanks Stephen.

So, just for clarification, since a S_ISSOCK test is not necessarily
equivalent to an i_sock test (in the case of inodes of socket files in
the filesystem), was removing i_sock truly the right choice?  It may not
be an issue for typical users of i_sock since you can't open a
descriptor to such a socket file, so any code that was acting on an open
file shouldn't have to deal with this ambiguity, but could possibly lead
to an erroneous use of SOCKET_I on the inode of a socket file in other
code (which is what would have happened in SELinux if we had just
changed the i_sock test to an ISSOCK test).  Thanks, just trying to
avoid confusion in the kernel in the future...
  
-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

