Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265012AbUELDZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265012AbUELDZJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 23:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264963AbUELDZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 23:25:09 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:56781 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S264962AbUELDY2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 23:24:28 -0400
From: Andy Lutomirski <luto@myrealbox.com>
To: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] capabilities
Date: Tue, 11 May 2004 20:24:22 -0700
User-Agent: KMail/1.6.2
Cc: luto@myrealbox.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405112024.22097.luto@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This reintroduces useful capabilities.

In this model, the inheritable mask is a limit on what capabilities
the task or any of its children may have.  Permitted and effective masks
have their old meanings.

Init gets all capabilities (even CAP_SETPCAP) since it seems absurd to do
otherwise.

Part 1 shouldn't change user-visible behavior; it just moves the vfs
capability logic into fs/exec.c (where it IMHO belongs) and the setuid
logic into apply_creds (where it IMHO belongs).  I made no effort to
make apply_creds pretty since it all gets deleted in the next patch
anyway.

Part 2 redoes the capability logic.

This code is paranoid about setuid.  A later patch will allow that to
be overridden by a sysctl so that securelevel can be done usefully.

I left cap_bset in, even though I can't see a use for it anymore.

I put some user tools at http://www.stanford.edu/~luto/cap/; I've used
themn to exercise this code somewhat.

It applies to 2.6.6-mm1.  It does _not_ apply to 2.6.6 vanilla, but the fix
should be trivial (it conflicts with something in fs/exec.c).  It will not
apply to earlier versions, as it depends on the compute_creds race fix.

Please let me know what you think and if you see any holes in this code
or possibilities of exposing / introducing bugs in other programs (think
Sendmail bug).

This should also eliminate the Oracle magic-group mess :)

Andrew- is this sufficiently non-scary for -mm?

Where this is going:
There is probably some dead code now in sys_capset.  I'll check on that.
Also, I have an ext3 xattr caps patch lying around somewhere.  I can try
to get it working again.

--Andy


