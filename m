Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTGBAGe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 20:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTGBAGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 20:06:34 -0400
Received: from smtp2.Stanford.EDU ([171.64.14.116]:49898 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S263765AbTGBAGc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 20:06:32 -0400
To: linux-kernel@vger.kernel.org
Subject: is it possible to keep mmap'd memory from being synced?
Reply-To: blp@cs.stanford.edu
From: Ben Pfaff <blp@cs.stanford.edu>
Date: 01 Jul 2003 17:20:48 -0700
Message-ID: <87smppye1r.fsf@pfaff.Stanford.EDU>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way to keep mmap'd memory from being synced to disk?
In particular, we're trying to build tools that operate on a lot
of data that's security-sensitive.  The data is mapped into
memory, and large parts of it are repeatedly decrypted in-place,
operated on, and then re-encrypted in-place for final storage to
disk.  During the time that the data is in plaintext form, we'd
like it to not be written to disk.

Will mlock() do what we want?  I know that it will keep the data
from being evicted from memory, but will it also keep it from
being written back to the mmap'd file?  (We're mmap'ing a real
file, not /dev/zero, etc., because we do want to keep the data
for later use.)

We don't want to use MAP_PRIVATE, both because we do want the
data eventually to get written to disk and because we have
multiple processes that want to interact doing this at once.

It seems like not decrypting in-place would be another solution,
but we'd rather not use the extra memory--we're talking about
data on the order of 100 MB or so.

I'm posting this to linux-kernel because our software already
involves a small kernel module, so if need be we're willing to
add functionality to that module to help us do what we want.
But the program's data manipulation goes on in userspace.

Thanks,

Ben.

-- 
<blp@cs.stanford.edu> <pfaffben@msu.edu> <pfaffben@debian.org> <blp@gnu.org>
 Stanford Ph.D. Candidate - MSU Alumnus - Debian Maintainer - GNU Developer
                              www.benpfaff.org

