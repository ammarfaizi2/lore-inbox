Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWI3WAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWI3WAr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWI3WAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:00:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:5005 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751393AbWI3WAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:00:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AYhyNkfu+Uj6XL+JdHRO793xBlP3jg310on6esXGTpvRCUgsE9bGHU0sPZZyN5eGm6zBtIDYJopLM999OtdtxXh5ZpW4FI0s8bbx7BMebvWcCS6vWS6lmT8lHS5wrgq7JYuxxasTrPEkJir+OF3dMbQSCE6zbuNykn1P0TumJko=
Message-ID: <5f3c152b0609301500l52a4c6c5o2052b88621dc7ca3@mail.gmail.com>
Date: Sun, 1 Oct 2006 00:00:45 +0200
From: "Eric Rannaud" <eric.rannaud@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       mingo@elte.hu, nagar@watson.ibm.com
In-Reply-To: <20060930140426.37918062.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
	 <20060930131310.0d6494e7.akpm@osdl.org>
	 <5f3c152b0609301352w5bc52653s3e2a28e482c7d69e@mail.gmail.com>
	 <20060930140426.37918062.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/06, Andrew Morton <akpm@osdl.org> wrote:
> You could set CONFIG_UNWIND_INFO=n and CONFIG_STACK_UNWIND=n and reenable
> lockdep.  That will a) tell us if there's some lockdep problem and b) will
> give us a clearer look at any locking problems which your kernel is
> detecting.


All right. Here is the stacktrace I get with config
CONFIG_UNWIND_INFO=n and CONFIG_STACK_UNWIND=n and v2.6.18 (all the
rest being equal  http://engm.ath.cx/kernel/config-2.6.18). (and no
freeze)


[  153.552157] BUG: warning at
kernel/lockdep.c:565/print_infinite_recursion_bug()
[  153.552252]
[  153.552253] Call Trace:
[  153.552346]  [<ffffffff8024b84d>] print_infinite_recursion_bug+0x3d/0x50
[  153.552398]  [<ffffffff8024b95f>] find_usage_backwards+0x2f/0xd0
[  153.552447]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.552496]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.552545]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.552594]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.552643]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.552704]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.552767]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.552835]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.552896]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.552958]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.553019]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.553081]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.553145]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.553206]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.553268]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.553330]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.553392]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.553454]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.553515]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.553578]  [<ffffffff8024b9c3>] find_usage_backwards+0x93/0xd0
[  153.553643]  [<ffffffff804aa97a>] trace_hardirqs_on_thunk+0x35/0x37
[  153.553706]  [<ffffffff8024c370>] check_usage+0x40/0x2b0
[  153.553768]  [<ffffffff8024dc40>] __lock_acquire+0xa50/0xd20
[  153.553830]  [<ffffffff8024de2f>] __lock_acquire+0xc3f/0xd20
[  153.553894]  [<ffffffff80227c2b>] double_rq_lock+0x2b/0x50
[  153.553955]  [<ffffffff8024e29b>] lock_acquire+0x8b/0xc0
[  153.554016]  [<ffffffff80227c2b>] double_rq_lock+0x2b/0x50
[  153.554077]  [<ffffffff804aae25>] _spin_lock+0x25/0x40
[  153.554138]  [<ffffffff80227c2b>] double_rq_lock+0x2b/0x50
[  153.554199]  [<ffffffff8022af8b>] migration_thread+0x22b/0x2e0
[  153.554260]  [<ffffffff8022ad60>] migration_thread+0x0/0x2e0
[  153.554322]  [<ffffffff80246b9a>] kthread+0xda/0x110
[  153.554384]  [<ffffffff8020aaa0>] child_rip+0xa/0x12
[  153.554443]  [<ffffffff804ab30b>] _spin_unlock_irq+0x2b/0x40
[  153.554507]  [<ffffffff8020a0dc>] restore_args+0x0/0x30
[  153.554568]  [<ffffffff80246ac0>] kthread+0x0/0x110
[  153.554628]  [<ffffffff8020aa96>] child_rip+0x0/0x12


Thanks.
er.
