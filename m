Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311206AbSCZLGc>; Tue, 26 Mar 2002 06:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311203AbSCZLGX>; Tue, 26 Mar 2002 06:06:23 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:3089 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S311147AbSCZLGO>;
	Tue, 26 Mar 2002 06:06:14 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15520.21196.511499.316840@argo.ozlabs.ibm.com>
Date: Tue, 26 Mar 2002 21:51:56 +1100 (EST)
To: Theodore Tso <tytso@mit.edu>
Cc: Andrew Morton <akpm@zip.com.au>, "H . J . Lu" <hjl@lucon.org>,
        linux-mips@oss.sgi.com, linux kernel <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: Does e2fsprogs-1.26 work on mips?
In-Reply-To: <20020326015440.A12162@thunk.org>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso writes:

> 3)  RLIMIT_FILESIZE should not apply to block devices!!!

Absolutely.

I would go further and say that it should only apply to writes to a
regular file that would extend the file past the filesize limit.  At
the moment the check in generic_file_write is simply whether the file
offset is greater than the limit, or would be greater than the limit
after the write.  This doesn't seem right to me.  If, for example, my
RLIMIT_FILESIZE is 1MB, and I have write access to an existing 100MB
file, I think I should be able to write anywhere in that file as long
as I don't try to extend it.

If we did that then the block device case would fall out, since you
can't extend block devices (not by writing past the end of them
anyway).

Paul.
