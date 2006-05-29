Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWE2DCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWE2DCM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 23:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWE2DCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 23:02:11 -0400
Received: from rtr.ca ([64.26.128.89]:37032 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751128AbWE2DCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 23:02:08 -0400
Message-ID: <447A642F.6080500@rtr.ca>
Date: Sun, 28 May 2006 23:02:07 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Paul Dickson <dickson@permanentmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Resume stops working between 2.6.16 and 2.6.17-rc1 on Dell Inspiron
 6000
References: <20060528140238.2c25a805.dickson@permanentmail.com>	<1148850683.3074.72.camel@laptopd505.fenrus.org>	<20060528142951.2a7417cb.dickson@permanentmail.com>	<447A1AEF.3040900@rtr.ca> <20060528172101.a1b9725e.dickson@permanentmail.com>
In-Reply-To: <20060528172101.a1b9725e.dickson@permanentmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Dickson wrote:
> On Sun, 28 May 2006 17:49:35 -0400, Mark Lord wrote:
> 
>> We've just now put out a one-liner patch to libata that fixes
>> resume on my own Inspiron, and for other machines as well.
>>
>> Does it fix the problem here too?  (copy of patch is attached)
> 
> Yes.  I compiled 2.6.17-rc5 without it and verified the problem occurs,
> then applied the patch and tried it again.  This time it worked.
> 
> I can suspend AND hibernate with the patch.

Good!  That patch is in the latest 2.6.17-rc*-git* now.

>I still get the BUG message on resuming that I reported in bugzilla
...
> BUG: sleeping function called from invalid context at mm/slab.c:2794
> in_atomic():0, irqs_disabled():1
>  <c01c971b> acpi_os_acquire_object+0xf/0x3c  <c0149c48> kmem_cache_alloc+0x27/0x7f
>  <c01c971b> acpi_os_acquire_object+0xf/0x3c  <c01df220> acpi_ut_allocate_object_desc_dbg+0xc/0x40
>  <c01df26d> acpi_ut_create_internal_object_dbg+0x19/0x70  <c01db3ef> acpi_rs_set_srs_method_data+0x40/0xc5
>  <c01e545d> acpi_pci_link_set+0x3e/0x16d  <c0149c96> kmem_cache_alloc+0x75/0x7f
>  <c01e5515> acpi_pci_link_set+0xf6/0x16d  <c01e55c0> irqrouter_resume+0x34/0x52
>  <c020eb77> __sysdev_resume+0x12/0x55  <c020ecd4> sysdev_resume+0x16/0x47
>  <c0213117> device_power_up+0x5/0xa  <c01293db> suspend_enter+0x32/0x3a
>  <c0129504> enter_state+0x121/0x13e  <c01295a2> state_store+0x81/0x94
>  <c0182fa9> sysfs_write_file+0xa3/0xc9  <c014d4c8> vfs_write+0xa2/0x136
>  <c014d9d2> sys_write+0x3b/0x64  <c0102ab3> syscall_call+0x7/0xb

Yup, pretty obvious bug in the acpi code.
Something probably needs to use GFP_ATOMIC there.

