Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263763AbUESFQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbUESFQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 01:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbUESFQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 01:16:26 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:50532 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263763AbUESFQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 01:16:24 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] sysfs kobject that doesn't trigger hotplug events
Date: Tue, 18 May 2004 22:18:19 -0500
User-Agent: KMail/1.6.2
Cc: John Zielinski <grim@undead.cc>
References: <40AAC26C.2080803@undead.cc>
In-Reply-To: <40AAC26C.2080803@undead.cc>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200405182218.20987.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 May 2004 09:11 pm, John Zielinski wrote:
> I'm adding some data structures to a device and want them to appear 
> under that device in sysfs in subdirectories.  These data structures are 
> linked together in a tree like layout so it would make sense to have 
> them have a subdirectory tree representing them.  These data structures 
> have a kobject for reference counting and I can use kobject_add and 
> kobject_del to add them to the sysfs tree.
> 
> Looking through the kobject.c code I noticed that this would create a 
> lot of hotplug events which would burn up a bit of processor time.  
> These events are not necessary as these are not device kobjects.  I've 
> enclosed a patch to my solution for this.  I'd like to know if there are 
> any side effects with this method.
> 

You are wasting 4 bytes for every kobject out there. Just implement your
private hotplug callback that would return something like -ENODEV so the
hotplug helper would not be called. If needed you can call kobject_hotplug
later, when you are ready. 

-- 
Dmitry
