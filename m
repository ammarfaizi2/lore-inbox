Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263614AbUEVBoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbUEVBoh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 21:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUEVBog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 21:44:36 -0400
Received: from ghoul.undead.cc ([216.126.84.18]:3712 "HELO mail.undead.cc")
	by vger.kernel.org with SMTP id S263614AbUEVBiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 21:38:10 -0400
Message-ID: <40AEAEFB.4010005@undead.cc>
Date: Fri, 21 May 2004 21:38:03 -0400
From: John Zielinski <grim@undead.cc>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] sysfs kobject that doesn't trigger hotplug events
References: <40AAC26C.2080803@undead.cc> <20040519033439.GA8160@kroah.com> <40AAE603.1080707@undead.cc> <20040519051612.GA13657@kroah.com>
In-Reply-To: <20040519051612.GA13657@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> So why are you creating a kobject, and not just attributes?
>  

So I could reuse the kobjects reference counting code so that my data 
would get freed once other kernel code no longer referenced it.   It 
would also let me have a more elaborate directory tree instead of just a 
single subdirectory deep as with attribute groups, kind of like what 
Stephen Hemminger wanted to do with his bridge device directory layout.

> What exactly are you wanting to do?  How about we start there.
>  


This is for an embedded project I'm working on but the code may be 
useful once the fbdev guys start expanding their sysfs support.  
Basically I want to expose the fbdev's modedb structures to user space 
and have an interface for manipulating this information.  I'm expanding 
that modedb to also include supported color bit formats, etc.  Trying to 
encode the relationships in the attribute filenames would quickly get 
unmanageable.  That's why I want to have a nice directory layout 
presenting that info.

Now there was a big Holy War (tm) in the fbdev mailing list about 
whether that should be done in kernel space or user space, but for my 
project for simplicity I want in in kernel space and I _believe_ the 
last truce in the fbdev list has it in the kernel as well.  :)

John


