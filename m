Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263671AbTEMXEe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263673AbTEMXEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:04:34 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:3431 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263671AbTEMXEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:04:32 -0400
Date: Tue, 13 May 2003 18:16:16 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: "Mika Penttil?" <mika.penttila@kolumbus.fi>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Race between vmtruncate and mapped areas?
Message-ID: <247390000.1052867776@baldur.austin.ibm.com>
In-Reply-To: <20030513231139.GZ8978@holomorphy.com>
References: <154080000.1052858685@baldur.austin.ibm.com>
 <3EC15C6D.1040403@kolumbus.fi> <199610000.1052864784@baldur.austin.ibm.com>
 <20030513224929.GX8978@holomorphy.com>
 <220550000.1052866808@baldur.austin.ibm.com>
 <20030513231139.GZ8978@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, May 13, 2003 16:11:39 -0700 William Lee Irwin III
<wli@holomorphy.com> wrote:

> Okay, what's stopping filemap_nopage() from fetching the page from
> pagecache after one of the mm->mmap_sem's is dropped but before
> truncate_inode_pages() removes the page? The fault path is only locked
> out for one mm during one part of the operation. I can see taking
> ->i_sem in do_no_page() fixing it, but not ->mmap_sem in vmtruncate()
> (but of course that's _far_ too heavy-handed to merge at all).

mmap_sem is held for read across the entire fault, so by the time
vmtruncate_list() can call zap_page_range() the page has been instantiated
in the page table and will get removed.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

