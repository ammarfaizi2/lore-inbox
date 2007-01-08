Return-Path: <linux-kernel-owner+w=401wt.eu-S1161187AbXAHIGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161187AbXAHIGE (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161182AbXAHIGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:06:04 -0500
Received: from web55614.mail.re4.yahoo.com ([206.190.58.238]:20369 "HELO
	web55614.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1161187AbXAHIGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:06:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=s2sxHsb51v2BkXJXgd6rir1EsQGl1QrXSatodM4yQ68T1RTqBad+o0v7gnQg3CeE1wA3W3JO7q7xHywCEYvSEb1KxXlTTXJuLQk4cMeSN2GmCckpQBXn3AJgolyMqW72Hk9bnqNNSSGkhVW7EwzkoqUJTAlyXDWt0lDAq80ApLo=;
X-YMail-OSG: oW3njSAVM1nWKBImWpktR9fQRH.zvREZGk0eqi0cIuxEsWJVR8Rgugw8J9qOolXe.X7L4fMsQHFwiheJT1QngaGNSeJaIM_0yvxtitb7gSraXL06nxC8K2TgHN9qG3riL5ketHsySo9kfXo-
Date: Mon, 8 Jan 2007 00:05:59 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: RE: [PATCH] include/linux/slab.h: new KFREE() macro.
To: Hua Zhong <hzhong@gmail.com>, "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <000501c732f9$7e3386a0$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <110013.54208.qm@web55614.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Hua Zhong <hzhong@gmail.com> wrote:

> > Any strong reason why not? x has some value that does not 
> > make sense and can create only problems.
> 
> By the same logic, you should memset the buffer to zero before freeing it too.
> 

How does this help?

> > And as I explained, it can result in longer code too. So, why 
> > keep this value around. Why not re-initialize it to NULL.
> 
> Because initialization increases code size.

Then why use kzalloc()? Let's remove _ALL_ the initialization code from the kernel.

Attached is some code from the kernel. Expanded KFREE() has been used atleast 1000 times in the
kernel. By your logic, everyone is stupid in doing so. Something has been done atleast 1000 times
in the kernel, that looks okay. But consolidating it at one place does not look okay. I am listing
some of the 1000 places where KFREE() has been used. All this code have been written by atleast 50
different people. From your logic they were doing "silly" things.

--
arch/ppc/kernel/smp-tbsync.c:	kfree( tbsync );
arch/ppc/kernel/smp-tbsync.c-	tbsync = NULL;
--
arch/powerpc/kernel/smp-tbsync.c:	kfree(tbsync);
arch/powerpc/kernel/smp-tbsync.c-	tbsync = NULL;
--
arch/powerpc/kernel/rtas_flash.c:		kfree(dp->data);
arch/powerpc/kernel/rtas_flash.c-		dp->data = NULL;
--
arch/powerpc/platforms/ps3/spu.c:	kfree(spu->pdata);
arch/powerpc/platforms/ps3/spu.c-	spu->pdata = NULL;
--
arch/powerpc/platforms/cell/spu_priv1_mmio.c:	kfree(spu->pdata);
arch/powerpc/platforms/cell/spu_priv1_mmio.c-	spu->pdata = NULL;
--
arch/powerpc/platforms/cell/spu_priv1_mmio.c:	kfree(spu->pdata);
arch/powerpc/platforms/cell/spu_priv1_mmio.c-	spu->pdata = NULL;
--
arch/powerpc/platforms/cell/spufs/context.c:	kfree(ctx);
arch/powerpc/platforms/cell/spufs/context.c-	ctx = NULL;
--
arch/ia64/kernel/topology.c:	kfree(all_cpu_cache_info[cpu].cache_leaves);
arch/ia64/kernel/topology.c-	all_cpu_cache_info[cpu].cache_leaves = NULL;
--
arch/ia64/sn/kernel/xpc_channel.c:		kfree(part->channels);
arch/ia64/sn/kernel/xpc_channel.c-		part->channels = NULL;
--
arch/ia64/sn/kernel/xpc_channel.c:		kfree(part->channels);
arch/ia64/sn/kernel/xpc_channel.c-		part->channels = NULL;
--
arch/ia64/sn/kernel/xpc_channel.c:		kfree(part->channels);
arch/ia64/sn/kernel/xpc_channel.c-		part->channels = NULL;
--
arch/ia64/sn/kernel/xpc_channel.c:		kfree(part->channels);
arch/ia64/sn/kernel/xpc_channel.c-		part->channels = NULL;
--
arch/ia64/sn/kernel/xpc_channel.c:		kfree(part->channels);
arch/ia64/sn/kernel/xpc_channel.c-		part->channels = NULL;
--
arch/ia64/sn/kernel/xpc_channel.c:			kfree(ch->local_msgqueue_base);
arch/ia64/sn/kernel/xpc_channel.c-			ch->local_msgqueue = NULL;
--
arch/ia64/sn/kernel/xpc_channel.c:		kfree(ch->notify_queue);
arch/ia64/sn/kernel/xpc_channel.c-		ch->notify_queue = NULL;
--
arch/ia64/sn/kernel/xpc_channel.c:		kfree(ch->notify_queue);
arch/ia64/sn/kernel/xpc_channel.c-		ch->notify_queue = NULL;
--
arch/ia64/sn/kernel/xpc_channel.c:	kfree(part->channels);
arch/ia64/sn/kernel/xpc_channel.c-	part->channels = NULL;
--
arch/s390/hypfs/inode.c:		kfree(sb->s_fs_info);
arch/s390/hypfs/inode.c-		sb->s_fs_info = NULL;
--
arch/s390/kernel/debug.c:	kfree(db_info->areas);
arch/s390/kernel/debug.c-	db_info->areas = NULL;
--
arch/sparc64/kernel/of_device.c:		kfree(op);
arch/sparc64/kernel/of_device.c-		op = NULL;
--
arch/sparc64/kernel/us2e_cpufreq.c:		kfree(us2e_freq_table);
arch/sparc64/kernel/us2e_cpufreq.c-		us2e_freq_table = NULL;
--
arch/sparc64/kernel/us2e_cpufreq.c:		kfree(cpufreq_us2e_driver);
arch/sparc64/kernel/us2e_cpufreq.c-		cpufreq_us2e_driver = NULL;
--
arch/sparc64/kernel/us2e_cpufreq.c:		kfree(us2e_freq_table);
arch/sparc64/kernel/us2e_cpufreq.c-		us2e_freq_table = NULL;
--
arch/sparc64/kernel/us3_cpufreq.c:		kfree(us3_freq_table);
arch/sparc64/kernel/us3_cpufreq.c-		us3_freq_table = NULL;
--
arch/sparc64/kernel/us3_cpufreq.c:		kfree(cpufreq_us3_driver);
arch/sparc64/kernel/us3_cpufreq.c-		cpufreq_us3_driver = NULL;
--
arch/sparc64/kernel/us3_cpufreq.c:		kfree(us3_freq_table);
arch/sparc64/kernel/us3_cpufreq.c-		us3_freq_table = NULL;
--
arch/x86_64/kernel/mce_amd.c:	kfree(per_cpu(threshold_banks, cpu)[bank]->blocks);
arch/x86_64/kernel/mce_amd.c-	per_cpu(threshold_banks, cpu)[bank]->blocks = NULL;
--
arch/x86_64/kernel/process.c:		kfree(t->io_bitmap_ptr);
arch/x86_64/kernel/process.c-		t->io_bitmap_ptr = NULL;
--
arch/x86_64/kernel/io_apic.c:			kfree(mp_ioapic_data[i]);
arch/x86_64/kernel/io_apic.c-			mp_ioapic_data[i] = NULL;
--
arch/arm/mach-s3c2410/pm.c:		kfree(crcs);
arch/arm/mach-s3c2410/pm.c-		crcs = NULL;
--
arch/arm/mach-sa1100/neponset.c:		kfree(dev->dev.power.saved_state);
arch/arm/mach-sa1100/neponset.c-		dev->dev.power.saved_state = NULL;
--
arch/arm/common/sa1111.c:		kfree(pdev->dev.power.saved_state);
arch/arm/common/sa1111.c-		pdev->dev.power.saved_state = NULL;
--
arch/arm/mach-netx/xc.c:	kfree(x);
arch/arm/mach-netx/xc.c-	x = NULL;
--
arch/sparc/kernel/of_device.c:		kfree(op);
arch/sparc/kernel/of_device.c-		op = NULL;
--
arch/i386/kernel/process.c:		kfree(t->io_bitmap_ptr);
arch/i386/kernel/process.c-		t->io_bitmap_ptr = NULL;
--
arch/i386/kernel/io_apic.c:		kfree(irq_cpu_data[i].irq_delta);
arch/i386/kernel/io_apic.c-		irq_cpu_data[i].irq_delta = NULL;
--
arch/i386/kernel/io_apic.c:		kfree(irq_cpu_data[i].last_irq);
arch/i386/kernel/io_apic.c-		irq_cpu_data[i].last_irq = NULL;
--
arch/i386/kernel/io_apic.c:			kfree(mp_ioapic_data[i]);
arch/i386/kernel/io_apic.c-			mp_ioapic_data[i] = NULL;
--
arch/i386/kernel/cpu/intel_cacheinfo.c:	kfree(cpuid4_info[cpu]);
arch/i386/kernel/cpu/intel_cacheinfo.c-	cpuid4_info[cpu] = NULL;
--
arch/i386/kernel/cpu/intel_cacheinfo.c:	kfree(index_kobject[cpu]);
arch/i386/kernel/cpu/intel_cacheinfo.c-	index_kobject[cpu] = NULL;
--
arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c:				kfree(acpi_perf_data[j]);
arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c-				acpi_perf_data[j] = NULL;
--
arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c:		kfree(acpi_perf_data[j]);
arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c-		acpi_perf_data[j] = NULL;
--
arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c:				kfree(acpi_perf_data[j]);
arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c-				acpi_perf_data[j] = NULL;
--
arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c:		kfree(acpi_perf_data[i]);
arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c-		acpi_perf_data[i] = NULL;
--
arch/i386/oprofile/nmi_int.c:		kfree(cpu_msrs[i].counters);
arch/i386/oprofile/nmi_int.c-		cpu_msrs[i].counters = NULL;
--
arch/i386/oprofile/nmi_int.c:		kfree(cpu_msrs[i].controls);
arch/i386/oprofile/nmi_int.c-		cpu_msrs[i].controls = NULL;
--
arch/h8300/platform/h8s/ints.c:		kfree(irq_list[irq]);
arch/h8300/platform/h8s/ints.c-		irq_list[irq] = NULL;
--
arch/h8300/kernel/ints.c:		kfree(irq_list[irq]);
arch/h8300/kernel/ints.c-		irq_list[irq] = NULL;
--
arch/um/kernel/irq.c:		kfree(tmp_pfd);
arch/um/kernel/irq.c-		tmp_pfd = NULL;
--
arch/um/drivers/daemon_user.c:		kfree(pri->local_addr);
arch/um/drivers/daemon_user.c-		pri->local_addr = NULL;
--
arch/um/drivers/daemon_user.c:	kfree(pri->data_addr);
arch/um/drivers/daemon_user.c-	pri->data_addr = NULL;
--
arch/um/drivers/daemon_user.c:	kfree(pri->ctl_addr);
arch/um/drivers/daemon_user.c-	pri->ctl_addr = NULL;
--
arch/um/drivers/daemon_user.c:	kfree(pri->local_addr);
arch/um/drivers/daemon_user.c-	pri->local_addr = NULL;
--
arch/um/drivers/net_kern.c:		kfree(*init_out);
arch/um/drivers/net_kern.c-		*init_out = NULL;
--
block/ll_rw_blk.c:		kfree(bqt->tag_index);
block/ll_rw_blk.c-		bqt->tag_index = NULL;
--
block/ll_rw_blk.c:		kfree(bqt->tag_map);
block/ll_rw_blk.c-		bqt->tag_map = NULL;
--
drivers/media/dvb/frontends/lnbp21.c:	kfree(fe->sec_priv);
drivers/media/dvb/frontends/lnbp21.c-	fe->sec_priv = NULL;
--
drivers/media/dvb/frontends/tua6100.c:	kfree(fe->tuner_priv);
drivers/media/dvb/frontends/tua6100.c-	fe->tuner_priv = NULL;
--
drivers/media/dvb/frontends/mt2060.c:	kfree(fe->tuner_priv);
drivers/media/dvb/frontends/mt2060.c-	fe->tuner_priv = NULL;
--
drivers/media/dvb/frontends/lgh06xf.c:	kfree(fe->tuner_priv);
drivers/media/dvb/frontends/lgh06xf.c-	fe->tuner_priv = NULL;
--
drivers/media/dvb/frontends/isl6421.c:	kfree(fe->sec_priv);
drivers/media/dvb/frontends/isl6421.c-	fe->sec_priv = NULL;
--
drivers/media/dvb/frontends/dvb-pll.c:	kfree(fe->tuner_priv);
drivers/media/dvb/frontends/dvb-pll.c-	fe->tuner_priv = NULL;
--
drivers/media/dvb/frontends/tda826x.c:	kfree(fe->tuner_priv);
drivers/media/dvb/frontends/tda826x.c-	fe->tuner_priv = NULL;
--
drivers/media/video/saa7134/saa7134-input.c:	kfree(dev->remote);
drivers/media/video/saa7134/saa7134-input.c-	dev->remote = NULL;
--
drivers/media/video/video-buf.c:			kfree(dma->sglist);
drivers/media/video/video-buf.c-			dma->sglist = NULL;
--
drivers/media/video/video-buf.c:	kfree(dma->sglist);
drivers/media/video/video-buf.c-	dma->sglist = NULL;
--
drivers/media/video/video-buf.c:		kfree(dma->pages);
drivers/media/video/video-buf.c-		dma->pages = NULL;
--
drivers/media/video/video-buf.c:	kfree(q->read_buf);
drivers/media/video/video-buf.c-	q->read_buf = NULL;
--
drivers/media/video/video-buf.c:			kfree (q->read_buf);
drivers/media/video/video-buf.c-			q->read_buf = NULL;
--
drivers/media/video/video-buf.c:		kfree(q->read_buf);
drivers/media/video/video-buf.c-		q->read_buf = NULL;
--
drivers/media/video/video-buf.c:		kfree(q->read_buf);
drivers/media/video/video-buf.c-		q->read_buf = NULL;
--
drivers/media/video/video-buf.c:		kfree(q->bufs[i]);
drivers/media/video/video-buf.c-		q->bufs[i] = NULL;
--
drivers/media/video/video-buf.c:		kfree(q->bufs[i]);
drivers/media/video/video-buf.c-		q->bufs[i] = NULL;
--
drivers/media/video/usbvideo/usbvideo.c:				kfree(uvd->sbuf[i].data);
drivers/media/video/usbvideo/usbvideo.c-				uvd->sbuf[i].data = NULL;
--
drivers/media/video/usbvideo/usbvideo.c:		kfree(uvd->sbuf[i].data);
drivers/media/video/usbvideo/usbvideo.c-		uvd->sbuf[i].data = NULL;
--
drivers/media/video/w9968cf.c:		kfree(cam->transfer_buffer[i]);
drivers/media/video/w9968cf.c-		cam->transfer_buffer[i] = NULL;
--
drivers/media/video/cafe_ccic.c:	kfree(cam->sb_bufs);
drivers/media/video/cafe_ccic.c-	cam->sb_bufs = NULL;
--
drivers/media/video/ov511.c:		kfree(ov->sbuf[i].data);
drivers/media/video/ov511.c-		ov->sbuf[i].data = NULL;
--
drivers/media/video/ov511.c:		kfree(ov->cbuf);
drivers/media/video/ov511.c-		ov->cbuf = NULL;
--
drivers/media/video/ov511.c:		kfree(ov);
drivers/media/video/ov511.c-		ov = NULL;
--
drivers/media/video/ov511.c:		kfree(ov->cbuf);
drivers/media/video/ov511.c-		ov->cbuf = NULL;
--
drivers/media/video/ov511.c:	kfree(ov);
drivers/media/video/ov511.c-	ov = NULL;
--
drivers/media/video/ov511.c:		kfree(ov->cbuf);
drivers/media/video/ov511.c-		ov->cbuf = NULL;
--
drivers/media/video/ov511.c:		kfree(ov);
drivers/media/video/ov511.c-		ov = NULL;
--
drivers/media/video/se401.c:		kfree(se401->scratch[i].data);
drivers/media/video/se401.c-		se401->scratch[i].data=NULL;
--
drivers/media/video/stv680.c:		kfree(stv680->scratch[i].data);
drivers/media/video/stv680.c-		stv680->scratch[i].data = NULL;
--
drivers/media/video/stv680.c:		kfree(stv680->sbuf[i].data);
drivers/media/video/stv680.c-		stv680->sbuf[i].data = NULL;
--
drivers/media/video/stv680.c:		kfree(stv680->scratch[i].data);
drivers/media/video/stv680.c-		stv680->scratch[i].data = NULL;
--
drivers/media/video/stv680.c:		kfree(stv680);
drivers/media/video/stv680.c-		stv680 = NULL;
--
drivers/media/video/stradis.c:	kfree(saa->dmavid2);
drivers/media/video/stradis.c-	saa->dmavid2 = NULL;
--
drivers/media/video/pvrusb2/pvrusb2-ioread.c:		kfree(cp->sync_key_ptr);
drivers/media/video/pvrusb2/pvrusb2-ioread.c-		cp->sync_key_ptr = NULL;
--
drivers/media/video/pvrusb2/pvrusb2-ioread.c:			kfree(cp->sync_key_ptr);
drivers/media/video/pvrusb2/pvrusb2-ioread.c-			cp->sync_key_ptr = NULL;
--
drivers/media/video/pvrusb2/pvrusb2-hdw.c:		kfree(hdw->ctl_read_buffer);
drivers/media/video/pvrusb2/pvrusb2-hdw.c-		hdw->ctl_read_buffer = NULL;
--
drivers/media/video/pvrusb2/pvrusb2-hdw.c:		kfree(hdw->ctl_write_buffer);
drivers/media/video/pvrusb2/pvrusb2-hdw.c-		hdw->ctl_write_buffer = NULL;
--
drivers/media/video/pvrusb2/pvrusb2-hdw.c:		kfree(hdw->fw_buffer);
drivers/media/video/pvrusb2/pvrusb2-hdw.c-		hdw->fw_buffer = NULL;
--
drivers/media/video/pvrusb2/pvrusb2-hdw.c:		kfree(hdw->std_defs);
drivers/media/video/pvrusb2/pvrusb2-hdw.c-		hdw->std_defs = NULL;
--
drivers/media/video/pvrusb2/pvrusb2-hdw.c:		kfree(hdw->std_enum_names);
drivers/media/video/pvrusb2/pvrusb2-hdw.c-		hdw->std_enum_names = NULL;
--
drivers/media/video/pvrusb2/pvrusb2-hdw.c:			kfree(hdw->fw_buffer);
drivers/media/video/pvrusb2/pvrusb2-hdw.c-			hdw->fw_buffer = NULL;
--
drivers/media/video/pvrusb2/pvrusb2-sysfs.c:	kfree(sfp->debugifc);
drivers/media/video/pvrusb2/pvrusb2-sysfs.c-	sfp->debugifc = NULL;
--
drivers/media/video/pvrusb2/pvrusb2-sysfs.c:		kfree(clp);
drivers/media/video/pvrusb2/pvrusb2-sysfs.c-		clp = NULL;
--
drivers/media/video/vivi.c:	kfree(buf->to_addr);
drivers/media/video/vivi.c-	buf->to_addr=NULL;
--
drivers/media/video/cx88/cx88-vp3054-i2c.c:		kfree(dev->card_priv);
drivers/media/video/cx88/cx88-vp3054-i2c.c-		dev->card_priv = NULL;
--
drivers/media/video/cpia_usb.c:	kfree (ucpia->sbuf[1].data);
drivers/media/video/cpia_usb.c-	ucpia->sbuf[1].data = NULL;
--
drivers/media/video/cpia_usb.c:	kfree (ucpia->sbuf[0].data);
drivers/media/video/cpia_usb.c-	ucpia->sbuf[0].data = NULL;
--
drivers/media/video/cpia_usb.c:	kfree(ucpia->sbuf[1].data);
drivers/media/video/cpia_usb.c-	ucpia->sbuf[1].data = NULL;
--
drivers/media/video/cpia_usb.c:	kfree(ucpia->sbuf[0].data);
drivers/media/video/cpia_usb.c-	ucpia->sbuf[0].data = NULL;
--
drivers/media/video/cpia2/cpia2_core.c:			kfree(cam->buffers);
drivers/media/video/cpia2/cpia2_core.c-			cam->buffers = NULL;
--
drivers/media/video/cpia2/cpia2_core.c:		kfree(cam->buffers);
drivers/media/video/cpia2/cpia2_core.c-		cam->buffers = NULL;
--
drivers/media/video/cpia2/cpia2_usb.c:			kfree(cam->sbuf[i].data);
drivers/media/video/cpia2/cpia2_usb.c-			cam->sbuf[i].data = NULL;
--
drivers/media/video/cpia2/cpia2_usb.c:				kfree(cam->sbuf[i].data);
drivers/media/video/cpia2/cpia2_usb.c-				cam->sbuf[i].data = NULL;
--
drivers/media/video/pwc/pwc-if.c:			kfree(pdev->sbuf[i].data);
drivers/media/video/pwc/pwc-if.c-			pdev->sbuf[i].data = NULL;
--
drivers/media/video/pwc/pwc-if.c:		kfree(pdev->fbuf);
drivers/media/video/pwc/pwc-if.c-		pdev->fbuf = NULL;
--
drivers/media/video/pwc/pwc-if.c:		kfree(pdev->decompress_data);
drivers/media/video/pwc/pwc-if.c-		pdev->decompress_data = NULL;
--
drivers/media/video/bt8xx/bttv-driver.c:				kfree(fh->ov.clips);
drivers/media/video/bt8xx/bttv-driver.c-			fh->ov.clips = NULL;
--
drivers/media/video/bt8xx/bttv-driver.c:				kfree (fh->cap.read_buf);
drivers/media/video/bt8xx/bttv-driver.c-				fh->cap.read_buf = NULL;
--
drivers/media/video/bt8xx/bttv-input.c:	kfree(btv->remote);
drivers/media/video/bt8xx/bttv-input.c-	btv->remote = NULL;
--
drivers/media/common/saa7146_core.c:		kfree(pt->slist);
drivers/media/common/saa7146_core.c-		pt->slist = NULL;
--
drivers/media/common/saa7146_core.c:	kfree(pt->slist);
drivers/media/common/saa7146_core.c-	pt->slist = NULL;
--
drivers/telephony/ixj.c:	kfree(j->fskdata);
drivers/telephony/ixj.c-	j->fskdata = NULL;
--
drivers/telephony/ixj.c:		kfree(j->read_buffer);
drivers/telephony/ixj.c-		j->read_buffer = NULL;
--
drivers/telephony/ixj.c:		kfree(j->write_buffer);
drivers/telephony/ixj.c-		j->write_buffer = NULL;
--
drivers/telephony/ixj.c:	kfree(j->read_buffer);
drivers/telephony/ixj.c-	j->read_buffer = NULL;
--
drivers/telephony/ixj.c:	kfree(j->write_buffer);
drivers/telephony/ixj.c-	j->write_buffer = NULL;
--
drivers/telephony/ixj.c:			kfree(j->cadence_t);
drivers/telephony/ixj.c-			j->cadence_t = NULL;
--
drivers/isdn/hisax/config.c:	kfree(cs->dlog);
drivers/isdn/hisax/config.c-	cs->dlog = NULL;
--
drivers/isdn/hisax/config.c:	kfree(csta->rcvbuf);
drivers/isdn/hisax/config.c-	csta->rcvbuf = NULL;
--
drivers/isdn/hisax/config.c:	kfree(cs);
drivers/isdn/hisax/config.c-	card->cs = NULL;
--
drivers/isdn/hisax/config.c:		kfree((void *) cards[cardnr].cs);
drivers/isdn/hisax/config.c-		cards[cardnr].cs = NULL;
--
drivers/isdn/hisax/hfc_2bs0.c:	kfree(cs->bcs[0].hw.hfc.send);
drivers/isdn/hisax/hfc_2bs0.c-	cs->bcs[0].hw.hfc.send = NULL;
--
drivers/isdn/hisax/hfc_2bs0.c:	kfree(cs->bcs[1].hw.hfc.send);
drivers/isdn/hisax/hfc_2bs0.c-	cs->bcs[1].hw.hfc.send = NULL;
--
drivers/isdn/hisax/netjet.c:				dev_kfree_skb_any(bcs->tx_skb);
drivers/isdn/hisax/netjet.c-				bcs->tx_skb = NULL;
--
drivers/isdn/hisax/netjet.c:		kfree(bcs->hw.tiger.rcvbuf);
drivers/isdn/hisax/netjet.c-		bcs->hw.tiger.rcvbuf = NULL;
--
drivers/isdn/hisax/netjet.c:		kfree(bcs->hw.tiger.sendbuf);
drivers/isdn/hisax/netjet.c-		bcs->hw.tiger.sendbuf = NULL;
--
drivers/isdn/hisax/netjet.c:			dev_kfree_skb_any(bcs->tx_skb);
drivers/isdn/hisax/netjet.c-			bcs->tx_skb = NULL;
--
drivers/isdn/hisax/netjet.c:	kfree(cs->bcs[0].hw.tiger.send);
drivers/isdn/hisax/netjet.c-	cs->bcs[0].hw.tiger.send = NULL;
--
drivers/isdn/hisax/netjet.c:	kfree(cs->bcs[0].hw.tiger.rec);
drivers/isdn/hisax/netjet.c-	cs->bcs[0].hw.tiger.rec = NULL;
--
drivers/isdn/hisax/isac.c:	kfree(cs->dc.isac.mon_rx);
drivers/isdn/hisax/isac.c-	cs->dc.isac.mon_rx = NULL;
--
drivers/isdn/hisax/isac.c:	kfree(cs->dc.isac.mon_tx);
drivers/isdn/hisax/isac.c-	cs->dc.isac.mon_tx = NULL;
--
drivers/isdn/hisax/hfc_2bds0.c:	kfree(cs->bcs[0].hw.hfc.send);
drivers/isdn/hisax/hfc_2bds0.c-	cs->bcs[0].hw.hfc.send = NULL;
--
drivers/isdn/hisax/hfc_2bds0.c:	kfree(cs->hw.hfcD.send);
drivers/isdn/hisax/hfc_2bds0.c-	cs->hw.hfcD.send = NULL;
--
drivers/isdn/hisax/avm_pci.c:		kfree(bcs->hw.hdlc.rcvbuf);
drivers/isdn/hisax/avm_pci.c-		bcs->hw.hdlc.rcvbuf = NULL;
--
drivers/isdn/hisax/avm_pci.c:		kfree(bcs->blog);
drivers/isdn/hisax/avm_pci.c-		bcs->blog = NULL;
--
drivers/isdn/hisax/avm_pci.c:			kfree(bcs->hw.hdlc.rcvbuf);
drivers/isdn/hisax/avm_pci.c-			bcs->hw.hdlc.rcvbuf = NULL;
--
drivers/isdn/hisax/hfc_pci.c:	kfree(cs->hw.hfcpci.share_start);
drivers/isdn/hisax/hfc_pci.c-	cs->hw.hfcpci.share_start = NULL;
--
drivers/isdn/hisax/icc.c:	kfree(cs->dc.icc.mon_rx);
drivers/isdn/hisax/icc.c-	cs->dc.icc.mon_rx = NULL;
--
drivers/isdn/hisax/icc.c:	kfree(cs->dc.icc.mon_tx);
drivers/isdn/hisax/icc.c-	cs->dc.icc.mon_tx = NULL;
--
drivers/isdn/hisax/w6692.c:		kfree(bcs->hw.w6692.rcvbuf);
drivers/isdn/hisax/w6692.c-		bcs->hw.w6692.rcvbuf = NULL;
--
drivers/isdn/hisax/w6692.c:		kfree(bcs->blog);
drivers/isdn/hisax/w6692.c-		bcs->blog = NULL;
--
drivers/isdn/hisax/w6692.c:			kfree(bcs->hw.w6692.rcvbuf);
drivers/isdn/hisax/w6692.c-			bcs->hw.w6692.rcvbuf = NULL;
--
drivers/isdn/hisax/ipacx.c:		kfree(bcs->hw.hscx.rcvbuf);
drivers/isdn/hisax/ipacx.c-		bcs->hw.hscx.rcvbuf = NULL;
--
drivers/isdn/hisax/ipacx.c:		kfree(bcs->blog);
drivers/isdn/hisax/ipacx.c-		bcs->blog = NULL;
--
drivers/isdn/hisax/ipacx.c:			kfree(bcs->hw.hscx.rcvbuf);
drivers/isdn/hisax/ipacx.c-			bcs->hw.hscx.rcvbuf = NULL;
--
drivers/isdn/hisax/elsa_ser.c:				kfree(bcs->hw.hscx.rcvbuf);
drivers/isdn/hisax/elsa_ser.c-			bcs->hw.hscx.rcvbuf = NULL;
--
drivers/isdn/hisax/elsa_ser.c:			dev_kfree_skb_any(bcs->tx_skb);
drivers/isdn/hisax/elsa_ser.c-			bcs->tx_skb = NULL;
--
drivers/isdn/hisax/elsa_ser.c:		kfree(cs->hw.elsa.rcvbuf);
drivers/isdn/hisax/elsa_ser.c-		cs->hw.elsa.rcvbuf = NULL;
--
drivers/isdn/hisax/elsa_ser.c:			kfree(cs->hw.elsa.rcvbuf);
drivers/isdn/hisax/elsa_ser.c-			cs->hw.elsa.rcvbuf = NULL;
--
drivers/isdn/hisax/elsa_ser.c:		kfree(cs->hw.elsa.transbuf);
drivers/isdn/hisax/elsa_ser.c-		cs->hw.elsa.transbuf = NULL;
--
drivers/isdn/hisax/callc.c:			kfree(csta->channel[i].b_st);
drivers/isdn/hisax/callc.c-			csta->channel[i].b_st = NULL;
--
drivers/isdn/hisax/isdnl3.c:		kfree(st->l3.global);
drivers/isdn/hisax/isdnl3.c-		st->l3.global = NULL;
--
drivers/isdn/hisax/st5481_usb.c:			kfree(urb[j]->transfer_buffer);
drivers/isdn/hisax/st5481_usb.c-			urb[j]->transfer_buffer = NULL;
--
drivers/isdn/hisax/hscx.c:		kfree(bcs->hw.hscx.rcvbuf);
drivers/isdn/hisax/hscx.c-		bcs->hw.hscx.rcvbuf = NULL;
--
drivers/isdn/hisax/hscx.c:		kfree(bcs->blog);
drivers/isdn/hisax/hscx.c-		bcs->blog = NULL;
--
drivers/isdn/hisax/hscx.c:			kfree(bcs->hw.hscx.rcvbuf);
drivers/isdn/hisax/hscx.c-			bcs->hw.hscx.rcvbuf = NULL;
--
drivers/isdn/hisax/jade.c:	kfree(bcs->hw.hscx.rcvbuf);
drivers/isdn/hisax/jade.c-	bcs->hw.hscx.rcvbuf = NULL;
--
drivers/isdn/hisax/jade.c:	kfree(bcs->blog);
drivers/isdn/hisax/jade.c-	bcs->blog = NULL;
--

-Amit


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
