Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWCWA7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWCWA7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 19:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWCWA7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 19:59:15 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:62224 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932138AbWCWA7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 19:59:14 -0500
Message-ID: <4421F1AD.1070108@vmware.com>
Date: Wed, 22 Mar 2006 16:54:05 -0800
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
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com> <200603222115.46926.ak@suse.de> <20060322214025.GJ15997@sorel.sous-sol.org> <4421CCA8.4080702@vmware.com> <20060322225117.GM15997@sorel.sous-sol.org> <4421DF62.8020903@vmware.com> <20060323004136.GR15997@sorel.sous-sol.org>
In-Reply-To: <20060323004136.GR15997@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Zachary Amsden (zach@vmware.com) wrote:
>   
>> Chris Wright wrote:
>>     
>>> You could compile all platform layers you want to support with the kernel.
>>>       
>> But the entire point is that you don't know what platform layers you 
>> want to support.  The platform layers can change.  Xen has changed the 
>> platform layer and re-optimized kernel / hypervisor transitions how many 
>> times?  The platform layer provides exactly the flexibility to do that, 
>> so that a kernel you compile today against a generic platform can work 
>> with the platform layer provided by Xen 4.0 tomorrow.
>>     
>
> This only works if you have all possible dreamed of interface bits in
> the ABI. In Linux, we often don't know what we'll need to support in the
> future, but we don't write binary compatible interfaces just in case we
> need to update.  Preferring instead, API's that are justifiable right now.
> This is the issue I have with the ABI proposal.  It doesn't fit well
> with Linux developement.
>   

No, you don't need to dream up all the possible interface bits ahead of 
time.  With a la carte interfaces, you can take what you need now, and 
add features later.  You don't need an ABI for features.  You need it 
for compatibility.  You will need to update the hypervisor ABI.  And you 
can't force people to upgrade their kernels.

And much of this is so low level, that a C API for it just doesn't make 
sense.  This code is completely hidden from Linux development to begin 
with, tucked away in the low level sub-arch layer.

Zach
