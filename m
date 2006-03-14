Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWCNP4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWCNP4E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWCNP4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:56:03 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:61446 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750721AbWCNP4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:56:01 -0500
Message-ID: <4416E757.9040208@vmware.com>
Date: Tue, 14 Mar 2006 07:55:03 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, Zachary Amsden <zach@vmware.com>,
       Linus Torvalds <torvalds@osdl.org>,
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
Subject: Re: [RFC, PATCH 2/24] i386 Vmi config
References: <200603131800.k2DI0RfN005633@zach-dev.vmware.com> <20060314152350.GB16921@infradead.org>
In-Reply-To: <20060314152350.GB16921@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Mon, Mar 13, 2006 at 10:00:27AM -0800, Zachary Amsden wrote:
>   
>> Introduce the basic VMI sub-arch configuration dependencies.  VMI kernels only
>> are designed to run on modern hardware platforms.  As such, they require a
>> working APIC, and do not support some legacy functionality, including APM BIOS,
>> ISA and MCA bus systems, PCI BIOS interfaces, or PnP BIOS (by implication of
>> dropping ISA support).  They also require a P6 series CPU.
>>     
>
> That's pretty bad because distributors need another kernel still.  At least
> a working APIC isn't quite as common today as it should.
>   

It doesn't need to be a fully functional APIC.  It just needs to not 
have one particular bug - Pentium processor erratum 11AP.  There is no 
reason that most of these requirements can't be dropped.  We used to 
have a lot more functionality and legacy support turned off, and we 
gradually turned it back on.  Turning on the BIOS interfaces will cause 
complications for a VMI kernel running in a hypervisor - since it can't 
invoke non-virtualized BIOS code.  So it does require a bit of 
conditional logic, which is pretty easy, but we haven't got around to 
doing yet.

Zach
