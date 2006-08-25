Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751611AbWHYARz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbWHYARz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 20:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbWHYARz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 20:17:55 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:1231 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751309AbWHYARz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 20:17:55 -0400
Date: Thu, 24 Aug 2006 17:17:30 -0700
From: Paul Jackson <pj@sgi.com>
To: Dave McCracken <dmccr@us.ibm.com>, Arjan van de Ven <arjan@infradead.org>,
       Diego Calleja <diegocg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>
Subject: pxx_page macro patch breaks arm build in 2.6.18-rc4-mm2
Message-Id: <20060824171730.162c245a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The defconfig arch=arm build is broken in 2.6.18-rc4-mm2.

The patch "standardize-pxx_page-macros.patch" removed various macros,
including pmd_page_kernel.

It seems to have missed one place, which breaks the defconfig 'arm'
build in 2.6.18-rc4-mm2:


=======================================================
  LD      .tmp_vmlinux1
arch/arm/mm/built-in.o(.text+0x1698): In function `$a':
: undefined reference to `pmd_page_kernel'
make: *** [.tmp_vmlinux1] Error 1
=======================================================


The offending line and a little context, in arch/arm/mm/ioremap.c:


=======================================================
                        * Free the page table, if there was one.
                         */
                        if ((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_TABLE)
                                pte_free_kernel(pmd_page_kernel(pmd));
                }

                addr += PGDIR_SIZE;
=======================================================

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
