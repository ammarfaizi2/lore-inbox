Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbVLMWyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbVLMWyq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbVLMWyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:54:46 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:39615 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030334AbVLMWyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:54:45 -0500
Subject: [PATCH -mm 0/9] unshare system call : updated patch series
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134513864.11972.156.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 13 Dec 2005 17:54:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patches represent the updated version of the proposed
new system call unshare. Patches that registered system call for
different architectures were not updated but are being resent in
the series along with the updated patches.

Changes since the first submission of this patch series on 12/12/05:
	- Patches 1, 6, 7, 8, and 9 are updated to incorporate
	  feedback from Al Viro. Changes are described in the change
	  log for each of the patches (12/13/05)

unshare allows a process to disassociate part of the process context (vm
namespace, files and fs) that was being shared with a parent.  Unshare 
is needed to implement polyinstantiated directories (such as per-user 
and/or per-security context /tmp directory) using the kernel's per-process
namespace mechanism. For a more detailed description of the justification
and approach, please refer to lkml threads from 8/8/05, 10/13/05 & 12/08/05.
                                                                                
Unshare system call, along with shared tree patches, have been in use
in our department for over month and half. We have been using them to
maintain per-user and per-context /tmp directory. The latest port to
2.6.15-rc5-mm2 has been tested on a uni-processor i386 machine.

Patches are organized as follows:

1. Patch implements system call handler sys_unshare. System call
   accepts all clone(2) flags but returns -EINVAL when attempt is
   made to unshare any shared context.
2. Patch registers system call for i386 architecture
3. Patch registers system call for powerpc architecture
4. Patch registers system call for ppc architecture
5. Patch registers system call for x86_64 architecture
6. Patch implements unsharing of filesystem information
7. Patch implements unsharing of namespace
8. Patch implements unsharing of vm
9. Patch implements unsharing of files



