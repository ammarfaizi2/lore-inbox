Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263788AbUESEnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbUESEnu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 00:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUESEnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 00:43:50 -0400
Received: from ns2.undead.cc ([216.126.84.18]:14209 "HELO mail.undead.cc")
	by vger.kernel.org with SMTP id S263788AbUESEns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 00:43:48 -0400
Message-ID: <40AAE603.1080707@undead.cc>
Date: Wed, 19 May 2004 00:43:47 -0400
From: John Zielinski <grim@undead.cc>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] sysfs kobject that doesn't trigger hotplug events
References: <40AAC26C.2080803@undead.cc> <20040519033439.GA8160@kroah.com>
In-Reply-To: <20040519033439.GA8160@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>Your patch is not needed at all.  Please read the first comment in the
>kobject_hotplug() function to see how to prevent kobjects from creating
>hotplug events.
>  
>

You mean this one?

/* If this kobj does not belong to a kset, try to find a parent that does */

The problem I saw with that is even though my kobject won't have a kset, 
my kobject's parent (or grandparent) may and I'll trigger that one.  I'm 
not creating a new device  driver, just extending one so I won't have 
control over that kobject's lineage.

The other way is to create a subsystem using subsytem_init but not to 
add it to the sysfs tree and then add my kobject to that kset and use 
the kset's hotplug filter to stop the hotplug events.  This would 
require extra code and a little bit more memory usage for that kset, but 
I believe that would work.  Any drawbacks to this method?

Or am I missing something?

John


