Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUJLSCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUJLSCY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 14:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUJLSCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 14:02:24 -0400
Received: from mailhub.fr.lyceu.net ([213.193.0.30]:36522 "EHLO
	mailhub.fr.lyceu.net") by vger.kernel.org with ESMTP
	id S266543AbUJLSCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 14:02:00 -0400
To: linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: lock issues
References: <20041011225700.GD32228@DUMA.13thfloor.at>
	<1097539708.5432.64.camel@lade.trondhjem.org>
	<20041012142916.GA8513@DUMA.13thfloor.at>
From: Olivier Poitrey <rs@rhapsodyk.net>
Date: Tue, 12 Oct 2004 19:58:58 +0200
In-Reply-To: <20041012142916.GA8513@DUMA.13thfloor.at> (Herbert Poetzl's
 message of "Tue, 12 Oct 2004 16:29:16 +0200")
Message-ID: <87is9f3jj1.fsf@ice.aspic.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> NFS v3  options should be rw,intr,tcp,nfsvers=3
> (not 100% sure)

Yeah, that's correct.

Here is the panic + trace with a vanilla kernel (no vserver patch):

Kernel panic - not syncing: Attempting to free lock with active block list
 [<c011aa15>] panic+0x55/0xe0
 [<c0168277>] fcntl_setlk64+0x137/0x2d0
 [<c010c5ac>] restore_i387_fxsave+0xac/0xb0
 [<c010c64d>] restore_i387+0x9d/0xa0
 [<c0151cd9>] fget+0x49/0x60
 [<c01635eb>] sys_fcntl64+0x4b/0xa0
 [<c010427f>] syscall_call+0x7/0xb

The panic seems to be caused by a proftpd version 1.2.9 on a Debian
Sarge. The whole distribution is mounted over NFS and both client and
server are using the 2.6.9-rc4 kernel version.

The proftpd configuration isn't that unusual except that a directory
is mounted rbinded but it doesn't seem to be the problem because I get
the same panic without it. I can provide the proftpd configuration if
needed it.

Let me know if you need some more information.

-- 
Olivier Poitrey
