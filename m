Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTLPVbT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 16:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTLPVbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 16:31:19 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:14785 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262694AbTLPVbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 16:31:17 -0500
Subject: cifs causes high system load avg, oopses when unloaded on
	2.6.0-test11
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-cifs-client@lists.samba.org, wli@holomorphy.com, darren@dmdtech.org
Content-Type: text/plain
Organization: IBM
Message-Id: <1071609977.1806.27.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 16 Dec 2003 15:26:17 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Using CIFS causes a very high load average (approx. 12 according to
>> After I umout all filesystems (CIFS ones) and then unload the module,
>> it oopses (below).
>> CC me replies if more information is needed.

I don't know if this will fail with the more current (version 0.99 of 
the 2.6 version of the cifs filesystem) which is at
http://us1.samba.org/samba/ftp/cifs-cvs/cifs-0.9.9-2.6kern.tar.gz
but I am trying some experiments today to see if I can reproduce
something similar artificially.  I was concerned about some other oopses
and problems in the tcp reconnection logic that are now fixed but are in
the much older version 0.94 of the cifs vfs in the
linux.bkbits.net/linux-2.5 tree but as 2.6 has been mostly locked down
for weeks - test11 is missing at least a dozen key cifs fixes (including
stress test fixes and fixes for a few oopses reported by 2.6 users
testing more actively over the past couple months), the more recent
fs/cifs files (version 0.9.9) are likely to be much better than what is
in 2.6-test11

(the gz simply contains the contents of the 0.9.9 version of the fs/cifs
directory, rather than a patch (about 15 changesets ahead of 2.6test9,10
or 11).  There are no corequisite fixes outside the directory and it can
be applied to any of the recent 2.6-test* versions)

> Hmm, this unload needs to hand back failure to module unload when it>>
> can't nuke inodes etc. I'd suggest not using it as a module for the
> time being.

I don't see how I could pass failure back on module unload even if I
could detect problems freeing the memory associated with cifs's inode
cache - there is no place for return code info - see the caller ie the
call to mod->exit() in sys_delete_module (about line 735 of
kernel/module.c)


