Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751775AbWCOJEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWCOJEz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 04:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWCOJEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 04:04:55 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:25218 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751775AbWCOJEy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 04:04:54 -0500
Date: Wed, 15 Mar 2006 01:09:35 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Gerd Hoffmann <kraxel@suse.de>, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Rik Van Riel <riel@redhat.com>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 7/24] i386 Vmi memory hole
Message-ID: <20060315090935.GS12807@sorel.sous-sol.org>
References: <200603131804.k2DI4N6s005678@zach-dev.vmware.com> <20060314064107.GK12807@sorel.sous-sol.org> <44166D6B.4090701@vmware.com> <20060314215616.GM12807@sorel.sous-sol.org> <4417454F.2080908@vmware.com> <20060315043108.GP12807@sorel.sous-sol.org> <4417CFDA.1060806@suse.de> <4417D212.20401@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4417D212.20401@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> ENTRY(sysenter_entry)
>        movl TSS_sysenter_esp0(%esp),%esp
> sysenter_past_esp:
>        STI
>        pushl $(__USER_DS)
>        pushl %ebp
>        pushfl
>        pushl $(__USER_CS)
>        pushl $SYSENTER_RETURN
> 
> SYSENTER_RETURN is a link time constant that is defined based on the 
> location of the vsyscall page.  If the vsyscall page can move, this can 
> not be a constant.  The reason is, this "fake" exception frame is used 
> to return back to the EIP of the call site, and sysenter does not record 
> the EIP of the call site.

It's only real issue for something like execshield.  For this it's easy
to do the fixed math since it's still at fixed address.

+       DEFINE(VSYSCALL_BASE, (PAGE_OFFSET - 2*PAGE_SIZE));

But execshield has to make SYSENTER_RETURN context sensitive to current
since the vdso is mapped at random location.

thanks,
-chris
