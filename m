Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVAUGyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVAUGyS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 01:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVAUGyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 01:54:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:44241 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262155AbVAUGx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 01:53:58 -0500
Date: Thu, 20 Jan 2005 22:43:41 -0800
From: Greg KH <greg@kroah.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>
Subject: Re: [PATCH] relayfs redux for 2.6.10: lean and mean
Message-ID: <20050121064341.GC19288@kroah.com>
References: <41EF4E74.2000304@opersys.com> <20050120145046.GF13036@kroah.com> <41F05D11.5020109@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F05D11.5020109@opersys.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 08:38:25PM -0500, Karim Yaghmour wrote:
> 
> Greg KH wrote:
> > Hm, how about this idea for cutting about 500 more lines from the code:
> > 
> > Why not drop the "fs" part of relayfs and just make the code a set of
> > struct file_operations.  That way you could have "relayfs-like" files in
> > any ram based file system that is being used.  Then, a user could use
> > these fops and assorted interface to create debugfs or even procfs files
> > using this type of interface.
> > 
> > As relayfs really is almost the same (conceptually wise) as debugfs as
> > far as concept of what kinds of files will be in there (nothing anyone
> > would ever rely on for normal operations, but for debugging only) this
> > keeps users and developers from having to spread their debugging and
> > instrumenting files from accross two different file systems.
> 
> However this assumes that the users of relayfs are not going to want
> it during normal system operation.

That is true.

> This is an assumption that fails with at least LTT as it is targeted
> at sysadmins, application developers and power users who need to be
> able to trace their systems at any time.

Are they willing to trade off the performance of LTT to get this?  I
thought this was being touted as a "when you need to test" type of
thing, not a "run it all the time" type of feature.

> I don't mind piggy-backing off another fs, if it makes sense, but
> unlike debugfs, relayfs is meant for general use, and all files in there
> are of the same type: relay channels for dumping huge amounts of data
> to user-space.

And a driver will never want to have both a relay channel, and a simple
debug output at the same time?  You are now requiring them to look for
that data in two different points in the fs.

> It seems to me the target audience and basic idea (relay
> channels only in the fs) are different, but let me know if there's a
> compeling argument for doing this in another way without making it too
> confusing for users of those special "files" (IOW, when this starts
> being used in distros, it'll be more straightforward for users to
> understand if all files in a mounted fs behave a certain way than if
> they have certain "odd" files in certain directories, even if it's
> /proc.)

So, since you are proposing that relayfs be mounted all the time, where
do you want to mount it at?  I had to provide a "standard" location for
debugfs for people to be happy with it, and the same issue comes up
here.

Also, why not export your relayfs ops so that someone useing debugfs can
create a relay channel in it, or in any other type of fs they might
create?

thanks,

greg k-h
