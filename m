Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965174AbWCWEEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbWCWEEk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 23:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965179AbWCWEEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 23:04:39 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:58384 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965174AbWCWEEj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 23:04:39 -0500
Message-ID: <44221E56.7030006@vmware.com>
Date: Wed, 22 Mar 2006 20:04:38 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com> <200603222115.46926.ak@suse.de> <20060322214025.GJ15997@sorel.sous-sol.org> <4421CCA8.4080702@vmware.com> <20060322225117.GM15997@sorel.sous-sol.org> <4421DF62.8020903@vmware.com> <20060323004136.GR15997@sorel.sous-sol.org> <4421F1AD.1070108@vmware.com> <20060323010627.GS15997@sorel.sous-sol.org>
In-Reply-To: <20060323010627.GS15997@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Zachary Amsden (zach@vmware.com) wrote:
>   
>> No, you don't need to dream up all the possible interface bits ahead of 
>> time.  With a la carte interfaces, you can take what you need now, and 
>> add features later.  You don't need an ABI for features.  You need it 
>> for compatibility.  You will need to update the hypervisor ABI.  And you 
>> can't force people to upgrade their kernels.
>>     
>
> How do you support an interface that's not already a part of the ABI
> w/out changing the kernel?
>   

You have to change the kernel for VMI interface upgrades - if you want 
to use the upgrades.  You don't need to change the kernel for hypervisor 
ABI changes, nor does upgrading the interface require a kernel change.  
Interface upgrades are pretty easy to compartmentalize - you add block 
device support, you add a block device driver.  Hypervisor ABI changes 
are not so easy, because of the data dependencies and potential for 
breaking compatibility.  The massive security hole scenario is a good 
example of why you would need to break compatibility, but any number of 
things might make you want to change the hypervisor ABI.

The point of the VMI is to isolate the kernel from those changes, 
allowing kernel development to proceed unhindered, and allowing 
hypervisor innovation to thrive simultaneously.

Zach
