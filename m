Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVEKADp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVEKADp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 20:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVEKADo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 20:03:44 -0400
Received: from ozlabs.org ([203.10.76.45]:16046 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261850AbVEKABa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 20:01:30 -0400
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <gregkh@suse.de>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050510201355.GB3226@suse.de>
References: <20050506212227.GA24066@kroah.com>
	 <1115611034.14447.11.camel@localhost.localdomain>
	 <20050509232103.GA24238@suse.de>
	 <1115717357.10222.1.camel@localhost.localdomain>
	 <20050510094339.GC6346@wonderland.linux.it> <4280AFF4.6080108@ums.usu.ru>
	 <20050510172447.GA11263@wonderland.linux.it>
	 <20050510201355.GB3226@suse.de>
Content-Type: text/plain
Date: Wed, 11 May 2005 10:01:16 +1000
Message-Id: <1115769676.17201.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 13:13 -0700, Greg KH wrote:
> On Tue, May 10, 2005 at 07:24:47PM +0200, Marco d'Itri wrote:
> > On May 10, "Alexander E. Patrakov" <patrakov@ums.usu.ru> wrote:
> > 
> > > Why not this or something similar (e.g. I want to blacklist the xxx and 
> > > yyy modules)? (note, untested)
> 
> Nice, I like it.
> 
> > Because it's impossible to predict how it will interact with other
> > install and alias commands.
> 
> Then we will just have to find out :)

The interaction of aliases and install commands on the same thing is
deliberately undefined (eg. "alias foo bar // install foo ..." - which
takes priority?), but aliases that lead to install commands like this is
OK.  If not, it's a bug.

The other possible solution is for /etc/hotplug.d/blacklist to contain
"install xxx /bin/false // install yyy /bin/true //
include /etc/modprobe.d" and have hotplug invoke modprobe with
--config=/etc/hotplug.d/blacklist.  Substitute names to fit.

Now, should install commands in included files override install commands
in earlier files?  Again, undefined, but currently they do: in the above
model maybe they shouldn't?  We can nail it down either way...

Thanks,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

