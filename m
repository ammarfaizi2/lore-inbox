Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbVCPEqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbVCPEqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 23:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbVCPEp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 23:45:59 -0500
Received: from sccrmhc14.comcast.net ([204.127.202.59]:7144 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262517AbVCPEpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 23:45:31 -0500
Subject: Re: [PATCH][RFC] /proc umask and gid [was: Make /proc/<pid>
	chmod'able]
From: Albert Cahalan <albert@users.sf.net>
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com, 7eggert@gmx.de
In-Reply-To: <20050316023923.GA27736@lsrfire.ath.cx>
References: <1110771251.1967.84.camel@cube>
	 <20050316023923.GA27736@lsrfire.ath.cx>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 23:31:14 -0500
Message-Id: <1110947475.1967.280.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-16 at 03:39 +0100, Rene Scharfe wrote:
> So, I gather from the feedback I've got that chmod'able /proc/<pid>
> would be a bit over the top. 8-)  While providing the easiest and most
> intuitive user interface for changing the permissions on those
> directories, it is overkill.  Paul is right when he says that such a
> feature should be turned on or off for all sessions at once, and that's
> it.
> 
> My patch had at least one other problem: the contents of eac
> /proc/<pid> directory became chmod'able, too, which was not intended.
> 
> Instead of fixing it up I took two steps back, dusted off the umask
> kernel parameter patch and added the "special gid" feature I mentioned.
> 
> Without the new kernel parameters behaviour is unchanged.  Add
> proc.umask=077 and all /proc/<pid> will get a permission mode of 500.
> This breaks pstree (no output), as Bodo already noted, because this
> program needs access to /proc/1.  It also breaks w -- it shows the
> correct number of users but it lists XXXXX even for sessions owned
> by the user running it.
> 
> Use proc.umask=007 and proc.gid=50 instead and all /proc/<pid> dirs
> will have a mode of 550 and their group attribute will be set to 50
> (that's "staff" on my Debian system).  Pstree will work for all members
> of that special group (just like top, ps and w -- which also show
> everything in that case).  Normal users will still have a restricted
> view.
> 
> Albert, would you take fixes for w even though you despise the feature
> that makes them necessary?

I will take patches if they are not too messy and they do not
cause tools to report garbage output. For example, I do not
wish to have tools reporting -1, 0, or uninitialized data in
place of correct data.

Distinct controls for the various files could be useful.
I might want to make /proc/*/cmdline be public, or make
/proc/*/maps be private. This is particularly helpful if
a low-security file is added for bare-bones ps operation.

You might make a special exception for built-in kernel tasks
and init.


