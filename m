Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVETOah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVETOah (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 10:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVETOah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 10:30:37 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:45585 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261323AbVETOaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 10:30:22 -0400
Message-Id: <200505201430.j4KEUFD0012985@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context at mm/slab.c:2502 
In-Reply-To: Your message of "Thu, 19 May 2005 14:45:31 EDT."
             <200505191845.j4JIjVtq006262@turing-police.cc.vt.edu> 
From: Valdis.Kletnieks@vt.edu
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu> <1116502449.23972.207.camel@hades.cambridge.redhat.com>
            <200505191845.j4JIjVtq006262@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116599414_10327P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 20 May 2005 10:30:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116599414_10327P
Content-Type: text/plain; charset=us-ascii

On Thu, 19 May 2005 14:45:31 EDT, Valdis.Kletnieks@vt.edu said:

> > Index: kernel/audit.c
> > ===================================================================
> > --- e45ee43e7af31f847377e8bb3a0a61581732b653/kernel/audit.c  (mode:100644)
> > +++ c1096ff7ae35b77bf8108c3a60b856551c50a9d7/kernel/audit.c  (mode:100644)
> 
> Patch applies with a few offsets against 12-rc4-mm2, and I'm not
> seeing the messages any more...

Looks like we either only swatted half the bug, or the patch moved it around.
Slightly different trace this time:

May 20 09:28:22 turing-police kernel: [4294758.508000] audit(1116595648.944:0): avc:  denied  { write } for  name=X0 dev=tmpfs in
o=5682 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:initrc_tmp_t tclass=sock_file
May 20 09:28:22 turing-police kernel: [4294758.508000] Debug: sleeping function called from invalid context at mm/slab.c:2502
May 20 09:28:22 turing-police kernel: [4294758.508000] in_atomic():1, irqs_disabled():0
May 20 09:28:22 turing-police kernel: [4294758.508000]  [dump_stack+21/23] dump_stack+0x15/0x17
May 20 09:28:22 turing-police kernel: [4294758.508000]  [kmem_cache_alloc+30/106] kmem_cache_alloc+0x1e/0x6a
May 20 09:28:22 turing-police kernel: [4294758.508000]  [audit_log_d_path+49/139] audit_log_d_path+0x31/0x8b
May 20 09:28:22 turing-police kernel: [4294758.508000]  [avc_audit+1418/2392] avc_audit+0x58a/0x958
May 20 09:28:22 turing-police kernel: [4294758.508000]  [avc_has_perm+59/72] avc_has_perm+0x3b/0x48
May 20 09:28:22 turing-police kernel: [4294758.508000]  [selinux_socket_unix_stream_connect+111/168] selinux_socket_unix_stream_c
onnect+0x6f/0xa8
May 20 09:28:22 turing-police kernel: [4294758.508000]  [unix_stream_connect+552/1154] unix_stream_connect+0x228/0x482
May 20 09:28:22 turing-police kernel: [4294758.508000]  [sys_connect+106/129] sys_connect+0x6a/0x81
May 20 09:28:22 turing-police kernel: [4294758.508000]  [sys_socketcall+111/358] sys_socketcall+0x6f/0x166
May 20 09:28:22 turing-police kernel: [4294758.508000]  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May 20 09:28:22 turing-police kernel: [4294758.508000] audit(1116595648.944:0): avc:  denied  { connectto } for  path="/tmp/.X11-
unix/X0" scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:xdm_xserver_t tclass=unix_stream_socket
...
May 20 09:32:38 turing-police kernel: [4295068.589000] Debug: sleeping function called from invalid context at mm/slab.c:2502
May 20 09:32:38 turing-police kernel: [4295068.589000] in_atomic():1, irqs_disabled():0
May 20 09:32:38 turing-police kernel: [4295068.589000]  [dump_stack+21/23] dump_stack+0x15/0x17
May 20 09:32:38 turing-police kernel: [4295068.589000]  [kmem_cache_alloc+30/106] kmem_cache_alloc+0x1e/0x6a
May 20 09:32:38 turing-police kernel: [4295068.589000]  [audit_log_d_path+49/139] audit_log_d_path+0x31/0x8b
May 20 09:32:38 turing-police kernel: [4295068.589000]  [avc_audit+1418/2392] avc_audit+0x58a/0x958
May 20 09:32:38 turing-police kernel: [4295068.589000]  [avc_has_perm+59/72] avc_has_perm+0x3b/0x48
May 20 09:32:38 turing-police kernel: [4295068.589000]  [selinux_socket_unix_stream_connect+111/168] selinux_socket_unix_stream_c
onnect+0x6f/0xa8
May 20 09:32:38 turing-police kernel: [4295068.589000]  [unix_stream_connect+552/1154] unix_stream_connect+0x228/0x482
May 20 09:32:38 turing-police kernel: [4295068.589000]  [sys_connect+106/129] sys_connect+0x6a/0x81
May 20 09:32:38 turing-police kernel: [4295068.589000]  [sys_socketcall+111/358] sys_socketcall+0x6f/0x166
May 20 09:32:38 turing-police kernel: [4295068.589000]  [syscall_call+7/11] syscall_call+0x7/0xb
May 20 09:32:52 turing-police kernel: [4295082.517000] Debug: sleeping function called from invalid context at mm/slab.c:2502
May 20 09:32:52 turing-police kernel: [4295082.517000] in_atomic():1, irqs_disabled():0
May 20 09:32:52 turing-police kernel: [4295082.517000]  [dump_stack+21/23] dump_stack+0x15/0x17
May 20 09:32:52 turing-police kernel: [4295082.517000]  [kmem_cache_alloc+30/106] kmem_cache_alloc+0x1e/0x6a
May 20 09:32:52 turing-police kernel: [4295082.517000]  [audit_log_d_path+49/139] audit_log_d_path+0x31/0x8b
May 20 09:32:52 turing-police kernel: [4295082.517000]  [avc_audit+1418/2392] avc_audit+0x58a/0x958
May 20 09:32:52 turing-police kernel: [4295082.517000]  [avc_has_perm+59/72] avc_has_perm+0x3b/0x48
May 20 09:32:52 turing-police kernel: [4295082.517000]  [selinux_socket_unix_stream_connect+111/168] selinux_socket_unix_stream_c
onnect+0x6f/0xa8
May 20 09:32:52 turing-police kernel: [4295082.517000]  [unix_stream_connect+552/1154] unix_stream_connect+0x228/0x482
May 20 09:32:52 turing-police kernel: [4295082.518000]  [sys_connect+106/129] sys_connect+0x6a/0x81
May 20 09:32:52 turing-police kernel: [4295082.518000]  [sys_socketcall+111/358] sys_socketcall+0x6f/0x166
May 20 09:32:52 turing-police kernel: [4295082.518000]  [syscall_call+7/11] syscall_call+0x7/0xb


--==_Exmh_1116599414_10327P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCjfR2cC3lWbTT17ARAupmAJ4z3YhfrrYUvYx5JRFDzSxT97KhHgCg+H/X
tkHLA7SKLWdERQ9WOvJr1pU=
=FFhe
-----END PGP SIGNATURE-----

--==_Exmh_1116599414_10327P--
