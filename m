Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVHTOtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVHTOtO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 10:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbVHTOtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 10:49:14 -0400
Received: from dvhart.com ([64.146.134.43]:61313 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751245AbVHTOtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 10:49:13 -0400
Date: Sat, 20 Aug 2005 07:49:06 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: 2.6.13-rc6-mm1
Message-ID: <2050000.1124549345@[10.10.2.4]>
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andrew Morton <akpm@osdl.org> wrote (on Friday, August 19, 2005 04:33:31 -0700):

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm1/
> 
> - Lots of fixes, updates and cleanups all over the place.
> 
> - If you have the right debugging options set, this kernel will generate
>   a storm of sleeping-in-atomic-code warnings at boot, from the scsi code.
>   It is being worked on.

Get a couple of debug warnings as you mention ... but then it panics.


scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: IBM       Model: GNHv1 S2          Rev: 0   
  Type:   Processor                          ANSI SCSI revision: 02
 target1:0:9: Beginning Domain Validation
 target1:0:9: Ending Domain Validation
  Vendor: IBM-ESXS  Model: DTN036C1UCDY10F   Rev: S25J
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi1:A:12:0: Tagged Queuing enabled.  Depth 253
 target1:0:12: Beginning Domain Validation
 target1:0:12: wide asynchronous.
 target1:0:12: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 127)
 target1:0:12: Ending Domain Validation
  Vendor: IBM-ESXS  Model: DTN036C1UCDY10F   Rev: S25J
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi1:A:13:0: Tagged Queuing enabled.  Depth 253
 target1:0:13: Beginning Domain Validation
 target1:0:13: wide asynchronous.
 target1:0:13: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 127)
 target1:0:13: Ending Domain Validation
scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scheduling while atomic: swapper/0x00000100/0
 [<c02f65c5>] schedule+0x45/0x724
 [<c0115a15>] __wake_up+0x31/0x3c
 [<c016892a>] dcache_shrinker_del+0x2e/0x38
 [<c0168c62>] dput_recursive+0x232/0x270
 [<c0168c95>] dput_recursive+0x265/0x270
 [<c02f7d0f>] __down+0x7f/0x108
 [<c0115978>] default_wake_function+0x0/0x1c
 [<c02f6517>] __down_failed+0x7/0xc
 [<c0233612>] .text.lock.attribute_container+0x8b/0xc1
 [<c02337eb>] transport_remove_device+0xf/0x14
 [<c0233784>] transport_remove_classdev+0x0/0x58
 [<c0265b62>] scsi_target_reap+0x86/0xb4
 [<c02670c0>] scsi_device_dev_release+0x134/0x15c
 [<c022f5b8>] device_release+0x14/0x4c
 [<c01bc2c3>] kobject_cleanup+0x47/0x6c
 [<c01bc2e8>] kobject_release+0x0/0x14
 [<c01bc2f5>] kobject_release+0xd/0x14
 [<c01bcb95>] kref_put+0x79/0x89
 [<c01bc312>] kobject_put+0x16/0x1c
 [<c01bc2e8>] kobject_release+0x0/0x14
 [<c022f925>] put_device+0x11/0x18
 [<c025ecad>] scsi_put_command+0xa5/0xb0
 [<c0263df5>] scsi_next_command+0x11/0x1c
 [<c0263ed9>] scsi_end_request+0xa9/0xb4
 [<c02644c1>] scsi_io_completion+0x489/0x494
 [<c02646da>] scsi_generic_done+0x32/0x38
 [<c025f618>] scsi_finish_command+0xa0/0xa8
 [<c025f52d>] scsi_softirq+0x139/0x154
 [<c011e32d>] __do_softirq+0x8d/0x100
 [<c011e3cf>] do_softirq+0x2f/0x34
 [<c011e474>] irq_exit+0x34/0x38
 [<c0104840>] do_IRQ+0x20/0x28
 [<c01033ae>] common_interrupt+0x1a/0x20
 [<c0100c00>] default_idle+0x0/0x2c
 [<c0100c23>] default_idle+0x23/0x2c
 [<c0100cf3>] cpu_idle+0x7b/0x8c
 [<c01002c8>] rest_init+0x28/0x2c
 [<c03de87f>] start_kernel+0x197/0x19c
scheduling while atomic: swapper/0x00000100/0
 [<c02f65c5>] schedule+0x45/0x724
 [<c011598f>] default_wake_function+0x17/0x1c
 [<c01159cb>] __wake_up_common+0x37/0x50
 [<c0115a15>] __wake_up+0x31/0x3c
 [<c02f6d34>] wait_for_completion+0x90/0xe8
 [<c0115978>] default_wake_function+0x0/0x1c
 [<c0115978>] default_wake_function+0x0/0x1c
 [<c01280c8>] call_usermodehelper_keys+0x144/0x15a
 [<c0127f38>] __call_usermodehelper+0x0/0x4c
 [<c0127f38>] __call_usermodehelper+0x0/0x4c
 [<c01bca4d>] kobject_hotplug+0x255/0x280
 [<c0231c39>] class_device_del+0x8d/0xa8
 [<c0233541>] attribute_container_class_device_del+0x11/0x18
 [<c02337d3>] transport_remove_classdev+0x4f/0x58
 [<c02333ef>] attribute_container_device_trigger+0x7f/0xb8
 [<c02337eb>] transport_remove_device+0xf/0x14
 [<c0233784>] transport_remove_classdev+0x0/0x58
 [<c0265b62>] scsi_target_reap+0x86/0xb4
 [<c02670c0>] scsi_device_dev_release+0x134/0x15c
 [<c022f5b8>] device_release+0x14/0x4c
 [<c01bc2c3>] kobject_cleanup+0x47/0x6c
 [<c01bc2e8>] kobject_release+0x0/0x14
 [<c01bc2f5>] kobject_release+0xd/0x14
 [<c01bcb95>] kref_put+0x79/0x89
 [<c01bc312>] kobject_put+0x16/0x1c
 [<c01bc2e8>] kobject_release+0x0/0x14
 [<c022f925>] put_device+0x11/0x18
 [<c025ecad>] scsi_put_command+0xa5/0xb0
 [<c0263df5>] scsi_next_command+0x11/0x1c
 [<c0263ed9>] scsi_end_request+0xa9/0xb4
 [<c02644c1>] scsi_io_completion+0x489/0x494
 [<c02646da>] scsi_generic_done+0x32/0x38
 [<c025f618>] scsi_finish_command+0xa0/0xa8
 [<c025f52d>] scsi_softirq+0x139/0x154
 [<c011e32d>] __do_softirq+0x8d/0x100
 [<c011e3cf>] do_softirq+0x2f/0x34
 [<c011e474>] irq_exit+0x34/0x38
 [<c0104840>] do_IRQ+0x20/0x28
 [<c01033ae>] common_interrupt+0x1a/0x20
 [<c0100c00>] default_idle+0x0/0x2c
 [<c0100c23>] default_idle+0x23/0x2c
 [<c0100cf3>] cpu_idle+0x7b/0x8c
 [<c01002c8>] rest_init+0x28/0x2c
 [<c03de87f>] start_kernel+0x197/0x19c
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0263cf2
*pde = 0042c001
*pte = 00000000
Oops: 0000 [#1]
SMP 
last sysfs file: 
CPU:    0
EIP:    0060:[<c0263cf2>]    Not tainted VLI
EFLAGS: 00010282   (2.6.13-rc6-mm1-autokern1) 
EIP is at scsi_run_queue+0xe/0xb4
eax: d777ce30   ebx: d777ce30   ecx: 00000282   edx: d6c4cc00
esi: d777ce30   edi: 00000000   ebp: 00000246   esp: c03dde98
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03dc000 task=c0373be0)
Stack: d777ce30 d777ce30 d76fb500 00000246 c0263dfb d777ce30 d76fb500 d777d70c 
       c0263ed9 d76fb500 d777d70c d6c4c400 d6c4cc00 00000024 d76fb500 c02644c1 
       d76fb500 00000000 00000024 00000001 d6c4c400 d6c4cc00 d76fb500 d76fb500 
Call Trace:
 [<c0263dfb>] scsi_next_command+0x17/0x1c
 [<c0263ed9>] scsi_end_request+0xa9/0xb4
 [<c02644c1>] scsi_io_completion+0x489/0x494
 [<c02646da>] scsi_generic_done+0x32/0x38
 [<c025f618>] scsi_finish_command+0xa0/0xa8
 [<c025f52d>] scsi_softirq+0x139/0x154
 [<c011e32d>] __do_softirq+0x8d/0x100
 [<c011e3cf>] do_softirq+0x2f/0x34
 [<c011e474>] irq_exit+0x34/0x38
 [<c0104840>] do_IRQ+0x20/0x28
 [<c01033ae>] common_interrupt+0x1a/0x20
 [<c0100c00>] default_idle+0x0/0x2c
 [<c0100c23>] default_idle+0x23/0x2c
 [<c0100cf3>] cpu_idle+0x7b/0x8c
 [<c01002c8>] rest_init+0x28/0x2c
 [<c03de87f>] start_kernel+0x197/0x19c


