Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTKTXCd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 18:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTKTXAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 18:00:20 -0500
Received: from holomorphy.com ([199.26.172.102]:64688 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263057AbTKTW4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 17:56:32 -0500
Date: Thu, 20 Nov 2003 14:56:29 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, Voicu Liviu <pacman@mscc.huji.ac.il>,
       kerin@recruit2recruit.net
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-ID: <20031120225629.GN22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Voicu Liviu <pacman@mscc.huji.ac.il>,
	kerin@recruit2recruit.net
References: <20031120101830.GH22764@holomorphy.com> <3FBC9604.1020007@mscc.huji.ac.il> <20031120103117.GI22764@holomorphy.com> <3FBC996F.2060902@mscc.huji.ac.il> <20031120104220.GJ22764@holomorphy.com> <3FBC9C94.4030603@mscc.huji.ac.il> <20031120172059.GA22495@64m.dyndns.org> <20031120213810.GA5094@localhost> <20031120215536.GM22764@holomorphy.com> <20031120225354.GB5094@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120225354.GB5094@localhost>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 11:53:54PM +0100, Jose Luis Domingo Lopez wrote:
> I untarred it to /tmp and, as root, I run:
> /tmp/vmware-any-any-update45/runme.pl
> Then the script stopped VMware services, went to recompile both vmnet.o
> and vmmon.o, and then started the services again.
> Launched VMware as usual, tried to boot the same guest operating system
> I used on yesterday's BUG report, and got the messages in the log.
> What I am going to try now is to completely uninstall VMware, install it
> from scratch and apply vmware-any-any-update45.tar.gz and see how it goes 
> (to avoid previously applied patches or manual modifications to VMware
> sources done by me making some difference).
[...]

Okay, try this fix:


diff -prauN mm4-2.6.0-test9-1/mm/memory.c mm4-2.6.0-test9-default-2/mm/memory.c
--- mm4-2.6.0-test9-1/mm/memory.c	2003-11-19 00:07:15.000000000 -0800
+++ mm4-2.6.0-test9-default-2/mm/memory.c	2003-11-19 18:08:49.000000000 -0800
@@ -1424,7 +1424,7 @@ do_no_page(struct mm_struct *mm, struct 
 	pte_t entry;
 	struct pte_chain *pte_chain;
 	int sequence = 0;
-	int ret;
+	int ret = VM_FAULT_MINOR;
 
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
 		return do_anonymous_page(mm, vma, page_table,
