Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUDHNWc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 09:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUDHNWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 09:22:32 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:12767 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261745AbUDHNWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 09:22:31 -0400
Date: Thu, 8 Apr 2004 14:22:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: rmap: page_mapping barrier
Message-ID: <Pine.LNX.4.44.0404081409240.7010-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My page_mapping(page) says PageAnon(page)? NULL: page->mapping;
I've just realized, looking again at sync_page but it goes way
beyond it, that we need smp barriers of some kind somewhere,
don't we?  That is, we cannot just write the address of one of
our non-address_space structures into page->mapping, without
being very careful that others will see the PageAnon and treat
it as NULL.  There are places all over using page_mapping(page)
while another cpu might be right in page_add_rmap.  I go very
mushy when it comes to barriers, you understand them better
than most, any idea what we need to do in page_mapping(page),
and when setting and clearing PageAnon?

Thanks,
Hugh

