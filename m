Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVFEPDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVFEPDm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 11:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVFEPDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 11:03:42 -0400
Received: from dvhart.com ([64.146.134.43]:55463 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261582AbVFEPD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 11:03:28 -0400
Date: Sun, 05 Jun 2005 08:02:21 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12?
Message-ID: <418760000.1117983740@[10.10.2.4]>
In-Reply-To: <20050604151120.46b51901.akpm@osdl.org>
References: <42A0D88E.7070406@pobox.com><20050603163843.1cf5045d.akpm@osdl.org><394120000.1117895039@[10.10.2.4]> <20050604151120.46b51901.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Andrew Morton <akpm@osdl.org> wrote (on Saturday, June 04, 2005 15:11:20 -0700):

> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
>> 
>> The one that worries me is that my x86_64 box won't boot since -rc3
>>  See:
>> 
>>  http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html
> 
> All the MPT_FUSION config variables got renamed, so a simple `make
> oldconfig' results in a kernel qhich does precisely what your machine is
> doing there.

Not sure what you mean. 2.6.11 has (in drivers/message/fusion/Kconfig)

config FUSION
config FUSION_MAX_SGE
config FUSION_CTL
config FUSION_LAN

2.6.12-rc3 has:

config FUSION
config FUSION_MAX_SGE
config FUSION_CTL
config FUSION_LAN

So I don't think they changed, AFAICS. The config in question has:

CONFIG_FUSION=y
CONFIG_FUSION_MAX_SGE=40
# CONFIG_FUSION_CTL is not set
# CONFIG_SOUND_FUSION is not set

And I'd backed out the rc3 drivers to rc2 (the whole of drivers/message/fusion)
and it doesn't fix it.

I also get several different failure modes, in different trees, one of
which is:

^M^@Testing NMI watchdog ... <3>BUG: soft lockup detected on CPU#3!
^M
^M^@Modules linked in:
^M^@Pid: 1, comm: swapper Not tainted 2.6.12-rc2-mm2-autokern1
^M^@RIP: 0010:[<ffffffff80254eda>] <ffffffff80254eda>{__delay+10}
^M^@RSP: 0000:ffff8100e3f23f00  EFLAGS: 00000216
^M^@RAX: 00000000001b144e RBX: ffffffff801af3d7 RCX: 000000007c1f2aa5
^M^@RDX: 000000000000006b RSI: 0000000000000008 RDI: 00000000001b4c48
^M^@RBP: 0000ffffffff8010 R08: 0000000000000720 R09: ffff8100e3f543e8
^M^@R10: 00000000001d92d4 R11: ffffffff8025aa40 R12: ffff8100e3f543e8
^M^@R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000002
^M^@FS:  0000000000000000(0000) GS:ffffffff804dfe00(0000) knlGS:0000000000000000
^M^@CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
^M^@CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006e0
^M
^M^@Call Trace:<ffffffff804f3b15>{check_nmi_watchdog+181} <ffffffff8010c249>{ini
t+505}
^M^@       <ffffffff8010f3ff>{child_rip+8} <ffffffff8010c050>{init+0}
^M^@       <ffffffff8010f3f7>{child_rip+0} 
^M^@CPU#0: NMI appears to be stuck (24)!

