Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264484AbUEXUV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUEXUV0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264585AbUEXUV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:21:26 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:27557 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S264484AbUEXUVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:21:24 -0400
Date: Mon, 24 May 2004 22:21:21 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: EAGAIN in do_mmap_pgoff() [2.6.7-rc1]
Message-ID: <20040524202121.GA28273@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


just a short question:

is -EAGAIN here really intentional? wouldn't -ENOMEM be better?

mm/mmap.c ~780 do_mmap_pgoff()

        /* mlock MCL_FUTURE? */
        if (vm_flags & VM_LOCKED) {
                unsigned long locked = mm->locked_vm << PAGE_SHIFT;
                locked += len;
                if (locked > current->rlim[RLIMIT_MEMLOCK].rlim_cur)
                        return -EAGAIN;
        }

TIA,
Herbert

