Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315517AbSGAMdt>; Mon, 1 Jul 2002 08:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315525AbSGAMds>; Mon, 1 Jul 2002 08:33:48 -0400
Received: from mons.uio.no ([129.240.130.14]:1949 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S315517AbSGAMdr>;
	Mon, 1 Jul 2002 08:33:47 -0400
To: "Nicholas L. Nigay" <nnigay@cboss.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: oops 2.4.19-rc1 process lockd ( part 3 : no vmware )]
References: <3D203E6B.4010300@cboss.ru>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 01 Jul 2002 14:36:02 +0200
In-Reply-To: <3D203E6B.4010300@cboss.ru>
Message-ID: <shs4rfjsk0d.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Nicholas L Nigay <nnigay@cboss.ru> writes:

    >>> EIP; c02ac415 <xdr_encode_netobj+15/4c> <=====

    >>> eax; 300c9800 Before first symbol ebx; cb4e6058
    >>> <_end+b13cd48/1047fcf0> ecx; cb4e6058 <_end+b13cd48/1047fcf0>
    >>> edx; cc99be64 <_end+c5f2b54/1047fcf0> esi; cc99be6c
    >>> <_end+c5f2b5c/1047fcf0> edi; c0186fc8
    >>> <nlm4clt_encode_testres+0/30> ebp; cc400900
    >>> <_end+c0575f0/1047fcf0> esp; cd319d94 <_end+cf70a84/1047fcf0>

     > Trace; c0186fc8 <nlm4clt_encode_testres+0/30> Trace; c0186719
     > <nlm4_encode_testres+89/1f0> Trace; c0186fc8
     > <nlm4clt_encode_testres+0/30> Trace; c0186fdc
     > <nlm4clt_encode_testres+14/30> Trace; c02a47fc
     > <call_encode+d8/104> Trace; c02a79ac <__rpc_execute+a8/2bc>
     > Trace; c02a4496 <rpc_call_setup+3e/70> Trace; c02a7c17
     > <rpc_execute+57/70> Trace; c02a4431 <rpc_call_async+7d/a4>
     > Trace; c018168a <nlmsvc_async_call+82/98> Trace; c0187a0c
     > <nlm4svc_callback_exit+0/54> Trace; c01879e7
     > <nlm4svc_callback+73/98> Trace; c0187a0c
     > <nlm4svc_callback_exit+0/54> Trace; c01874e8
     > <nlm4svc_proc_test_msg+48/54> Trace; c026a316
     > <inet_sendmsg+3a/40> Trace; c0237065 <sock_sendmsg+69/88>
     > Trace; c0186417 <nlm4_decode_oh+f/14> Trace; c018647c
     > <nlm4_decode_lock+4c/130> Trace; c018649a
     > <nlm4_decode_lock+6a/130> Trace; c018691a
     > <nlm4svc_decode_testargs+4e/54> Trace; c02a9d81
     > <svc_process+219/4d8> Trace; c018278e <lockd+19a/254> Trace;
     > c0107028 <kernel_thread+28/38>

Patch appended...

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.18/fs/lockd/svc4proc.c linux-2.4.18-fix_lock/fs/lockd/svc4proc.c
--- linux-2.4.18/fs/lockd/svc4proc.c	Mon Oct  1 22:45:47 2001
+++ linux-2.4.18-fix_lock/fs/lockd/svc4proc.c	Tue Apr 23 11:00:59 2002
@@ -254,6 +254,7 @@
 
 	dprintk("lockd: TEST_MSG      called\n");
 
+	memset(&res, 0, sizeof(res));
 	if ((stat = nlm4svc_proc_test(rqstp, argp, &res)) == 0)
 		stat = nlm4svc_callback(rqstp, NLMPROC_TEST_RES, &res);
 	return stat;
diff -u --recursive --new-file linux-2.4.18/fs/lockd/svcproc.c linux-2.4.18-fix_lock/fs/lockd/svcproc.c
--- linux-2.4.18/fs/lockd/svcproc.c	Thu Oct 11 16:52:18 2001
+++ linux-2.4.18-fix_lock/fs/lockd/svcproc.c	Tue Apr 23 11:01:10 2002
@@ -282,6 +282,7 @@
 
 	dprintk("lockd: TEST_MSG      called\n");
 
+	memset(&res, 0, sizeof(res));
 	if ((stat = nlmsvc_proc_test(rqstp, argp, &res)) == 0)
 		stat = nlmsvc_callback(rqstp, NLMPROC_TEST_RES, &res);
 	return stat;
