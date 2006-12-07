Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968699AbWLGD4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968699AbWLGD4n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 22:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968698AbWLGD4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 22:56:43 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:54984 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968670AbWLGD4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 22:56:41 -0500
Message-ID: <457790F0.2070208@tw.ibm.com>
Date: Thu, 07 Dec 2006 11:56:32 +0800
From: Albert Lee <albertcc@tw.ibm.com>
Reply-To: albertl@mail.com
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Oops in pata_pdc2027x
References: <20061205170144.0b98d7e6.sfr@canb.auug.org.au>
In-Reply-To: <20061205170144.0b98d7e6.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> Hi all,
> 
> I get an oops during initialisation of the pata_pdc2027x module on a
> POWER 285 machine.  This is on a very recent Linus kernel tree
> (ff51a98799931256b555446b2f5675db08de6229) with Paulus' powerpc tree
> (that has now been merged). The oops looks like this:
> 
> ----------------------------------------------------------------------------
> Synthesizing the initial hotplug events...done.
> Waiting for /dev to be fully populated...pata_pdc2027x 0001:cc:01.0: PLL input clock 32721 kHz
> ata1: PATA max UDMA/133 cmd 0xD0000800801457C0 ctl 0xD000080080145FDA bmdma 0xD000080080145000 irq 324
> ata2: PATA max UDMA/133 cmd 0xD0000800801455C0 ctl 0xD000080080145DDA bmdma 0xD000080080145008 irq 324
> scsi1 : pata_pdc2027x
> ata1.00: ATAPI, max UDMA/66
> Unable to handle kernel paging request for data at address 0xc0000001007e8d80
> Faulting instruction address: 0xd00000000007b660
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=128 NUMA
> Modules linked in: pata_pdc2027x dm_mirror dm_snapshot ipr libata
> NIP: D00000000007B660 LR: D00000000007B628 CTR: 0000000000000000
> REGS: c0000000f4e3b5a0 TRAP: 0300   Not tainted  (2.6.19comb)
> MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 24000080  XER: 20000009
> DAR: C0000001007E8D80, DSISR: 0000000040010000
> TASK = c000000007001040[3393] 'scsi_eh_1' THREAD: c0000000f4e38000 CPU: 2
> GPR00: 0000000100000000 C0000000F4E3B820 D0000000000A95C0 C00000000FA946E8
> GPR04: C0000000F4E3B960 0000000000000000 0000000000000003 C0000000F4E3B890
> GPR08: 0000000000000001 C0000000007E8D80 D000080080145110 C000000000033A34
> GPR12: 0000000000000000 C00000000056FF80 0000000000000000 C0000000004751C8
> GPR16: 4000000001C00000 C000000000473B90 0000000000000000 000000000035D800
> GPR20: 000000000213AF30 C00000000053AF30 C0000000F4E3BB10 0000000000000001
> GPR24: 0000000000000002 0000000000000000 C0000000F4E3B960 C00000000FA946E8
> GPR28: 0000000000000003 4000000000000000 D0000000000A7980 0000000000000000
> NIP [D00000000007B660] .ata_exec_internal+0x8c/0xf8 [libata]
> LR [D00000000007B628] .ata_exec_internal+0x54/0xf8 [libata]
> Call Trace:
> [C0000000F4E3B820] [D0000000000A7980] .ipr_store_update_fw+0x100/0x6f0 [ipr] (unreliable)
> [C0000000F4E3B8F0] [D00000000007C15C] .ata_set_mode+0x4dc/0x6d0 [libata]
> [C0000000F4E3B9D0] [D0000000000860E0] .ata_do_eh+0x1538/0x1930 [libata]
> [C0000000F4E3BC20] [D000000000083774] .ata_bmdma_drive_eh+0x1f8/0x2e8 [libata]
> [C0000000F4E3BCD0] [D0000000000C17B4] .pdc2027x_error_handler+0x28/0x40 [pata_pdc2027x]
> [C0000000F4E3BD50] [D000000000086DC0] .ata_scsi_error+0x32c/0x660 [libata]
> [C0000000F4E3BE00] [C000000000312F7C] .scsi_error_handler+0xc8/0x80c
> [C0000000F4E3BEE0] [C00000000006A0F4] .kthread+0x124/0x174
> [C0000000F4E3BF90] [C000000000024D68] .kernel_thread+0x4c/0x68
> Instruction dump:
> 57ac053e e93e8020 7f63db78 7f44d378 780007c6 7f25cb78 7f86e378 38e10070
> 7fbd0214 39000001 7ba0f860 78001f24 <7d69002a> 7ba0a302 7bbd4602 39200000
>  done.
> ----------------------------------------------------------------------------
> 
> (The reference to ipr_store_update_fw is certainly not real)
> 
> The config, lspci and full boot dmesg output are available at
> http://ozlabs.org/~sfr/{config,lspci,dmesg}
> 
> This machine has a only cdrom drive attached to the pdc controller.
> 

It seems the opps occurred in the ata_exec_internal(). Could you please
try the attached patch and see if the older ata_exec_internal() works?
This can help to narrow it down.

--
albert

