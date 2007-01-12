Return-Path: <linux-kernel-owner+w=401wt.eu-S1161157AbXALW4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161157AbXALW4w (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbXALW4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:56:52 -0500
Received: from smtp23.orange.fr ([193.252.22.126]:9152 "EHLO smtp23.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161157AbXALW4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:56:51 -0500
X-ME-UUID: 20070112225648292.4772C700008C@mwinf2323.orange.fr
Message-ID: <45A81231.6040104@free.fr>
Date: Fri, 12 Jan 2007 23:56:49 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.7) Gecko/20060405 SeaMonkey/1.0.5
MIME-Version: 1.0
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: reiserfs-list@namesys.com, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.20-rc3-mm1: umount reiser4 FS stuck in D state
References: <20070104220200.ae4e9a46.akpm@osdl.org> <459F80E2.7080903@free.fr> <200701062158.06329.vs@namesys.com>
In-Reply-To: <200701062158.06329.vs@namesys.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06.01.2007 19:58, Vladimir V. Saveliev a écrit :
> Hello
> 
> On Saturday 06 January 2007 13:58, Laurent Riffard wrote:
>> Hello,
>>
>> got this with 2.6.20-rc3-mm1:
>>
>> =======================
>> SysRq : Show Blocked State
>>
>>                          free                        sibling
>>   task             PC    stack   pid father child younger older
>> umount        D C013135E  6044  1168   1150                     (NOTLB)
>>        de591ae4 00000086 de591abc c013135e dff979c8 c012a6fe 00000046 00000007 
>>        dfd94ac0 128d3000 00000026 00000000 dfd94bcc dff979c8 de591ae4 dffda038 
>>        00000002 dff979c0 dff979bc dff979c8 de591b10 c012d600 dff979f8 00000000 
>> Call Trace:
>>  [<c012d600>] synchronize_qrcu+0x70/0x8c
>>  [<c01bede4>] __make_request+0x4c/0x29b
>>  [<c01bd24b>] generic_make_request+0x1b0/0x1de
>>  [<c01bf354>] submit_bio+0xda/0xe2
>>  [<e12674bd>] write_jnodes_to_disk_extent+0x920/0x974 [reiser4]
>>  [<e12678dd>] update_journal_footer+0x29f/0x2b7 [reiser4]
>>  [<e1268b65>] write_tx_back+0x149/0x185 [reiser4]
>>  [<e126a8e7>] reiser4_write_logs+0xea4/0xfd2 [reiser4]
>>  [<e125626a>] try_commit_txnh+0x7e6/0xa4f [reiser4]
>>  [<e125661b>] reiser4_txn_end+0x148/0x3cf [reiser4]
>>  [<e12568ad>] reiser4_txn_restart+0xb/0x1a [reiser4]
>>  [<e125692f>] reiser4_txn_restart_current+0x73/0x75 [reiser4]
>>  [<e1256b89>] force_commit_atom+0x258/0x261 [reiser4]
>>  [<e1257703>] txnmgr_force_commit_all+0x406/0x697 [reiser4]
>>  [<e12e5e08>] release_format40+0x10c/0x193 [reiser4]
>>  [<e1279922>] reiser4_put_super+0x134/0x16a [reiser4]
>>  [<c015c930>] generic_shutdown_super+0x55/0xd8
>>  [<c015c9d3>] kill_block_super+0x20/0x32
>>  [<c015ca75>] deactivate_super+0x3f/0x51
>>  [<c016d903>] mntput_no_expire+0x42/0x5f
>>  [<c0160f37>] path_release_on_umount+0x15/0x18
>>  [<c016df77>] sys_umount+0x1a3/0x1cb
>>  [<c016dfb8>] sys_oldumount+0x19/0x1b
>>  [<c0103ed2>] sysenter_past_esp+0x5f/0x99
>>  =======================
>>
>> Scenario:
>> - umount a reiser4 FS (no need to write something before)
> 
> Hmm, I can not reproduce this with 2.6.20-rc3-mm1. Probably I need to config the kernel more close to your system.
> 
>> Earlier kernels were OK.

This still happens with 2.6.20-rc4-mm1...

Should I open a bug report at http://bugzilla.kernel.org?

-- 
laurent

