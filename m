Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752491AbWCQBYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbWCQBYm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 20:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbWCQBYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 20:24:42 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:27066 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752491AbWCQBYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 20:24:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XMHr3Q7bGufk+/j18MnGdjgnULhhnSx8WvaP2DOzNuPVClJCxkBzSRISMeLzIehDo9MeqwzZuJz+DnVuh+PRxBwYuJHjvTCF6BsgwkBlZi7Fe5bLWOwkUnwz7LGDkCzsm+Gx8WHAJHOMC7eCa2jVvA63+8HXaZP2Y4T56ttxfKw=
Message-ID: <441A1005.8090709@gmail.com>
Date: Fri, 17 Mar 2006 09:25:25 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.16-rc6-m1 PATCH] Connector: Filesystem Events Connector
 try 2
References: <44198795.2080407@gmail.com> <20060316155801.298e7e9e.akpm@osdl.org>
In-Reply-To: <20060316155801.298e7e9e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Yi Yang <yang.y.yi@gmail.com> wrote:
>   
>> This new patch is update for last patch, it removes spinlock and
>> makes include/linux/fsnotify.h more clean when CONFIG_FS_EVENTS=n,
>> it also reformats some too long lines so that they are less than 80
>> columns.
>>
>> This patch implements a new connector, Filesystem Event Connector,
>>  the user can monitor filesystem activities via it, currently, it
>>  can monitor access, attribute change, open, create, modify, delete,
>>  move and close of any file or directory.
>>
>> Every filesystem event will include tgid, uid and gid of the process
>>  which triggered this event, process name, file or directory name 
>> operated by it.
>>     
>
> That would seem to have some privacy implications...
>
> I'd expect that all the info which is needed can be obtained via syscall
> auditing.
>   
Yes, but if enabling syscall audit, all the syscalls will be audited, so 
every syscall will add overhead, moreover
, it will not only send log to klog or system log, but also it will send 
netlink message.

Filesystem events connector is very simple functionally, it just focuses 
on filesystem activities. Process Events
 Connector(cn_proc) is a very typical case.
> I don't recall having seen demand for this feature before.  For what reason
> is it needed?  What is the application?
>   
Anti-virus software can use this feature to monitor malign software's 
activities, foe example, modify system
configuration or critical share libraries. Some system administration 
applications can use to obtain filesystem
 activities of every user in order to diagnose some system troubles.
