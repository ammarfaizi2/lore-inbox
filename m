Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVAUKIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVAUKIb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 05:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVAUKIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 05:08:30 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:10462 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262251AbVAUKGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 05:06:11 -0500
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based
	crashdumps.
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       Maneesh Soni <maneesh@in.ibm.com>
In-Reply-To: <m1sm4v2p5t.fsf@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	 <1106294155.26219.26.camel@2fwv946.in.ibm.com>
	 <m1sm4v2p5t.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: 
Message-Id: <1106305073.26219.46.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Jan 2005 16:27:54 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-21 at 13:24, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> 
> > Hi Andrew,
> > 
> > Following patch is against 2.6.11-rc1-mm2. 
> > 
> > As mentioned by following note from Eric, crashdump code is currently
> > broken.
> > > 
> > > The crashdump code is currently slightly broken.  I have attempted to
> > > minimize the breakage so things can quick be made to work again.
> > 
> > We have started doing changes to make crashdump up and running again.
> > Following are few identified items to be done.
> > 
> > 1. Reserve the backup region (640k) during kernel bootup. 
> 
> Why do we need a separate region for this?
> 
> It should be simple enough to take 640 out of the area kexec reserves
> for the crash dump kernel.  That is what the previous code implemented.

Previous code also reserved the backup memory region after crash kernel
region. It is just a matter of interpretation. What I understand that
crash kernel reserved region represents something where one can load the
panic kernel directly and new kernel can use this memory region for
memory allocation.

I don't want to steal the backup region from crash kernel region
otherwise, I shall have to boot the crash kernel with some strange
values like memmap=(32M-640k)@16M (symbolically) to prevent crash kernel
overwriting backup region. Why to make user aware of location of backup
region.

Alternatively, this can be managed by reserving this backup region again
in crash kernel to avoid any stomping. May be pass backup region
location to new kernel through parameter segment or through command line
but don't see a strong reason for doing that.


Thanks
Vivek

