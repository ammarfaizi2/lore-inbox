Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUHTIJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUHTIJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267700AbUHTIJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:09:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37024 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264297AbUHTIHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:07:23 -0400
To: hari@in.ibm.com
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org, akpm@osdl.org,
       Suparna Bhattacharya <suparna@in.ibm.com>, litke@us.ibm.com,
       mbligh@aracnet.com
Subject: Re: [Fastboot] [RFC]Kexec based crash dumping
References: <20040817120239.GA3916@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2004 02:05:54 -0600
In-Reply-To: <20040817120239.GA3916@in.ibm.com>
Message-ID: <m1n00q8c9p.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hariprasad Nellitheertha <hari@in.ibm.com> writes:

> Hi,
> 
> The patches that follow contain the initial implementation for kexec based
> crash dumping that we are working on. I had sent this to the fastboot mailing 
> list a couple of weeks ago and this set of patches includes the changes made as
> per feedback from Andrew, Eric and others.

One significant change is missing.  You do not separate out the two
use cases of kexec.  So on a system that is configured to use
call sys_reboot(LINUX_REBOOT_CMD_KEXEC) on reboot I will get a core
dump if using your code.

Or alternatively if I call sys_kexec_load and then something in the
shutdown scripts triggers a kernel panic it is not OK to
start boot the new kernel instead of taking normal panic behavior.

Until the two uses of kexec are separated they two uses
of kexec remain mutually exclusive and incompatible, and it I cannot
merge your patches into the existing kexec patchset.

.....

In general I still your kexec on panic code is doing way to much,
and I think a lot of that  is that you don't have a kernel that will
run when loaded at a different physical address.  

To that end I have written a patch that accomplishes exactly that.
Please see my just released kexec patchset.

Eric







