Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbUKRDI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbUKRDI2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 22:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUKRDI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 22:08:27 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:21921 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262387AbUKRDIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 22:08:20 -0500
Date: Thu, 18 Nov 2004 04:08:18 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, ak@suse.de, 76306.1226@compuserve.com,
       linux-kernel@vger.kernel.org
Subject: Re: Dropped patch: mm/mempolicy.c:sp_lookup()
Message-ID: <20041118030818.GE28571@dualathlon.random>
References: <20041117111336.608409ef.akpm@osdl.org> <Pine.LNX.4.44.0411171938210.1809-100000@localhost.localdomain> <20041117122123.6162fa70.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117122123.6162fa70.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 12:21:23PM -0800, Andrew Morton wrote:
> Sigh.  OK, I'll split the patch into three and will feed the `<=' fix and
> the symlink fix into 2.6.10. [..]

thanks.

> [..] The mempolicy optimisation can await 2.6.11.

sure.

About Hugh's version of the shmem.c part, I'm fine with it, but I find
more robust to destroy the mpol in the delete_inode callback than in
delete_inode (for shmfs is the same due the dcache pin), since delete_inode
is normally associated with the unlink operation, but the mpol must go
away before the inode is freed, and the inode is freed in the
destroy_inode (again for shmfs it's the same as delete_inode), plus I
find my version a bit simpler.

As Hugh said as far as one of the two ges merged I'm fine of course ;).
