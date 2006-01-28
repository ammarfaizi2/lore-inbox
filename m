Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWA1PBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWA1PBs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 10:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWA1PBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 10:01:48 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12167 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751411AbWA1PBr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 10:01:47 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Date: Sat, 28 Jan 2006 17:01:02 +0200
User-Agent: KMail/1.8.2
References: <200601281613.16199.vda@ilport.com.ua>
In-Reply-To: <200601281613.16199.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601281701.02533.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 January 2006 16:13, Denis Vlasenko wrote:
> I have an old PII server box with just 32MB of RAM.
> 
> Yesterday I was preparing it for use by other people, not just me,
> and went on checking and tightening filesystem permissions with
> chmod -R and/or chown -R.
> 
> On deep directories box started to OOM-kill processes en masse!
> 
> I updated kernel to 2.6.15.1 - doesn't help.
> I stopped some of more memory hungry processes before running
> chmod -R  -  doesn't help.

More details which might be relevant.

I did not alter anything in /proc/sys/vm, maybe I should?

# cd /proc/sys/vm
# for a in *; do echo "$a: `cat "$a"`"; done
block_dump: 0
dirty_background_ratio: 10
dirty_expire_centisecs: 3000
dirty_ratio: 40
dirty_writeback_centisecs: 500
hugetlb_shm_group: 0
laptop_mode: 0
legacy_va_layout: 0
lowmem_reserve_ratio: 256       256     32
max_map_count: 65536
min_free_kbytes: 724
nr_hugepages: 0
nr_pdflush_threads: 2
overcommit_memory: 0
overcommit_ratio: 50
page-cluster: 3
swap_token_timeout: 300
swappiness: 60
vfs_cache_pressure: 100

SCSI controller and disks attached to it:

lspci says: "00:0b.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)"
boot log:
13:48:34.50 ahc_pci:0:11:0: Using left over BIOS settings
13:48:34.50 scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
13:48:34.50         <Adaptec aic7880 Ultra SCSI adapter>
13:48:34.50         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs
13:48:34.50
13:48:34.50   Vendor: IBM       Model: DNES-309170W      Rev: SAH0
13:48:34.50   Type:   Direct-Access                      ANSI SCSI revision: 03
13:48:34.50 scsi0:A:0:0: Tagged Queuing enabled.  Depth 8
13:48:34.50  target0:0:0: Beginning Domain Validation
13:48:34.50  target0:0:0: wide asynchronous.
13:48:34.50  target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 8)
13:48:34.50  target0:0:0: Domain Validation skipping write tests
13:48:34.50  target0:0:0: Ending Domain Validation
13:48:34.50   Vendor: IBM       Model: DNES-309170W      Rev: SAH0
13:48:34.50   Type:   Direct-Access                      ANSI SCSI revision: 03
13:48:34.50 scsi0:A:1:0: Tagged Queuing enabled.  Depth 8
13:48:34.50  target0:0:1: Beginning Domain Validation
13:48:34.50  target0:0:1: wide asynchronous.
13:48:34.50  target0:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 8)
13:48:34.50  target0:0:1: Domain Validation skipping write tests
13:48:34.50  target0:0:1: Ending Domain Validation
13:48:34.50   Vendor: SEAGATE   Model: ST39140N          Rev: 1498
13:48:34.50   Type:   Direct-Access                      ANSI SCSI revision: 02
13:48:34.50 scsi0:A:3:0: Tagged Queuing enabled.  Depth 8
13:48:34.50  target0:0:3: Beginning Domain Validation
13:48:34.50  target0:0:3: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)
13:48:34.50  target0:0:3: Domain Validation skipping write tests
13:48:34.50  target0:0:3: Ending Domain Validation
13:48:34.50 libata version 1.20 loaded.
13:48:34.50 SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
13:48:34.50 SCSI device sda: drive cache: write back
13:48:34.50 SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
13:48:34.50 SCSI device sda: drive cache: write back
13:48:34.50  sda: sda1 sda2
13:48:34.50 sd 0:0:0:0: Attached scsi disk sda
13:48:34.51 SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
13:48:34.51 SCSI device sdb: drive cache: write back
13:48:34.51 SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
13:48:34.51 SCSI device sdb: drive cache: write back
13:48:34.51  sdb: sdb1 sdb2
13:48:34.51 sd 0:0:1:0: Attached scsi disk sdb
13:48:34.51 SCSI device sdc: 17783240 512-byte hdwr sectors (9105 MB)
13:48:34.51 SCSI device sdc: drive cache: write back
13:48:34.51 SCSI device sdc: 17783240 512-byte hdwr sectors (9105 MB)
13:48:34.51 SCSI device sdc: drive cache: write back
13:48:34.51  sdc: sdc1 sdc2 sdc3

--
vda
