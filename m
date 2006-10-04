Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030686AbWJDRxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030686AbWJDRxl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030691AbWJDRxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:53:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20382 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030686AbWJDRxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:53:40 -0400
To: Zach Brown <zach.brown@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] call truncate_inode_pages in the DIO fallback to buffered I/O path
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
References: <x49zmcc6mhh.fsf@segfault.boston.devel.redhat.com>
	<20061004102522.d58c00ef.akpm@osdl.org> <4523F486.1000604@oracle.com>
From: Jeff Moyer <jmoyer@redhat.com>
Date: Wed, 04 Oct 2006 13:53:32 -0400
In-Reply-To: <4523F486.1000604@oracle.com> (Zach Brown's message of "Wed, 04 Oct 2006 10:51:02 -0700")
Message-ID: <x49mz8c6k83.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch] call truncate_inode_pages in the DIO fallback to buffered I/O path; Zach Brown <zach.brown@oracle.com> adds:

>> Why is this a problem?  It's just like someone did a write(), and we'll
>> invalidate the pagecache on the next direct-io operation.

zach.brown> This was noticed as a distro regression as they moved from the
zach.brown> kernels that used to invalidate the entire address space on
zach.brown> direct io ops to more modern ones that only invalidate the
zach.brown> region being written.

Right.

zach.brown> You can end up with significant memory pressure after this
zach.brown> change with a large enough working set on disk.

>> eek.  truncate_inode_pages() will throw away dirty data.  Very
>> dangerous, much chin-scratching needed.

zach.brown> Yeah, I failed to tell Jeff that it should be calling
zach.brown> filemap_fdatawrite() first to get things into writeback.  (And
zach.brown> presumably not truncating if that returns an error.)

Ahh, that explains it.  The strange thing is that my test validates the
file afterwards, and I was seeing correct data.

I'll repost after another round of testing.

Thanks!

Jeff
