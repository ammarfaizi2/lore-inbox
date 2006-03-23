Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWCWLnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWCWLnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 06:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWCWLnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 06:43:22 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:63680 "EHLO
	iramx2.ira.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S1751239AbWCWLnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 06:43:21 -0500
In-Reply-To: <20060323010627.GS15997@sorel.sous-sol.org>
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com> <200603222115.46926.ak@suse.de> <20060322214025.GJ15997@sorel.sous-sol.org> <4421CCA8.4080702@vmware.com> <20060322225117.GM15997@sorel.sous-sol.org> <4421DF62.8020903@vmware.com> <20060323004136.GR15997@sorel.sous-sol.org> <4421F1AD.1070108@vmware.com> <20060323010627.GS15997@sorel.sous-sol.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2117FCDD-A0FC-4786-92F2-76E7598BC962@ira.uka.de>
Cc: Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@suse.de>,
       virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Content-Transfer-Encoding: 7bit
From: Joshua LeVasseur <jtl@ira.uka.de>
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
Date: Thu, 23 Mar 2006 12:42:45 +0100
To: Chris Wright <chrisw@sous-sol.org>
X-Mailer: Apple Mail (2.749.3)
X-Spam-Score: -4.3 (----)
X-Spam-Report: -1.8 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 23, 2006, at 02:06 , Chris Wright wrote:

> * Zachary Amsden (zach@vmware.com) wrote:
>> No, you don't need to dream up all the possible interface bits  
>> ahead of
>> time.  With a la carte interfaces, you can take what you need now,  
>> and
>> add features later.  You don't need an ABI for features.  You need it
>> for compatibility.  You will need to update the hypervisor ABI.   
>> And you
>> can't force people to upgrade their kernels.
>
> How do you support an interface that's not already a part of the ABI
> w/out changing the kernel?


Since the base ABI primarily consists of the x86's privileged  
instruction set (actually, the virtualization-sensitive instructions,  
and padded with NOP instructions), any ROM can work from there, and  
you don't have to worry about updating Linux to use a new ABI.  If  
you use a new ROM+ABI with an old kernel+ABI, they can fall back to  
the base ABI.  Note that this base ABI isn't arbitrary; it wasn't  
pulled out of thin air; it is mostly the x86 system ISA.

If an updated hypervisor offers new features that didn't exist when a  
particular Linux kernel was written and compiled, a new ROM has a  
very good chance of activating those new features, even if only using  
the base ABI of the older Linux kernel.  The ROM is very versatile  
because it maps the low-level instructions to high-level hypervisor  
concepts.  And it is very successful: I have built a Linux 2.6.9  
binary and executed it on Xen 2.0.2, Xen 2.0.7, and Xen 3.0.1; I have  
also built a Linux 2.6.12.6 binary and executed it on Xen 2.0.2, Xen  
2.0.7, and Xen 3.0.1.  This is significant because XenoLinux 2.6.9  
shipped with Xen 2.0.2 and it doesn't work on Xen 3.0.1 due to many  
interface updates; likewise XenoLinux 2.6.12.6 shipped with Xen 3.0.1  
and it doesn't work on the older Xen 2 hypervisors; but the ROM hid  
the interface updates from Xen 2 series to the Xen 3 series, and it  
takes advantage of the new Xen 3 interfaces (it must since Xen 3  
doesn't have a Xen 2 compatibility layer that I'm aware of).

The ROM's interface mapping solves two problems: it converts the x86  
low-level instructions into high-performance hypervisor operations,  
and it maps the low-level instructions into the hypervisor's evolving  
interface.  The ROM gives great independence for hypervisor  
developers, or in other words, permits proliferation of hypervisors,  
and freedom to experiment with interfaces (e.g., real time, or formal  
verification).

Joshua

