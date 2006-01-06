Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWAFAaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWAFAaI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWAFAaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:30:08 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:54582 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932320AbWAFAaF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:30:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dXk+GtwBoIP1vKYY+L1Qvj0y1kLPmRnsyjcNZh98jffpd9YYImyJPl3Sc7mkMdhCaRFack2ZWSnK6dRhGiuc/qVbIjldIVhivXn/wp3b98f+9TMmtknIxVMrBGWxNmA6ShexsgM73v0avSpyd4aK4PazUaGU/sich3eloWwomMo=
Message-ID: <86802c440601051630i4d52aa2fj1a2990acf858cd63@mail.gmail.com>
Date: Thu, 5 Jan 2006 16:30:05 -0800
From: Yinghai Lu <yinghai.lu@amd.com>
To: vgoyal@in.ibm.com, Andi Kleen <ak@muc.de>
Subject: Re: Inclusion of x86_64 memorize ioapic at bootup patch
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "discuss@x86-64.org" <discuss@x86-64.org>, linuxbios@openbios.org
In-Reply-To: <20060103044632.GA4969@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060103044632.GA4969@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the patch is good.

I tried LinuxBIOS with kexec.

without this patch: I need to disable acpi in kernel. otherwise the
kernel with acpi support can boot the second kernel, but the second
kernel will hang after

time.c: Using 14.318180 MHz HPET timer.
time.c: Detected 2197.663 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 1009152k/1048576k available (2967k kernel code, 39036k reserved, 1186k )


YH

On 1/2/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> Hi Andi,
>
> Can you please include the following patch. This patch has already been pushed
> by Andrew.
>
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm3/broken-out/x86_64-io_apicc-memorize-at-bootup-where-the-i8259-is.patch
>
> This patch is regarding remembering at boot up time where i8259 is connected
> and restore the APIC settings back during kexec boot or kdump boot. This
> enables getting timer interrupts in new kernel in legacy mode.
>
> This patch is needed to make kexec and kdump work on some systems,
> especially opteron boxes. Otherwise the second kernel does not receive
> timer interrupts during early boot hence hangs.
>
> I understand, that you are inclined towards remembering all the APIC states
> and simply restore it back instead of putting hooks. This will work
> well for kexec but not for kdump because in kdump system can crash on
> non-boot cpu.
>
> Restoring BIOS APIC state can make sure that BIOS designated boot cpu will
> always be able to see timer interrupts in legacy mode but same does not
> hold good if new kernel boots on some other cpu as is the case with kdump.
>
> In case of kexec boot, we relocate to boot cpu but in case of kdump we
> don't because it was suggested that in some extreme cases of crash, boot cpu
> might not respond even to NMI and relocation to boot cpu will not be
> possible.
>
> Can you please re-consider this patch for inclusion.
>
> Thanks
> Vivek
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
