Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267246AbUBSU70 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267272AbUBSU70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:59:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37824 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267246AbUBSU7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:59:22 -0500
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@osdl.org>, paulmck@us.ibm.com
Subject: Re: Non-GPL export of invalidate_mmap_range
Date: Thu, 19 Feb 2004 15:56:49 -0500
User-Agent: KMail/1.5.4
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20040216190927.GA2969@us.ibm.com> <20040217124001.GA1267@us.ibm.com> <20040217161929.7e6b2a61.akpm@osdl.org>
In-Reply-To: <20040217161929.7e6b2a61.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402191531.56618.phillips@arcor.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 February 2004 19:19, Andrew Morton wrote:
> I don't see any licensing issues with the patch because the filesystem
> which needs it clearly meets Linus's "this is not a derived work" criteria.
>
> And I don't see a technical problem with the export: given that we export
> truncate_inode_pages() it makes sense to also export the corresponding
> pagetable shootdown function.
>
> Yes, this is a sensitive issue.  Can we please evaluate it strictly
> according to technical and licensing considerations?
>
> Having said that, what concerns issues remain with Paul's patch?

Hi Andrew,

OpenGFS and Sistina GFS use zap_page_range directly, essentially doing the 
same as invalidate_mmap_range but skipping any vmas belonging to MAP_PRIVATE 
mmaps.  This avoids destroying data on anon pages.  GPFS and every other DFS 
have the same problem as far as I can see, and it isn't addressed by 
exporting invalidate_mmap_range as it stands.  Paul?

Regards,

Daniel

