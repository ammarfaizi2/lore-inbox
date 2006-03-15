Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWCOJhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWCOJhH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 04:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWCOJhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 04:37:07 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:52609 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751148AbWCOJhG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 04:37:06 -0500
Date: Wed, 15 Mar 2006 01:41:49 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Gerd Hoffmann <kraxel@suse.de>,
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
Message-ID: <20060315094149.GT12807@sorel.sous-sol.org>
References: <200603131804.k2DI4N6s005678@zach-dev.vmware.com> <20060314064107.GK12807@sorel.sous-sol.org> <44166D6B.4090701@vmware.com> <20060314215616.GM12807@sorel.sous-sol.org> <4417454F.2080908@vmware.com> <20060315043108.GP12807@sorel.sous-sol.org> <4417CFDA.1060806@suse.de> <4417D212.20401@vmware.com> <20060315090935.GS12807@sorel.sous-sol.org> <4417DBE8.6070302@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4417DBE8.6070302@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> >+       DEFINE(VSYSCALL_BASE, (PAGE_OFFSET - 2*PAGE_SIZE));
> 
> Ok, I'm confused.  What fixed math?

Sorry, bad choice of words.  From above, the VYSYCALL_BASE is known
at compile time (in asm-offsets.h).  So the SYSENTER_RETURN is still
fixed addr.  For execshield it's truly dynamic, so you get something
like this instead of the constant SYSENTER_RETURN:

-	pushl $SYSENTER_RETURN
+	pushl (TI_sysenter_return-THREAD_SIZE+8+4*4)(%esp)

thanks,
-chris
