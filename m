Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbTEQQRC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 12:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbTEQQRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 12:17:02 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:23243 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S261618AbTEQQRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 12:17:01 -0400
Date: Sat, 17 May 2003 17:32:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Yoav Weiss <ml-lkml@unpatched.org>
cc: Ahmed Masud <masud@googgun.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap [was: The disappearing sys_call_table export.]
In-Reply-To: <Pine.LNX.4.44.0305170211180.32047-100000@marcellos.corky.net>
Message-ID: <Pine.LNX.4.44.0305171719110.2017-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 May 2003, Yoav Weiss wrote:
> 
> Just a thought: If we encrypt per-area, it might make more sense to go
> down another level, to mm_struct.  It already has its refcount and
> backpoints its users.  The key is valid iff the mm_struct is valid anyway,
> so we may not have to track so many things ourselves.  Just allocate a
> random key whenever mm_struct is allocated, and overwrite the key before
> mm_struct is freed.  Any mm experts care to comment ?

A page of swap may belong to different mms (see fork's copy_page_range
calling swap_duplicate).  That's a difficulty for your approaches,
and one reason why cryptoloop of block device is used instead.

Hugh

