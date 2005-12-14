Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbVLNAUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbVLNAUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 19:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbVLNAUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 19:20:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46810 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030374AbVLNAUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 19:20:19 -0500
Date: Tue, 13 Dec 2005 16:19:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: janak@us.ibm.com
Cc: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 0/9] unshare system call : updated patch series
Message-Id: <20051213161931.66978418.akpm@osdl.org>
In-Reply-To: <1134513864.11972.156.camel@hobbs.atlanta.ibm.com>
References: <1134513864.11972.156.camel@hobbs.atlanta.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JANAK DESAI <janak@us.ibm.com> wrote:
>
> 
> The following patches represent the updated version of the proposed
> new system call unshare. Patches that registered system call for
> different architectures were not updated but are being resent in
> the series along with the updated patches.
> 
> Changes since the first submission of this patch series on 12/12/05:
> 	- Patches 1, 6, 7, 8, and 9 are updated to incorporate
> 	  feedback from Al Viro. Changes are described in the change
> 	  log for each of the patches (12/13/05)
> 
> unshare allows a process to disassociate part of the process context (vm
> namespace, files and fs) that was being shared with a parent.  Unshare 
> is needed to implement polyinstantiated directories (such as per-user 
> and/or per-security context /tmp directory) using the kernel's per-process
> namespace mechanism. For a more detailed description of the justification
> and approach, please refer to lkml threads from 8/8/05, 10/13/05 & 12/08/05.
>                                                                                 
> Unshare system call, along with shared tree patches, have been in use
> in our department for over month and half. We have been using them to
> maintain per-user and per-context /tmp directory. The latest port to
> 2.6.15-rc5-mm2 has been tested on a uni-processor i386 machine.

I wouldn't view this as an adequate changelog for a new feature, really. 
Please prepare a new one which describes what the feature does, how it does
it and, especially, why we would want to add it to the kernel.

It adds 1.6k to my allnoconfig image which I guess can be lived with, but
we need a *good* understanding of what we're getting for that cost, and
apart from sending the reader onto an ill-defied lkml fishing expedition,
you haven't provided that.

Another downside which we need to weigh when evaluating this contribution
is the security risk.  You've added code which very, very few people will
use in real-life.  If it has holes or races they just won't be found by our
normal testing processes.  Chances are the first time we'll hear about them
is when some smarty has gone explicitly looking for exploits.

Please demonstrate how each unsharing (fs, ns, sig, mm, fd) is correctly
locked and refcounted against concurrent users.  I've only checked mm
against access_process_vm() and it looks OK.

Thanks.
