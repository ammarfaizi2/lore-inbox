Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264649AbUEXU3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264649AbUEXU3D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264683AbUEXU3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:29:03 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:28069 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S264649AbUEXU2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:28:53 -0400
Date: Mon, 24 May 2004 22:28:52 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: errorpath in expand_stack() [2.6.7-rc1]
Message-ID: <20040524202852.GB28273@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


another question:

I'm not sure the vm_unacct_memory(grow) is 
correct here, but if, shouldn't there be the
same in the security_vm_enough_memory(grow)
path?

mm/mmap.c ~1260 expand_stack()

        /* Overcommit.. */
        if (security_vm_enough_memory(grow)) {
                anon_vma_unlock(vma);
                return -ENOMEM;
        }

        if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
                        ((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
                        current->rlim[RLIMIT_AS].rlim_cur) {
                anon_vma_unlock(vma);
                vm_unacct_memory(grow);
                return -ENOMEM;
        }


TIA,
Herbert

