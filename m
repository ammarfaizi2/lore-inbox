Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264800AbUEVBYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264800AbUEVBYx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 21:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264879AbUEVBWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 21:22:01 -0400
Received: from mail.undead.cc ([216.126.84.18]:3456 "HELO mail.undead.cc")
	by vger.kernel.org with SMTP id S264800AbUEVBUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 21:20:17 -0400
Message-ID: <40AD592A.2070303@undead.cc>
Date: Thu, 20 May 2004 21:19:38 -0400
From: John Zielinski <grim@undead.cc>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] sysfs kobject that doesn't trigger hotplug events
References: <40AAC26C.2080803@undead.cc> <200405182218.20987.dtor_core@ameritech.net>
In-Reply-To: <200405182218.20987.dtor_core@ameritech.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

> You are wasting 4 bytes for every kobject out there. Just implement your
> private hotplug callback that would return something like -ENODEV so the
> hotplug helper would not be called. If needed you can call 
> kobject_hotplug
> later, when you are ready. 



Actually for every kobj_type structure, not for every kobject.  Doing a 
quick scan through the kernel I found 25 kobj_type decelerations so that 
would add up to 100 bytes only.  And that could be made a byte or flags 
field.

I wasn't sure if it was possible to create a subsystem that wasn't a 
part of the sysfs tree that contained kobjects that were.  Looking 
trough the code again it looks like it is so I'll use the hotplug filter 
as you suggest.

John


