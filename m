Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUITT5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUITT5w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUITT5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:57:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12516 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264991AbUITT4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:56:01 -0400
To: hari@in.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, fastboot@osdl.org,
       Suparna Bhattacharya <suparna@in.ibm.com>, mbligh@aracnet.com,
       agl@us.ibm.com
Subject: Re: [Fastboot] Re: [PATCH][2/6]Memory preserving reboot using kexec
References: <20040915125041.GA15450@in.ibm.com>
	<20040915125145.GB15450@in.ibm.com>
	<20040915125322.GC15450@in.ibm.com>
	<m1d60i8075.fsf@ebiederm.dsl.xmission.com>
	<20040920134911.GA4592@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Sep 2004 13:53:35 -0600
In-Reply-To: <20040920134911.GA4592@in.ibm.com>
Message-ID: <m16568btts.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hariprasad Nellitheertha <hari@in.ibm.com> writes:

> Hi Eric,
> 
> On Sun, Sep 19, 2004 at 02:37:18PM -0600, Eric W. Biederman wrote:
> > Hariprasad Nellitheertha <hari@in.ibm.com> writes:
> > 
> > > This patch contains the code that does the memory preserving reboot. It 
> > > copies over the first 640k into a backup region before handing over to 
> > > kexec. The second kernel will boot using only the backup region.
> > 
> > Do you know what the kernel does with the low 1M?
> > 
> > Nothing in the hardware architecture requires us to use the
> > low 1M.  So I think we would be safer if we could track down
> > and remove this dependency.
> > 
> > In general I agree that we need to be prepared to save some of the
> > original machine state, because some architectures give special
> > meaning to addresses in memory.  But x86 is not one of those.
> > 
> > Perhaps the proper abstraction is to add a use_mem= variable
> > that simply tells us which memory addresses we can use.
> > 
> > By still doing some copying we run into the problem, of
> > potentially running out of memory areas where ongoing DMA
> > transfers may be happening.  So this is worth
> > tracking down.
> 
> I am trying to track this down. I tried moving the first segment of vmlinux
> into the reserved section by modifying kexec-tools. This is the command line
> argument segment. It still seems to need the first few kilobytes, though. 

Right that is being automatically placed there.
For testing it should not be too hard to hard code it at someplace
appropriate.

> Eliminating this is definitely needed so we can avoid using the first 
> kernel's region completely.
> 
> Also, I will make the changes in the rest of the patch as per your review
> comments.

Thanks.
