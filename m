Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVEKBJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVEKBJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 21:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVEKBJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 21:09:36 -0400
Received: from ozlabs.org ([203.10.76.45]:18096 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261868AbVEKBJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 21:09:28 -0400
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Marco d'Itri" <md@Linux.IT>
Cc: Greg KH <gregkh@suse.de>, "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050511001056.GB17762@wonderland.linux.it>
References: <20050506212227.GA24066@kroah.com>
	 <1115611034.14447.11.camel@localhost.localdomain>
	 <20050509232103.GA24238@suse.de>
	 <1115717357.10222.1.camel@localhost.localdomain>
	 <20050510094339.GC6346@wonderland.linux.it> <4280AFF4.6080108@ums.usu.ru>
	 <20050510172447.GA11263@wonderland.linux.it>
	 <20050510201355.GB3226@suse.de>
	 <1115769676.17201.14.camel@localhost.localdomain>
	 <20050511001056.GB17762@wonderland.linux.it>
Content-Type: text/plain
Date: Wed, 11 May 2005 11:09:14 +1000
Message-Id: <1115773754.17201.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-11 at 02:10 +0200, Marco d'Itri wrote:
> On May 11, Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > The other possible solution is for /etc/hotplug.d/blacklist to contain
> > "install xxx /bin/false // install yyy /bin/true //
> > include /etc/modprobe.d" and have hotplug invoke modprobe with
> > --config=/etc/hotplug.d/blacklist.  Substitute names to fit.

> I understand that this modprobe would look for an alias or install
> directive for $MODALIAS, while it's the actual module name which users
> need to blacklist (but I know a few situations in which it would be
> useful to be able to match $MODALIAS on the blacklist too...).

Yes, I'm assuming that the config file/dir used by hotplug would simply
look like:

	# Install commands so hotplug doesn't load some modules.
	# Use /bin/true so modprobe doesn't complain.

	# evbug is a debug tool and should be loaded explicitly
	install evbug /bin/true

To blacklist by aliases, you could use install commands (which, again
undefined, are actually implemented to override alias commands):

	# hotplug thinks that the XYZ driver is great for this card.
	# But that modprobe causes uncomfortable nasal daemons.
	install pci:v1d1dc0sd0bc10sc10i1 /bin/hotplug-warning

If that becomes important, I can document that behaviour and add a test
case for it.

Thanks!
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

