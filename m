Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268701AbUJPLck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268701AbUJPLck (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 07:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268700AbUJPLcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 07:32:39 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:32661 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S268701AbUJPLcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 07:32:36 -0400
Date: Sat, 16 Oct 2004 12:32:35 +0100
Message-ID: <412EB75E00164E05@mssazhh-int.msg.bluewin.ch>
From: christophpfister@bluemail.ch
Subject: failure in /mm/memory.c
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Bluewin WebMail / BlueMail
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello

i found a failure in function remap_pte_range in memory.c

static inline void remap_pte_range(...)
{
unsigned long end;
unsigned long pfn;
address &= ~PMD_MASK;
end = address + size;
if (end > PMD_SIZE)
    end = PMD_SIZE;
pfn = phys_addr >> PAGE_SHIFT;
do {
    BUG_ON(!pte_none(*pte));
    if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn))) *****
      set_pte(pte, pfn_pte(pfn, prot));
    address += PAGE_SIZE;
    pfn++;
    pte++;
    } while (address && (address < end));
}

by ****

the condition is wrong, because it just maps the page, if it's invalid or
reserved

correct: if (!(pfn_valid(pfn) || PageReserved(pfn_to_page(pfn))))

(it doesn't seems to be used, otherwise there must be bugs)

Yours sincerely,

Christoph Pfister

