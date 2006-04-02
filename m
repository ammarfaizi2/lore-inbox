Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWDBRFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWDBRFO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 13:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWDBRFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 13:05:14 -0400
Received: from morbo.e-centre.net ([66.154.82.3]:23506 "EHLO
	cubert.e-centre.net") by vger.kernel.org with ESMTP id S932378AbWDBRFM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 13:05:12 -0400
X-ASG-Debug-ID: 1143997509-29830-25-0
X-Barracuda-URL: http://10.3.1.19:8000/cgi-bin/mark.cgi
X-ASG-Orig-Subj: Re: BUG: warning at kernel/mutex.c:281 for 2.6.16.-git8 thru git20
Subject: Re: BUG: warning at kernel/mutex.c:281 for 2.6.16.-git8 thru git20
From: Arjan van de Ven <arjan@infradead.org>
To: Donald Parsons <dparsons@brightdsl.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1143995965.4310.15.camel@danny.parsons.org>
References: <1143995965.4310.15.camel@danny.parsons.org>
Content-Type: text/plain
Date: Sun, 02 Apr 2006 19:05:08 +0200
Message-Id: <1143997508.3066.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=4.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.10386
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> LID SLPB UART EXP0 EXP1 EXP2 EXP3 PCI1 USB0 USB1 USB3 USB7 AC9M
> ACPI: (supports S0 S3 S4 S5)
> Freeing unused kernel memory: 160k freed
> BUG: warning at kernel/mutex.c:281/__mutex_trylock_slowpath()
> <7812af12> mutex_trylock+0x70/0x152   <7823370e> hdaps_mousedev_poll\
>    +0xd/0xc5
> <781205fa> run_timer_softirq+0x11f/0x159   <78233701>
>    hdaps_mousedev_poll+0x0/0xc5
> <7811d22c> __do_softirq+0x40/0x88   <781049af> do_softirq+0x44/0x4c
> =======================
> <7811d314> irq_exit+0x2d/0x37   <781048d1> do_IRQ+0x79/0x83
> <781035ae> common_interrupt+0x1a/0x20   <7811680e> __might_sleep\
>    +0x16/0x94
> <7819e794> copy_to_user+0x18/0x5d   <7815c9be> filldir64+0x94/0xc3
> <7817c08f> sysfs_readdir+0x17d/0x1c2   <7815c92a> filldir64+0x0/0xc3
> <7815c92a> filldir64+0x0/0xc3   <7815c6ef> vfs_readdir+0x63/0x89
> <7815ca53> sys_getdents64+0x66/0xb3   <78296f41> _spin_unlock+0xf/0x23
> <7815be56> do_fcntl+0xc3/0x136   <78102be3> syscall_call+0x7/0xb
> SCSI subsystem initialized
> libata version 1.20 loaded.
> ata_piix 0000:00:1f.2: version 1.05
> ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
> ata: 0x170 IDE port busy
> .....
> 

this is a bug in the hdaps mutex conversion; mutex code isn't allowed to
run in IRQ context, not even the trylock.


