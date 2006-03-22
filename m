Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWCVWSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWCVWSl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWCVWSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:18:40 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:28420 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932111AbWCVWSR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:18:17 -0500
Message-ID: <4421CCA8.4080702@vmware.com>
Date: Wed, 22 Mar 2006 14:16:08 -0800
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
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com> <200603222115.46926.ak@suse.de> <20060322214025.GJ15997@sorel.sous-sol.org>
In-Reply-To: <20060322214025.GJ15997@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Andi Kleen (ak@suse.de) wrote:
>   
>> The disassembly stuff indeed doesn't look like something
>> that belongs in the kernel.
>>     

Agree that.  It should be done prior to kernel booting, invisible to the 
kernel itself.  I'm working on it, but there is still a lot to do.

>
> Strongly agreed.  The strict ABI requirements put forth here are not
> in-line with Linux, IMO.  I think source compatibility is the limit of
> reasonable, and any ROM code be in-tree if something like this were to
> be viable upstream.
>   

Strongly disagree.  Without an ABI, you don't have binary 
compatibility.  Without binary compatibility, you have no way to inline 
any hypervisor code into the kernel.  And this is key for performance.  
The ROM code is being phased out.

Is it the strictness of the ABI that is the problem?  I don't like 
constraining the native register values any much either, but it was the 
expedient thing to do.  The ABI can be relaxed quite a bit, but it has 
to be there.

The idea of in-tree ROM code doesn't make sense.  The entire point of 
this layer of code is that it is modular, and specific to the 
hypervisor, not the kernel.  Once you lift the shroud and combine the 
two layers, you have lost all of the benefit that it was supposed to 
provide.

Zach