--- pdc2027x_ozlab/drivers/ata/libata-core.c	2006-12-06 15:01:13.000000000 +0800
+++ exec_internal/drivers/ata/libata-core.c	2006-12-07 11:49:08.000000000 +0800
@@ -1334,7 +1334,7 @@ unsigned ata_exec_internal_sg(struct ata
 }
 
 /**
- *	ata_exec_internal_sg - execute libata internal command
+ *	ata_exec_internal - execute libata internal command
  *	@dev: Device to which the command is sent
  *	@tf: Taskfile registers for the command and the result
  *	@cdb: CDB for packet command
@@ -1342,8 +1342,11 @@ unsigned ata_exec_internal_sg(struct ata
  *	@buf: Data buffer of the command
  *	@buflen: Length of data buffer
  *
- *	Wrapper around ata_exec_internal_sg() which takes simple
- *	buffer instead of sg list.
+ *	Executes libata internal command with timeout.  @tf contains
+ *	command on entry and result on return.  Timeout and error
+ *	conditions are reported via return value.  No recovery action
+ *	is taken after a command times out.  It's caller's duty to
+ *	clean up after timeout.
  *
  *	LOCKING:
  *	None.  Should be called with kernel context, might sleep.
@@ -1355,11 +1358,141 @@ unsigned ata_exec_internal(struct ata_de
 			   struct ata_taskfile *tf, const u8 *cdb,
 			   int dma_dir, void *buf, unsigned int buflen)
 {
-	struct scatterlist sg;
+	struct ata_port *ap = dev->ap;
+	u8 command = tf->command;
+	struct ata_queued_cmd *qc;
+	unsigned int tag, preempted_tag;
+	u32 preempted_sactive, preempted_qc_active;
+	DECLARE_COMPLETION_ONSTACK(wait);
+	unsigned long flags;
+	unsigned int err_mask;
+	int rc;
 
-	sg_init_one(&sg, buf, buflen);
+	spin_lock_irqsave(ap->lock, flags);
 
-	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, &sg, 1);
+	/* no internal command while frozen */
+	if (ap->pflags & ATA_PFLAG_FROZEN) {
+		spin_unlock_irqrestore(ap->lock, flags);
+		return AC_ERR_SYSTEM;
+	}
+
+	/* initialize internal qc */
+
+	/* XXX: Tag 0 is used for drivers with legacy EH as some
+	 * drivers choke if any other tag is given.  This breaks
+	 * ata_tag_internal() test for those drivers.  Don't use new
+	 * EH stuff without converting to it.
+	 */
+	if (ap->ops->error_handler)
+		tag = ATA_TAG_INTERNAL;
+	else
+		tag = 0;
+
+	if (test_and_set_bit(tag, &ap->qc_allocated))
+		BUG();
+	qc = __ata_qc_from_tag(ap, tag);
+
+	qc->tag = tag;
+	qc->scsicmd = NULL;
+	qc->ap = ap;
+	qc->dev = dev;
+	ata_qc_reinit(qc);
+
+	preempted_tag = ap->active_tag;
+	preempted_sactive = ap->sactive;
+	preempted_qc_active = ap->qc_active;
+	ap->active_tag = ATA_TAG_POISON;
+	ap->sactive = 0;
+	ap->qc_active = 0;
+
+	/* prepare & issue qc */
+	qc->tf = *tf;
+	if (cdb)
+		memcpy(qc->cdb, cdb, ATAPI_CDB_LEN);
+	qc->flags |= ATA_QCFLAG_RESULT_TF;
+	qc->dma_dir = dma_dir;
+	if (dma_dir != DMA_NONE) {
+		ata_sg_init_one(qc, buf, buflen);
+		qc->nsect = buflen / ATA_SECT_SIZE;
+	}
+
+	qc->private_data = &wait;
+	qc->complete_fn = ata_qc_complete_internal;
+
+	ata_qc_issue(qc);
+
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	rc = wait_for_completion_timeout(&wait, ata_probe_timeout);
+
+	ata_port_flush_task(ap);
+
+	if (!rc) {
+		spin_lock_irqsave(ap->lock, flags);
+
+		/* We're racing with irq here.  If we lose, the
+		 * following test prevents us from completing the qc
+		 * twice.  If we win, the port is frozen and will be
+		 * cleaned up by ->post_internal_cmd().
+		 */
+		if (qc->flags & ATA_QCFLAG_ACTIVE) {
+			qc->err_mask |= AC_ERR_TIMEOUT;
+
+			if (ap->ops->error_handler)
+				ata_port_freeze(ap);
+			else
+				ata_qc_complete(qc);
+
+			if (ata_msg_warn(ap))
+				ata_dev_printk(dev, KERN_WARNING,
+					"qc timeout (cmd 0x%x)\n", command);
+		}
+
+		spin_unlock_irqrestore(ap->lock, flags);
+	}
+
+	/* do post_internal_cmd */
+	if (ap->ops->post_internal_cmd)
+		ap->ops->post_internal_cmd(qc);
+
+	if (qc->flags & ATA_QCFLAG_FAILED && !qc->err_mask) {
+		if (ata_msg_warn(ap))
+			ata_dev_printk(dev, KERN_WARNING,
+				"zero err_mask for failed "
+				"internal command, assuming AC_ERR_OTHER\n");
+		qc->err_mask |= AC_ERR_OTHER;
+	}
+
+	/* finish up */
+	spin_lock_irqsave(ap->lock, flags);
+
+	*tf = qc->result_tf;
+	err_mask = qc->err_mask;
+
+	ata_qc_free(qc);
+	ap->active_tag = preempted_tag;
+	ap->sactive = preempted_sactive;
+	ap->qc_active = preempted_qc_active;
+
+	/* XXX - Some LLDDs (sata_mv) disable port on command failure.
+	 * Until those drivers are fixed, we detect the condition
+	 * here, fail the command with AC_ERR_SYSTEM and reenable the
+	 * port.
+	 *
+	 * Note that this doesn't change any behavior as internal
+	 * command failure results in disabling the device in the
+	 * higher layer for LLDDs without new reset/EH callbacks.
+	 *
+	 * Kill the following code as soon as those drivers are fixed.
+	 */
+	if (ap->flags & ATA_FLAG_DISABLED) {
+		err_mask |= AC_ERR_SYSTEM;
+		ata_port_probe(ap);
+	}
+
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	return err_mask;
 }
 
 /**




