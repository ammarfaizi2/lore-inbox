Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbVKDQHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbVKDQHG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVKDQHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:07:06 -0500
Received: from main.gmane.org ([80.91.229.2]:35225 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932130AbVKDQHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:07:01 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Orion Poplawski <orion@cora.nwra.com>
Subject: kernel BUG at include/asm/spinlock.h 
Date: Fri, 04 Nov 2005 08:59:37 -0700
Message-ID: <dkg0hb$grk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inferno.cora.nwra.com
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Just got the following with Fedora kernel 2.6.13-1.1532_FC4smp with the
addition of the mv_sata driver.  Any help/pointers would be greatly
appreciated.

Nov  3 19:24:25 alexandria kernel: ------------[ cut here ]------------
Nov  3 19:24:25 alexandria kernel: kernel BUG at include/asm/spinlock.h:115!
Nov  3 19:24:25 alexandria kernel: invalid operand: 0000 [#1]
Nov  3 19:24:25 alexandria kernel: SMP
Nov  3 19:24:25 alexandria kernel: Modules linked in: nfs nfsd exportfs
lockd nfs_acl ipv
6 autofs4 w83627hf w83781d adm1021 i2c_sensor i2c_isa sunrpc jfs video
button battery ac
uhci_hcd hw_random i2c_i801 i2c_core shpchp eepro100 mii e1000
dm_snapshot dm_zero dm_mir
ror ext3 jbd raid5 xor raid1 dm_mod mv_sata(U) sd_mod scsi_mod
Nov  3 19:24:25 alexandria kernel: CPU:    1
Nov  3 19:24:25 alexandria kernel: EIP:    0060:[<c031808f>]    Not
tainted VLI
Nov  3 19:24:25 alexandria kernel: EFLAGS: 00010202   (2.6.13-1.1532_FC4smp)
Nov  3 19:24:25 alexandria kernel: EIP is at _spin_unlock_irq+0x25/0x2f
Nov  3 19:24:25 alexandria kernel: eax: 00000001   ebx: 00000002   ecx:
00000001   edx: f
7f6ac2c
Nov  3 19:24:25 alexandria kernel: esi: f7ee4000   edi: c1bcff9c   ebp:
da1b2080   esp: c
1bcff08
Nov  3 19:24:25 alexandria kernel: ds: 007b   es: 007b   ss: 0068
Nov  3 19:24:25 alexandria kernel: Process scsi_eh_2 (pid: 393,
threadinfo=c1bcf000 task=
f7920aa0)
Nov  3 19:24:25 alexandria kernel: Stack: f8897769 00000003 00000100
f88aace2 da1b2080 cf
b60c16 00000000 f7f6ac00
Nov  3 19:24:25 alexandria kernel:        c1bcf000 da1b2080 f7ab5500
c1bcff9c c1bcf000 f8
848ca2 f8848df0 cfb6a886
Nov  3 19:24:25 alexandria kernel:        00000000 c1bcf000 c1bcff94
f7f6ac50 f7f6ac00 00
000282 c1bcff9c f8849a9d
Nov  3 19:24:25 alexandria kernel: Call Trace:
Nov  3 19:24:25 alexandria kernel:  [<f8897769>]
mv_ial_ht_abort+0x5d/0x128 [mv_sata]
Nov  3 19:24:25 alexandria kernel:  [<f8848ca2>]
scsi_try_to_abort_cmd+0x28/0x29 [scsi_mo
d]
Nov  3 19:24:25 alexandria kernel:  [<f8848df0>]
scsi_eh_abort_cmds+0x54/0xf5 [scsi_mod]
Nov  3 19:24:25 alexandria kernel:  [<f8849a9d>]
scsi_unjam_host+0x90/0x1db [scsi_mod]
Nov  3 19:24:25 alexandria kernel:  [<c011d10d>] __wake_up_locked+0x1f/0x21
Nov  3 19:24:25 alexandria kernel:  [<c03160e1>]
__down_interruptible+0x102/0x139
Nov  3 19:24:25 alexandria kernel:  [<c011d046>]
default_wake_function+0x0/0xc
Nov  3 19:24:25 alexandria kernel:  [<f8849cda>]
scsi_error_handler+0xf2/0x191 [scsi_mod]
Nov  3 19:24:25 alexandria kernel:  [<f8849be8>]
scsi_error_handler+0x0/0x191 [scsi_mod]
Nov  3 19:24:25 alexandria kernel:  [<c0101ca1>]
kernel_thread_helper+0x5/0xb
Nov  3 19:24:25 alexandria kernel: Code: 20 cb 32 c0 eb e2 89 c2 81 78
04 ad 4e ad de 75
10 0f b6 02 84 c0 7f 13 b8 01 00 00 00 86 02 fb c3 0f 0b 72 00 20 cb 32
c0 eb e6 <0f> 0b
73 00 20 cb 32 c0 eb e3 89 c2 81 78 04 ad 4e ad de 75 13

The code for mv_ial_ht_abort:

int mv_ial_ht_abort(struct scsi_cmnd *SCpnt)
{
    IAL_ADAPTER_T   *pAdapter;
    IAL_HOST_T      *pHost;

    MV_SATA_ADAPTER *pMvSataAdapter;
    MV_U8           channel;
    unsigned long lock_flags;
    struct scsi_cmnd *cmnds_done_list = NULL;

    mvLogMsg(MV_IAL_LOG_ID, MV_DEBUG, "abort command %p\n", SCpnt);
    if (SCpnt == NULL)
    {
        return FAILED;
    }
    pHost = HOSTDATA(SCpnt->device->host);
    channel = pHost->channelIndex;
    pAdapter = MV_IAL_ADAPTER(SCpnt->device->host);
    pMvSataAdapter = &pAdapter->mvSataAdapter;
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
    spin_unlock_irq (&io_request_lock);
#else
    spin_unlock_irq (pHost->scsihost->host_lock);
#endif
    spin_lock_irqsave (&pAdapter->adapter_lock, lock_flags);

    mvRestartChannel(&pAdapter->ialCommonExt, channel,
                     pAdapter->ataScsiAdapterExt, MV_TRUE);
    mv_ial_block_requests(pAdapter, channel);

    cmnds_done_list = mv_ial_lib_get_first_cmnd(pAdapter, channel);

    spin_unlock_irqrestore (&pAdapter->adapter_lock, lock_flags);

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
    spin_lock_irq(&io_request_lock);
#else
    spin_lock_irq (pHost->scsihost->host_lock);
#endif

    if (cmnds_done_list)
    {
        scsi_report_bus_reset(SCpnt->device->host, SCpnt->device->channel);
        mv_ial_lib_do_done(cmnds_done_list);
        return SUCCESS;
    }

    mvLogMsg(MV_IAL_LOG_ID, MV_DEBUG_ERROR, "[%d %d %d]: command abort
failed\n",
             SCpnt->device->host->host_no, SCpnt->device->channel,
SCpnt->device->id);
    return FAILED;
}
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDa4VoORnzrtFC2/sRAqfQAKDBV54C6QbW6lexyLAMZgvKB2vc5QCg4qG7
rWkAKxd90NihoIZjPx4bYuM=
=/Zt8
-----END PGP SIGNATURE-----

