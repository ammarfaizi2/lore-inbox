Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbVJNCLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbVJNCLL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 22:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVJNCLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 22:11:10 -0400
Received: from smtp-out.google.com ([216.239.45.12]:60489 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932564AbVJNCLJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 22:11:09 -0400
Message-ID: <434F13A7.8090608@google.com>
Date: Thu, 13 Oct 2005 19:10:47 -0700
From: Mike Waychison <mikew@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ram <linuxram@us.ibm.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, leimy2k@gmail.com
Subject: Re: /etc/mtab and per-process namespaces
References: <3e1162e60510021508r6ef8e802p9f01f40fcf62faae@mail.gmail.com> <3e1162e60510041214t3afd803re27b742705d27900@mail.gmail.com> <20051005162948.GA25162@RAM>
In-Reply-To: <20051005162948.GA25162@RAM>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:
> On Tue, Oct 04, 2005 at 12:14:47PM -0700, David Leimbach wrote:
> 
>>Hmm no responses on this thread a couple days now.  I guess:
>>
>>1) No one cares about private namespaces or the fact that they make
>>/etc/mtab totally inconsistent.
>>2) Private Namespaces aren't important to anyone and will never be
>>robust unless someone who cares, like me, takes it over somehow.
>>3) Everyone is busy with their own shit and doesn't want to deal with
>>me or mine right now.
>>
>>I'm seriously hoping it's 3 :).  2 Is acceptable too of course.  I
>>think this is important and I want to know more about the innards
>>anyway.  1 would make me sad as I think Linux can really show other
>>Unix's what-for here when it comes to showing off how good the VFS can
>>be.
> 
> 
> This becomes even more intresting when sharedsubtree gets added to 
> the equation. One would like to know all the mounts in its namesapace
> and than all the mounts it propagates to which could include mounts in 
> other namespaces too..
> 
> I guess some interface that meets the following needs would eventually
> be needed:
> 
> 1. what are all the mounts in  my namespace ?
> 	A. what are the attributes of each of the mounts?
> 		a. where is it mounted
> 		b. who is its parent  
> 		c. what is it mounted from
> 		d. what are the attributes of its mount
> 		e. what are its peer mounts (I suspect some kind 
> 					of identifier has
> 					to be associated with each mount)
> 		f. if it has a master mount where is it
> 		g. what are its slave mounts.at
> 		(note: e, f, g can point to mounts in other namespaces)
> 2. what are the attributes of my namespace?
> 	a. what is the parent namespace? ( I suspect some kind 
> 			of identifier has to associated 
> 			with each namespace, pid of the cloned
> 			process?)
> 	b. what are my children namespace?
> 
> 3. which processes can access my namespace?
> 
> 
> And I don't think /etc/mtab can do a decent job with this, because it
> would not know where all the mounts propagate, when it attempts a mount.
> Only the kernel would know, and hence all the commands who depend on
> /etc/mtab may have to depend on some /proc or maybe /sysfs interface to
> do a descent job.
> 

Or,  you bite the bullet and fix /proc/mounts and let distributions bind 
mount /proc/mounts over /etc/mtab.

Sun recognized this as a problem a long time ago and /etc/mnttab has 
been magic for quite some time now.

Add to this the fact that a textfile /etc/mtab is busted because it's 
whitespace seperated and pieces blows up and you do things like:

mount filer:/export/mikew "/home/Mike Waychison"

Mike Waychison
