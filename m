Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751655AbWCOVff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbWCOVff (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWCOVe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:34:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46551 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751584AbWCOVex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:34:53 -0500
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
       Leendert van Doorn <leendert@watson.ibm.com>,
       Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC, PATCH 14/24] i386 Vmi reboot fixes
References: <200603131809.k2DI9slZ005727@zach-dev.vmware.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 15 Mar 2006 14:11:19 -0700
In-Reply-To: <200603131809.k2DI9slZ005727@zach-dev.vmware.com> (Zachary
 Amsden's message of "Mon, 13 Mar 2006 10:09:54 -0800")
Message-ID: <m1fyljxvk8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden <zach@vmware.com> writes:

> Fix reboot to work with the  VMI.  We must support fallback to the standard
> BIOS reboot mechanism.  Turns out that this is required by kexec, and a good
> idea for native hardware. 

Huh?  Rebooting through the BIOS and kexec are pretty much mutually exclusive.
Looking at the patch I can't see what you are talking about either.

Does kexec successfully work under VMWare?


> We simply insert the NOP VMI reboot hook before
> calling the BIOS reboot.  While here, fix SMP reboot issues as well.  The
> problem is the halt() macro in VMI has been defined to be equivalent to
> safe_halt(), which enables interrupts.  Several call sites actually want to
> disable interrupts and shutdown the processor, which is what VMI_Shutdown()
> does.

machine_halt actually is not one of those places.

machine_halt does not want to stop the processor.  It is very much
about killing the kernel and user space but having the software still
linger a little.

This needs a cleaner abstraction to make sense or go in.

Eric
