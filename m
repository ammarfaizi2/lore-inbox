Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267840AbUHTIcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267840AbUHTIcP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267829AbUHTIcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:32:15 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:51643 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267726AbUHTI2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:28:30 -0400
Date: Fri, 20 Aug 2004 13:57:58 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org, akpm@osdl.org,
       Suparna Bhattacharya <suparna@in.ibm.com>, litke@us.ibm.com,
       mbligh@aracnet.com
Subject: Re: [Fastboot] [RFC]Kexec based crash dumping
Message-ID: <20040820082758.GA6560@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <20040817120239.GA3916@in.ibm.com> <m1n00q8c9p.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1n00q8c9p.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 02:05:54AM -0600, Eric W. Biederman wrote:
> Hariprasad Nellitheertha <hari@in.ibm.com> writes:
> 
> > Hi,
> > 
> > The patches that follow contain the initial implementation for kexec based
> > crash dumping that we are working on. I had sent this to the fastboot mailing 
> > list a couple of weeks ago and this set of patches includes the changes made as
> > per feedback from Andrew, Eric and others.
> 
> One significant change is missing.  You do not separate out the two
> use cases of kexec.  So on a system that is configured to use
> call sys_reboot(LINUX_REBOOT_CMD_KEXEC) on reboot I will get a core
> dump if using your code.

In some ways, whether we are doing a "crash dump" reboot or a "normal"
kexec reboot is determined by the command line parameters that are
passed to the kexec loaded kernel. If we do not restrict the memory
size and do not add the keyword "dump" in the command line, it will do 
a normal kexec reboot. The dump file will not show up in the second kernel.

> 
> Or alternatively if I call sys_kexec_load and then something in the
> shutdown scripts triggers a kernel panic it is not OK to
> start boot the new kernel instead of taking normal panic behavior.

A way to disable kexec reboot from panic code is indeed needed. I will
add the necessary code to do this.

> 
> Until the two uses of kexec are separated they two uses
> of kexec remain mutually exclusive and incompatible, and it I cannot
> merge your patches into the existing kexec patchset.
> 
> .....
> 
> In general I still your kexec on panic code is doing way to much,
> and I think a lot of that  is that you don't have a kernel that will
> run when loaded at a different physical address.  
> 
> To that end I have written a patch that accomplishes exactly that.
> Please see my just released kexec patchset.

Will work on the necessary changes so we can use your patchset.

> 
> Eric

Thanks and Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore
