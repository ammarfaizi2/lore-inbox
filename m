Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129682AbRBTTzv>; Tue, 20 Feb 2001 14:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130206AbRBTTzb>; Tue, 20 Feb 2001 14:55:31 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:7285 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129682AbRBTTzV>;
	Tue, 20 Feb 2001 14:55:21 -0500
Message-ID: <3A92CB59.F9CD00C0@sgi.com>
Date: Tue, 20 Feb 2001 11:54:01 -0800
From: Rajagopal Ananthanarayanan <ananth@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16-4SGI_20smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: sync on pages containing EOF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was looking at some code to deal with sync (eg. sys_fsync(fd)).
Generally, sync is performed by calling filemap_fdatasync(...)
which does writepage() on pages in the dirty list of the inode,
and then using filemap_fdatawait to wait on the I/O's started by
the writepage's.

Consider writepage() on a (partial) page containing EOF. In this case,
prepare_write/commit_write is employed to write the page out.
However, commit_write will only mark the buffer dirty, and
not actually start the I/O. Subsequently, either memory pressure
(page_launder) or write pressure (flush_dirty_buffers) will
start the I/O on the EOF-page. So, it appears that filemap_fdatawait
will be delayed.

I'm just wondering if this argument is correct ...

-- 
--------------------------------------------------------------------------
Rajagopal Ananthanarayanan ("ananth")
Member Technical Staff, SGI.
--------------------------------------------------------------------------
