Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWCPFMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWCPFMW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 00:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWCPFMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 00:12:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63195 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932430AbWCPFMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 00:12:20 -0500
To: Zachary Amsden <zach@vmware.com>
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
References: <200603131809.k2DI9slZ005727@zach-dev.vmware.com>
	<m1fyljxvk8.fsf@ebiederm.dsl.xmission.com>
	<4418A21E.6030704@vmware.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 15 Mar 2006 22:03:44 -0700
In-Reply-To: <4418A21E.6030704@vmware.com> (Zachary Amsden's message of
 "Wed, 15 Mar 2006 15:24:14 -0800")
Message-ID: <m1d5gnc767.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden <zach@vmware.com> writes:

> Eric W. Biederman wrote:
>> Zachary Amsden <zach@vmware.com> writes:
>> Huh?  Rebooting through the BIOS and kexec are pretty much mutually exclusive.
>> Looking at the patch I can't see what you are talking about either.
>>
>
> Let me rephrase - kexec doesn't define calls for machine_shutdown and others
> that are in arch/i386/kernel/reboot.c.  So kexec requires BIOS reboot code to be
> compiled in, even though the usage of the two is mutually exclusive.

Partially true.  Basically it has never been optional to compile in the
BIOS reboot code and kexec did not change that situation.  Although it
did provide a similar mechanism.

>> Does kexec successfully work under VMWare?
>>
>
> It should work just fine.  But it could expose bugs on either end.  I've been
> monitoring our kexec testing, and I'll be able to help you with any issues that
> we might find on the Linux side.  :)

Ok.

>> machine_halt does not want to stop the processor.  It is very much
>> about killing the kernel and user space but having the software still
>> linger a little.
>>
>
> I was afraid of that.  I can back that change out.  The problem I had was that
> the shutdown code I was running in userspace would not make the syscalls to
> actually call machine_power_off, but machine_halt instead.  Will fix.

/sbin/halt -p will call machine_power_off if pm_power_off is defined.
otherwise it will call machine_halt.

Eric

