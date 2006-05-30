Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWE3Von@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWE3Von (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWE3Von
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:44:43 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:51859 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S932501AbWE3Vom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:44:42 -0400
Message-ID: <00b901c68432$35aded60$1800a8c0@dcccs>
From: "Janos Haar" <djani22@netcenter.hu>
To: <Valdis.Kletnieks@vt.edu>
Cc: <jesper.juhl@gmail.com>, <linux-kernel@vger.kernel.org>
References: <01b701c6818d$4bcd37b0$1800a8c0@dcccs> <20060527234350.GA13881@voodoo.jdc.home> <004501c68225$00add170$1800a8c0@dcccs> <9a8748490605280917l73f5751cmf40674fc22726c43@mail.gmail.com> <01d801c6827c$fba04ca0$1800a8c0@dcccs>            <01a801c683d2$e7a79c10$1800a8c0@dcccs> <200605301903.k4UJ3xQU008919@turing-police.cc.vt.edu>
Subject: Re: How to send a break? - dump from frozen 64bit linux
Date: Tue, 30 May 2006 23:44:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 30 May 2006 12:22:01 +0200, Janos Haar said:
>
> > http://download.netcenter.hu/bughunt/20060530/dump.txt  (The frozen
system,
> > 540KB)
>
> > Can somebody tell me, whats wrong?

> kblockd/1     D ffff81011f641778     0    25     19            26    24
(L-TLB)
> ffff81011f641778 0000000000000000 0000000000000009 ffff81011f735358
>        ffff81011f735140 ffff81011fc79100 000014a00f9a0ef2 00000000000410dd
>        0000000102866d40 ffff810003900280
> Call Trace: <ffffffff8026d72a>{xfs_qm_shake+135}
<ffffffff804e6046>{__mutex_lock_slowpath+424}
>        <ffffffff804e62e4>{mutex_lock+41}
<ffffffff8026d72a>{xfs_qm_shake+135}
>        <ffffffff80157cfd>{shrink_slab+100}
<ffffffff801584d9>{try_to_free_pages+372}
>        <ffffffff80153c3f>{__alloc_pages+432}
<ffffffff8046aef3>{tcp_sendmsg+1373}
>        <ffffffff804848ad>{inet_sendmsg+70}
<ffffffff8043f619>{sock_sendmsg+270}
>      <ffffffff8013d3e0>{autoremove_wake_function+0}
<ffffffff80440db3>{kernel_sendmsg+61}
>        <ffffffff8802c111>{:nbd:sock_xmit+273}
<ffffffff8015195d>{mempool_alloc_slab+17}
>        <ffffffff80169b1b>{poison_obj+39}
<ffffffff8015195d>{mempool_alloc_slab+17}
>        <ffffffff80169c11>{cache_alloc_debugcheck_after+235}
>        <ffffffff8015195d>{mempool_alloc_slab+17}
<ffffffff802da471>{as_remove_queued_request+267}
>        <ffffffff8802c472>{:nbd:nbd_send_req+517}
<ffffffff8802c712>{:nbd:do_nbd_request+329}
>        <ffffffff802d9b45>{as_work_handler+46}
<ffffffff80139d30>{run_workqueue+168}
>        <ffffffff802d9b17>{as_work_handler+0}
<ffffffff8013a27f>{worker_thread+0}
>        <ffffffff8013a383>{worker_thread+260}
<ffffffff80123fa4>{default_wake_function+0}
>        <ffffffff8013a27f>{worker_thread+0} <ffffffff8013d29f>{kthread+219}
>        <ffffffff8012590d>{schedule_tail+70}
<ffffffff8010bba6>{child_rip+8}
>        <ffffffff8013d1c4>{kthread+0} <ffffffff8010bb9e>{child_rip+0}
>
> Half the processes on the box seem wedged at that same mutex_lock. I can't
> seem to find an xfs_qm_shake in my source tree though.

The XFS, what i use is the default on the 2.6.16.18.
Anyway, the 2.6.16.18 is unpatched, i can use it from the original source.
This kernel already know what i need.
I only use this external module:
e1000-7.0.33

The XFS parts:

acl-2.2.34
attr-2.4.28
dmapi-2.2.3
xfsdump-2.2.33
xfsprogs-2.7.11


Sorry, but i cannot understand the mutex and lock, this is bad thing in this
dump? :-)

Anyway, this issue since then i step from i686 to X86_64!
I have upgrade the OS from rh9.0 to FC 5, and i had recompile to 64bit ALL
of the services, what i need to use.
(Kernel, apache, mysql+lib+client,pure-ftpd, nbd-client, xfs, php+libs)

Why doing this?
Because i need to use >2TB nbd-devices, and the nbd-client refused to use
them on 32bit. :-(
After i upgrade to X86_64, i have upgrade my huge device from 8TB to 14TB.
(And on XFS, there is no way to shrink back...)

Another useful info:
If this issue happens, i always use the reset button, or the sysreq-boot
with the serial cable.
During the reboot, the rc script runs the xfs_repair on my 2 general device,
and i can see, both are clean!
This shows, the kernel can flush the buffers using  nbd, and sata (libata)!
The NFS-ROOT can not to be unclean. :-)

Cheers,
Janos

