Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbTDKWcy (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbTDKWcy (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:32:54 -0400
Received: from [209.195.52.120] ([209.195.52.120]:8343 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261942AbTDKWcj (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 18:32:39 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Steven Dake <sdake@mvista.com>
Cc: Greg KH <greg@kroah.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Jeremy Jackson'" <jerj@coplanar.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-hotplug-devel@lists.sourceforge.net'" 
	<linux-hotplug-devel@lists.sourceforge.net>
Date: Fri, 11 Apr 2003 15:41:13 -0700 (PDT)
Subject: Re: [ANNOUNCE] udev 0.1 release
In-Reply-To: <3E974299.3030701@mvista.com>
Message-ID: <Pine.LNX.4.44.0304111537560.8422-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you can only do this if you use a virtual directory for dev, otherwise you
have to do something like scanning /dev at shutdown and storing the
result (this was the famous devfs tar archive of permission issue)

you really ahve two situations.

1. a virtual filesystem for /dev.

  this lets you notice all changes to anything in /dev and store it
apropriatly

2. a real filesystem for /dev with a userspace daemon to update it.

  this involves the kernel less, but unless you can convince people to
stop managing their devices the old way you have the problem of missing
changes

David Lang

 On Fri, 11 Apr 2003, Steven Dake wrote:

> Date: Fri, 11 Apr 2003 15:32:57 -0700
> From: Steven Dake <sdake@mvista.com>
> To: Greg KH <greg@kroah.com>
> Cc: David Lang <david.lang@digitalinsight.com>,
>      "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
>      'Jeremy Jackson' <jerj@coplanar.net>,
>      "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
>      "'linux-hotplug-devel@lists.sourceforge.net'"
>     <linux-hotplug-devel@lists.sourceforge.net>
> Subject: Re: [ANNOUNCE] udev 0.1 release
>
>
>
> Greg KH wrote:
>
> >On Fri, Apr 11, 2003 at 01:48:17PM -0700, David Lang wrote:
> >
> >
> >>ant then you also have all the same problems as devfs about default
> >>permissions, making permissions persistant across reboots, etc.
> >>
> >>
> >
> >You can store the default permissions in the database you use to store
> >the naming data.  This solves the reboot problem, as long as you can
> >convince people to not modify the permissions on their own (well even if
> >they do, at shutdown, you can always validate that they are the same
> >before you clean up the node.)
> >
> >And provide an easy way for users to change the permissions so they show
> >up in the database.
> >
> >devchmod and devchown anyone?  :)
> >
> >
> Greg,
>
> I've been thinking of how to solve this particular problem, and believe
> you could use dnotify in a daemon to track permission and ownership
> changes and store them in a backing database.  In fact, we do something
> similiar to this today.  This allows the user to use any type of
> application for changing permissions/owners, even syscalls directly
> without having to go "through" any sort of tracking database.
>
> >thanks,
> >
> >greg k-h
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> >
> >
> >
>
