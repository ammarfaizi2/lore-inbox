Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUBDMgS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 07:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbUBDMfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 07:35:31 -0500
Received: from host62.ipowerweb.com ([66.235.195.162]:27032 "EHLO
	host62.ipowerweb.com") by vger.kernel.org with ESMTP
	id S261522AbUBDMfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 07:35:11 -0500
Message-ID: <4020E64F.8020006@lyola.com>
Date: Wed, 04 Feb 2004 15:32:15 +0300
From: Nikolay Igotti <nike@lyola.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: memmove syscall
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host62.ipowerweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - lyola.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Maybe this is kinda crazy (or known) idea, but why don't we create 
syscall
allowing large copies by just manipulating MMU page table, i.e.

asmlinkage long sys_memmove(void* dst, void* src, int size) {
  if ((dst & ~PAGE_SIZE) ||(src & ~PAGE_SIZE) || (size & ~PAGE_SIZE))
                return -EINVAL;

   return mmu_remap_pages(src,  dst, size / PAGE_SIZE);
}


 This could be useful for copying of large amounts of data when we know that
source not gonna be used anymore (typical example is garbage collector).
 
 Please reply directly, as I'm not on the list.


  Nikolay.

