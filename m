Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932797AbWCVVfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932797AbWCVVfJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932798AbWCVVfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:35:08 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:13186 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932797AbWCVVfG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:35:06 -0500
Date: Wed, 22 Mar 2006 13:34:35 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Zachary Amsden <zach@vmware.com>,
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
Subject: Re: [RFC, PATCH 1/24] i386 Vmi documentation
Message-ID: <20060322213435.GI15997@sorel.sous-sol.org>
References: <200603131759.k2DHxeep005627@zach-dev.vmware.com> <200603222105.58912.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603222105.58912.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> On Monday 13 March 2006 18:59, Zachary Amsden wrote:
> 
> > +     The general mechanism for providing customized features and
> > +     capabilities is to provide notification of these feature through
> > +     the CPUID call, 
> 
> How should that work since CPUID cannot be intercepted by 
> a Hypervisor (without VMX/SVM)?  

Yeah, it requires guest kernel cooperation/modification.

> > +   The net result of these choices is that most of the calls are very
> > +   easy to make from C-code, and calls that are likely to be required in
> > +   low level trap handling code are easy to call from assembler.   Most
> > +   of these calls are also very easily implemented by the hypervisor
> > +   vendor in C code, and only the performance critical calls from
> > +   assembler paths require custom assembly implementations.
> > +
> > +   CORE INTERFACE CALLS
> 
> Did I miss it or do you never describe how to find these entry points? 

It's the ROM interface.  For native they are emitted directly inline.
For non-native, they are emitted as call stubs, which call to the ROM.
I don't recall if it's in this doc, but the inline patch has all the
gory details.

thanks,
-chris
