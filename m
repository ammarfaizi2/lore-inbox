Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbVH2Dzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbVH2Dzs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 23:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbVH2Dzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 23:55:48 -0400
Received: from [218.25.172.144] ([218.25.172.144]:40454 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1750912AbVH2Dzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 23:55:47 -0400
Message-ID: <4312873F.8060006@fc-cn.com>
Date: Mon, 29 Aug 2005 11:55:43 +0800
From: qiyong <qiyong@fc-cn.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
CC: linux-kernel@vger.kernel.org, dhommel@gmail.com
Subject: Re: syscall: sys_promote
References: <20050826092537.GA3416@localhost.localdomain> <20050826124738.GD28640@harddisk-recovery.com>
In-Reply-To: <20050826124738.GD28640@harddisk-recovery.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:

>On Fri, Aug 26, 2005 at 05:25:37PM +0800, Coywolf Qi Hunt wrote:
>  
>
>>I just wrote a tool with kernel patch, which is to set the uid's of a running
>>process without FORK.
>>
>>The tool is at http://users.freeforge.net/~coywolf/pub/promote/
>>Usage: promote <pid> [uid]
>>
>>I once need such a tool to work together with my admin in order to tune my web
>>configuration.  I think it's quite convenient sometimes. 
>>
>>The situations I can image are:
>>
>>1) root processes can be set to normal priorities, to serve web
>>service for eg.
>>    
>>
>
>Most (if not all) web servers can be told to drop all privileges and
>run as a normal user. If not, you can use selinux to create a policy
>for such processes (IIRC that's what Fedora does).
>  
>

In this way, it's that the web servers themselves drop the privileges, 
not forced by sysadmin.  sys_promote is a new approach different from 
selinux or sudo.  sys_promote is manipulating a already running process, 
while selinux or sudo is for the next launching process.

>  
>
>>2) admins promote trusted users, so they can do some system work without knowing
>>   the password
>>    
>>
>
>Use sudo for that, it allows even much finer grained control.
>  
>

sudo may become a security problem.  Sysadmin and the user don't like 
the user's account
always have priorities.  My sysadmin Hommel says this to me:

[quote]

Alan is right, selinux can do things like that, but we don't want to
use selinux for only being able to "promote" root rights for some
simple job. To me it's more like a "one time sudo", and i consider it
generally useful on systems like zeus. Without the promote tool i'd
have to change some major parts in the system (implementing selinux
e.g.) or give permanent sudo/root permissions to a user.

[/quote]


>  
>
>>3) admins can `promote' a suspect process instead of killing it.
>>    
>>
>
>Why would that change anything? You only change a process's UID,
>nothing else. You don't change things like resource limits, so a
>process started as root with unlimited limits is still allowed to use
>those limits. AFAIK setrlimit() can't be used to change resource limits
>of other processes.
>
>
>Erik
>
>  
>

