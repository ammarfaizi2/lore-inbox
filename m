Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbUK0Ch5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbUK0Ch5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262833AbUK0CF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:05:26 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262651AbUKZThH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:37:07 -0500
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD64: GPF in sys32_lstat64 call path
References: <34n1d-6LW-7@gated-at.bofh.it> <34n1d-6LW-5@gated-at.bofh.it>
From: Andi Kleen <ak@suse.de>
Date: 25 Nov 2004 12:17:19 +0100
In-Reply-To: <34n1d-6LW-5@gated-at.bofh.it>
Message-ID: <p73mzx6uqio.fsf@brahms.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak <kas@fi.muni.cz> writes:

> 	I've got the following GPF on my quad-opteron HP DL585.
> The process in question was "save" from the Legato Networker
> suite (i.e. 32-bit binary) doing nightly backup. The system
> is pretty stock RHEL3, except that kernel has been upgraded
> to 2.6.8.1. The server was almost idle at that time except for the
> "save" Networker process. The server currently acts as NFS server.
> Root FS is ext3, and there are three XFS volumes over LVM on an array
> behind a Qlogic FC HBA. More information is available on request.

   0:   48 89 50 08             mov    %rdx,0x8(%rax)

and rax is 0x5e03d1f6c831e2ad, which raised an uncanonical address 
general protection fault.

Someone corrupted memory and the linked list of slab objects is broken.
Most probably some driver. You can enable slab debugging (will slow down
the machine) and see if that turns up something.

-Andi
 
