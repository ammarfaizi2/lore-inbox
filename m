Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVGKGjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVGKGjE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 02:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVGKGjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 02:39:04 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:55450 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262266AbVGKGhb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 02:37:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mfbdKQevhwvTx1q9Skn36wyLenrL85lah9YNTFFdHWkdB52yuQ1Gxxck+H6Hn/3cNLWnyrj2FphPpRUTJiKKbMjKxGzrGNCbrpOTLaYy+qiyuENSiuQyiZr6OzvHQxBS9BRPSKqrt/vCYH7xyaS5MXyWUdcNK7gNltkDNm76e60=
Message-ID: <4ae3c14050710233714a37814@mail.gmail.com>
Date: Mon, 11 Jul 2005 02:37:31 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: NFS and RPC question under kernel 2.6
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this question is dumb.

I am trying to modify NFS to add some more features. I changed the
rpc_clnt struct in include/linux/sunrpc/clnt.h to add some more
fields:

vrpc_comm_t		*cl_comm;
wait_queue_head_t 		cl_callwaitq[MAX_PENDING_REQS];
int 					cl_blocked[MAX_PENDING_REQS]; /* indicates whether a request
is blocked */
svdif_response_t		cl_resp_ring[MAX_PENDING_REQS];

I tried to initialise those fields in  nfs_fill_super function, but
once those initialization codes are executed, if a nfs client tries to
mount a directory, its underlying linux  will crash with the following
dump out:

Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
d085ff29
*pde = ma 00000000 pa 55555000
 [<c01e5564>] snprintf+0x27/0x2b
 [<d086002b>] nfs_sb_init+0x9a/0x527 [nfs]
 [<d08344c6>] unx_create+0x4e/0x6b [sunrpc]
 [<d08338cb>] rpcauth_create+0x6a/0xb1 [sunrpc]
 [<d082e212>] rpc_create_client+0x18a/0x269 [sunrpc]
 [<d086057c>] nfs_create_client+0xc4/0x138 [nfs]
 [<d084f4bb>] lockd_up+0xd0/0x13d [lockd]
 [<d08608ce>] nfs_fill_super+0x2de/0x36c [nfs]
 [<d0862821>] nfs_get_sb+0x231/0x265 [nfs]
 [<c0158cdc>] do_kern_mount+0x4f/0xc5
 [<c016dfd4>] do_new_mount+0x82/0xc3
 [<c016e687>] do_mount+0x179/0x197
 [<c016e4c3>] copy_mount_options+0x54/0x9f
 [<c016ea38>] sys_mount+0x9f/0xe0
 [<c0108e2c>] syscall_call+0x7/0xb

My initialization codes work well on kernel 2.4, but do not work on
2.6. :( I was stuck on this problem for a couple of days.

Can someone help me out? Many thanks in advance!!!

BTW: after I change clnt.h, I recompiled the kernel and restart the
machine, so kernel should know rpc_clnt struct is changed.

-x
