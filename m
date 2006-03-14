Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752011AbWCNQY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbWCNQY5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWCNQYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:24:36 -0500
Received: from mx1.suse.de ([195.135.220.2]:36315 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751821AbWCNQYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:24:25 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC, PATCH 17/24] i386 Vmi msr patch
Date: Tue, 14 Mar 2006 17:23:53 +0100
User-Agent: KMail/1.8
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
References: <200603131812.k2DICGJE005747@zach-dev.vmware.com>
In-Reply-To: <200603131812.k2DICGJE005747@zach-dev.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603141723.54365.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 19:12, Zachary Amsden wrote:
> Fairly straightforward code motion of MSR / TSC / PMC accessors
> to the sub-arch level.  Note that rdmsr/wrmsr_safe functions are
> not moved; Linux relies on the fault behavior here in the event
> that certain MSRs are not supported on hardware, and combining
> this with a VMI wrapper is overly complicated.  The instructions
> are virtualizable with trap and emulate, not on critical code
> paths, and only used as part of the MSR /proc device, which is
> highly sketchy to use inside a virtual machine, but must be
> allowed as part of the compile, since it is useful on native.

I'm not aware of any MSR access being on a critical code
path on a 32bit kernel. 

And I don't think it's a good idea to virtualize the TSC 
without CPU support.

Why would you want to do any of this?

-Andi
