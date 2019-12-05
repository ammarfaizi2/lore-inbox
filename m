Return-Path: <SRS0=lMt9=Z3=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53014C43603
	for <io-uring@archiver.kernel.org>; Thu,  5 Dec 2019 00:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221DD2073B
	for <io-uring@archiver.kernel.org>; Thu,  5 Dec 2019 00:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vGlSmrgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfLEA06 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:26:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37553 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbfLEA05 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 4 Dec 2019 19:26:57 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so692851pga.4
        for <io-uring@vger.kernel.org>; Wed, 04 Dec 2019 16:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=byfPQTF6cxjG/wUIalv4BGFlnuTrqJEKuGcLdysHY28=;
        b=vGlSmrgAOCCMJLAiSWf95bTr0n0cvwxuOk53hT10xJzLS1REVhuwvHfkmIkSnyURdW
         py8c2IspfqgH+MmDvX/gfIAJ/nVMC+Tv9si+4Zx3WobYki94M7CgIqd1Gg8Xhe2nReKg
         FdT6pxmluU3imY1NyHEGBB7ex/45qus+Xl9r9vEChIjrnA5UHzdgafoEehZxx+11DgbD
         SLmhpIZTLha+MlFrrIF8SWmc5rAkssXeGOZmVZlNEHNSkY3oFdCKd0oXSBKhm3UbXAoL
         OchekUvSDla5Xy3lPqjYsGi5r9I1xbpc68NVQYRY601yi2JPU3DDUiKbxu4htLmzoOZX
         W0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=byfPQTF6cxjG/wUIalv4BGFlnuTrqJEKuGcLdysHY28=;
        b=jH1+3TwDm7XXyFaxtptcEt2o7ONey2XoMR3tVuatixsdW0CrDf3QZf11S//+Z0GN8V
         8U36CFltRF3Co8+OSSTXH3s1dWiufUm3xtOWV59xhZPGxWsMyi2dw1KzgY113NqR9SQM
         /HkY81PaS9QnAcvTGE6qo+j23Zc3v3B74UVQracarZFscm1i85DkhkZJeFVYdB9dt/67
         aowsaLDHjzlM9YX5DqcY2muDLDyPKUljiW1nw0+78bbtUSE86PwkDJJf4hIqFPBkX3Rn
         iR/mPT51YM2qc7DaTtUzpjxYnEqcnsW3HX9L2OmbuU2p2lMF+7M9bOcDdDOvioXUOZ2g
         9jUg==
X-Gm-Message-State: APjAAAWSzvxbkgJ45Z+ScvjiRW683ZDxUuio2gMxeE0HwSbESi7NCv8c
        s1ot8aFMkHWoqmvAFb3G1fe8tg==
X-Google-Smtp-Source: APXvYqzcfVeqVE7IIlBY5xfRZUjUtWeoQjZ3S6vy6XfaOMcpQOgHrZhtNh0l71CfYRyhb3R8PuhZyQ==
X-Received: by 2002:a62:5485:: with SMTP id i127mr4072847pfb.186.1575505616816;
        Wed, 04 Dec 2019 16:26:56 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1133::1342? ([2620:10d:c090:180::b80d])
        by smtp.gmail.com with ESMTPSA id e4sm9945115pfj.125.2019.12.04.16.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 16:26:55 -0800 (PST)
To:     io-uring <io-uring@vger.kernel.org>
Cc:     Dan Melnic <dmm@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io-wq: clear node->next on list deletion
Message-ID: <d460a0ba-051e-57fa-86f6-32c6e4e29b09@kernel.dk>
Date:   Wed, 4 Dec 2019 17:26:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

If someone removes a node from a list, and then later adds it back to
a list, we can have invalid data in ->next. This can cause all sorts
of issues. One such use case is the IORING_OP_POLL_ADD command, which
will do just that if we race and get woken twice without any pending
events. This is a pretty rare case, but can happen under extreme loads.
Dan reports that he saw the following crash:

BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD d283ce067 P4D d283ce067 PUD e5ca04067 PMD 0
Oops: 0002 [#1] SMP
CPU: 17 PID: 10726 Comm: tao:fast-fiber Kdump: loaded Not tainted 5.2.9-02851-gac7bc042d2d1 #116
Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A17 05/03/2019
RIP: 0010:io_wqe_enqueue+0x3e/0xd0
Code: 34 24 74 55 8b 47 58 48 8d 6f 50 85 c0 74 50 48 89 df e8 35 7c 75 00 48 83 7b 08 00 48 8b 14 24 0f 84 84 00 00 00 48 8b 4b 10 <48> 89 11 48 89 53 10 83 63 20 fe 48 89 c6 48 89 df e8 0c 7a 75 00
RSP: 0000:ffffc90006858a08 EFLAGS: 00010082
RAX: 0000000000000002 RBX: ffff889037492fc0 RCX: 0000000000000000
RDX: ffff888e40cc11a8 RSI: ffff888e40cc11a8 RDI: ffff889037492fc0
RBP: ffff889037493010 R08: 00000000000000c3 R09: ffffc90006858ab8
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888e40cc11a8
R13: 0000000000000000 R14: 00000000000000c3 R15: ffff888e40cc1100
FS:  00007fcddc9db700(0000) GS:ffff88903fa40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000e479f5003 CR4: 00000000007606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <IRQ>
 io_poll_wake+0x12f/0x2a0
 __wake_up_common+0x86/0x120
 __wake_up_common_lock+0x7a/0xc0
 sock_def_readable+0x3c/0x70
 tcp_rcv_established+0x557/0x630
 tcp_v6_do_rcv+0x118/0x3c0
 tcp_v6_rcv+0x97e/0x9d0
 ip6_protocol_deliver_rcu+0xe3/0x440
 ip6_input+0x3d/0xc0
 ? ip6_protocol_deliver_rcu+0x440/0x440
 ipv6_rcv+0x56/0xd0
 ? ip6_rcv_finish_core.isra.18+0x80/0x80
 __netif_receive_skb_one_core+0x50/0x70
 netif_receive_skb_internal+0x2f/0xa0
 napi_gro_receive+0x125/0x150
 mlx5e_handle_rx_cqe+0x1d9/0x5a0
 ? mlx5e_poll_tx_cq+0x305/0x560
 mlx5e_poll_rx_cq+0x49f/0x9c5
 mlx5e_napi_poll+0xee/0x640
 ? smp_reschedule_interrupt+0x16/0xd0
 ? reschedule_interrupt+0xf/0x20
 net_rx_action+0x286/0x3d0
 __do_softirq+0xca/0x297
 irq_exit+0x96/0xa0
 do_IRQ+0x54/0xe0
 common_interrupt+0xf/0xf
 </IRQ>
RIP: 0033:0x7fdc627a2e3a
Code: 31 c0 85 d2 0f 88 f6 00 00 00 55 48 89 e5 41 57 41 56 4c 63 f2 41 55 41 54 53 48 83 ec 18 48 85 ff 0f 84 c7 00 00 00 48 8b 07 <41> 89 d4 49 89 f5 48 89 fb 48 85 c0 0f 84 64 01 00 00 48 83 78 10

when running a networked workload with about 5000 sockets being polled
for. Fix this by clearing node->next when the node is being removed from
the list.

Fixes: 6206f0e180d4 ("io-wq: shrink io_wq_work a bit")
Reported-by: Dan Melnic <dmm@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io-wq.h b/fs/io-wq.h
index 892db0bb64b1..7c333a28e2a7 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -52,6 +52,7 @@ static inline void wq_node_del(struct io_wq_work_list *list,
 		list->last = prev;
 	if (prev)
 		prev->next = node->next;
+	node->next = NULL;
 }
 
 #define wq_list_for_each(pos, prv, head)			\

-- 
Jens Axboe

