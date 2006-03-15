Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWCOXZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWCOXZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbWCOXZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:25:44 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:48393 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932199AbWCOXZn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:25:43 -0500
Message-ID: <4418A21E.6030704@vmware.com>
Date: Wed, 15 Mar 2006 15:24:14 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 14/24] i386 Vmi reboot fixes
References: <200603131809.k2DI9slZ005727@zach-dev.vmware.com> <m1fyljxvk8.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1fyljxvk8.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Zachary Amsden <zach@vmware.com> writes:
> Huh?  Rebooting through the BIOS and kexec are pretty much mutually exclusive.
> Looking at the patch I can't see what you are talking about either.
>   

Let me rephrase - kexec doesn't define calls for machine_shutdown and 
others that are in arch/i386/kernel/reboot.c.  So kexec requires BIOS 
reboot code to be compiled in, even though the usage of the two is 
mutually exclusive.

> Does kexec successfully work under VMWare?
>   

It should work just fine.  But it could expose bugs on either end.  I've 
been monitoring our kexec testing, and I'll be able to help you with any 
issues that we might find on the Linux side.  :)

> machine_halt does not want to stop the processor.  It is very much
> about killing the kernel and user space but having the software still
> linger a little.
>   

I was afraid of that.  I can back that change out.  The problem I had 
was that the shutdown code I was running in userspace would not make the 
syscalls to actually call machine_power_off, but machine_halt instead.  
Will fix.

Zach
