Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263798AbUESFQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbUESFQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 01:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbUESFQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 01:16:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:19098 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263798AbUESFQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 01:16:51 -0400
Date: Tue, 18 May 2004 22:16:12 -0700
From: Greg KH <greg@kroah.com>
To: John Zielinski <grim@undead.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] sysfs kobject that doesn't trigger hotplug events
Message-ID: <20040519051612.GA13657@kroah.com>
References: <40AAC26C.2080803@undead.cc> <20040519033439.GA8160@kroah.com> <40AAE603.1080707@undead.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40AAE603.1080707@undead.cc>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 12:43:47AM -0400, John Zielinski wrote:
> Greg KH wrote:
> 
> >Your patch is not needed at all.  Please read the first comment in the
> >kobject_hotplug() function to see how to prevent kobjects from creating
> >hotplug events.
> > 
> >
> 
> You mean this one?
> 
> /* If this kobj does not belong to a kset, try to find a parent that does */

Oops, sorry, I meant the one in kset_hotplug() which is called by
kobject_hotplug() that says:
		/* If the kset has a filter operation, call it. If it
		 * returns failure, no hotplug event is required. */


> The problem I saw with that is even though my kobject won't have a kset, 
> my kobject's parent (or grandparent) may and I'll trigger that one.  I'm 
> not creating a new device  driver, just extending one so I won't have 
> control over that kobject's lineage.

So why are you creating a kobject, and not just attributes?

> The other way is to create a subsystem using subsytem_init but not to 
> add it to the sysfs tree and then add my kobject to that kset and use 
> the kset's hotplug filter to stop the hotplug events.  This would 
> require extra code and a little bit more memory usage for that kset, but 
> I believe that would work.  Any drawbacks to this method?
> 
> Or am I missing something?

What exactly are you wanting to do?  How about we start there.

thanks,

greg k-h
