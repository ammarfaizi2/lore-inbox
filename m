Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTFPKkw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 06:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbTFPKkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 06:40:52 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:9995 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S263705AbTFPKkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 06:40:00 -0400
Date: Mon, 16 Jun 2003 12:54:24 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: "Seifert Guido, gse" <Guido.Seifert@pentapharm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5.71 cannot unmount nfs
In-Reply-To: <0557B834CB410E4EB692BC78504D4C2C02F3EC@dc0011.pefade.pefa.local>
Message-ID: <Pine.LNX.4.44.0306161228110.2079-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003, Seifert Guido, gse wrote:

> 
> Sorry for the incomplete and unprofessional bugreport, I don't have more
> info.  I tried Kernel 2.5.71. Everything seems to work fine until I shut
> down or try to unmount a mountend nfs filesystem. For several minutes
> nothing happens, then I get something what looks like a backtrace from
> the nfs related code section. Unfortunately there is nothing in the log
> files afterwards.  G.

If the backtrace looks similar to this one:

Pid: 6820, comm:               umount
EIP: 0060:[<c01bbfb9>] CPU: 0
EIP is at atomic_dec_and_lock+0x99/0x9b
 EFLAGS: 00000246    Not tainted
EAX: 00000000 EBX: c387a48c ECX: ddf35348 EDX: ddf35348
ESI: c03173a0 EDI: c387a48c EBP: c387a4a8 DS: 007b ES: 007b
CR0: 8005003b CR2: 40018000 CR3: 03040000 CR4: 00000010
Call Trace:
 [<c0170d3c>] dput+0x1c/0x280
 [<c0170d22>] dput+0x2/0x280
 [<cc8d02ac>] rpc_depopulate+0x16c/0x190 [sunrpc]
 [<cc8d078e>] rpc_rmdir+0x5e/0x90 [sunrpc]
 [<cc8f6ce0>] nfs_sops+0x0/0x60 [nfs]
 [<cc8c02fb>] rpc_destroy_client+0x4b/0x70 [sunrpc]
 [<cc8e3767>] nfs_put_super+0x17/0x40 [nfs]
 [<c015f34a>] generic_shutdown_super+0xda/0x210
 [<cc8f6e00>] nfs_fs_type+0x0/0x20 [nfs]
 [<c016009f>] kill_anon_super+0xf/0x80
 [<cc8e5b51>] nfs_kill_super+0x11/0x20 [nfs]
 [<c015f030>] deactivate_super+0x80/0x110
 [<c01771f7>] __mntput+0x17/0x30
 [<c0166f48>] path_release+0x28/0x30
 [<c0177b4b>] sys_umount+0x7b/0x90
 [<c0177b6b>] sys_oldumount+0xb/0x10
 [<c01093b7>] syscall_call+0x7/0xb


... then you'll probably need the following patch:

<http://marc.theaimsgroup.com/?l=linux-kernel&m=105566442521995&w=2>

HTH
Martin

