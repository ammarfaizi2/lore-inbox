Return-Path: <linux-kernel-owner+w=401wt.eu-S1751749AbXAVOAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbXAVOAr (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 09:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbXAVOAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 09:00:47 -0500
Received: from ns2.gothnet.se ([82.193.160.251]:4628 "EHLO
	GOTHNET-SMTP2.gothnet.se" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751749AbXAVOAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 09:00:46 -0500
Message-ID: <45B4BF50.9010105@tungstengraphics.com>
Date: Mon, 22 Jan 2007 14:42:40 +0100
From: =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <thomas@tungstengraphics.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060921)
MIME-Version: 1.0
To: Tilman Schmidt <tilman@imap.cc>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net, Dave Airlie <airlied@linux.ie>
Subject: Re: i810fb fails to load
References: <20070111222627.66bb75ab.akpm@osdl.org>	<45AAC244.8060607@imap.cc> <20070114162235.4c8d241f.akpm@osdl.org>
In-Reply-To: <20070114162235.4c8d241f.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040402070000080100090800"
X-BitDefender-Scanner: Mail not scanned due to license constraints
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040402070000080100090800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Andrew Morton wrote:
>> On Mon, 15 Jan 2007 00:52:36 +0100 Tilman Schmidt <tilman@imap.cc> wro=
te:
>> With kernel 2.6.20-rc4-mm1 and all hotfixes, i810fb fails to load on m=
y
>> Dell Optiplex GX110. Here's an excerpt of the diff between the boot lo=
gs
>> of 2.6.20-rc5 (working) and 2.6.20-rc4-mm1 (non-working):
>>
>> @@ -4,7 +4,7 @@
>>  No module symbols loaded - kernel modules not enabled.
>>
>>  klogd 1.4.1, log source =3D ksyslog started.
>> -<5>Linux version 2.6.20-rc5-noinitrd (ts@gx110) (gcc version 4.0.2 20=
050901 (prerelease) (SUSE Linux)) #2 PREEMPT Sun Jan 14 23:37:12 CET 2007
>> +<5>Linux version 2.6.20-rc4-mm1-noinitrd (ts@gx110) (gcc version 4.0.=
2 20050901 (prerelease) (SUSE Linux)) #3 PREEMPT Sun Jan 14 21:08:56 CET =
2007
>>  <6>BIOS-provided physical RAM map:
>>  <4>sanitize start
>>  <4>sanitize end
>> @@ -188,7 +192,6 @@
>>  <6>ACPI: Interpreter enabled
>>  <6>ACPI: Using PIC for interrupt routing
>>  <6>ACPI: PCI Root Bridge [PCI0] (0000:00)
>> -<7>PCI: Probing PCI hardware (bus 00)
>>  <6>ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
>>  <7>Boot video device is 0000:00:01.0
>>  <4>PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
>> @@ -238,20 +241,15 @@
>>  <6>isapnp: No Plug & Play device found
>>  <6>Real Time Clock Driver v1.12ac
>>  <6>Intel 82802 RNG detected
>> -<6>Linux agpgart interface v0.101 (c) Dave Jones
>> +<6>Linux agpgart interface v0.102 (c) Dave Jones
>>  <6>agpgart: Detected an Intel i810 E Chipset.
>>  <6>agpgart: detected 4MB dedicated video ram.
>>  <6>agpgart: AGP aperture is 64M @ 0xf8000000
>>  <4>ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
>>  <7>PCI: setting IRQ 9 as level-triggered
>>  <6>ACPI: PCI Interrupt 0000:00:01.0[A] -> Link [LNKA] -> GSI 9 (level=
, low) -> IRQ 9
>> -<4>i810-i2c: Probe DDC1 Bus
>> -<4>i810fb_init_pci: DDC probe successful
>> -<4>Console: switching to colour frame buffer device 160x64
>> -<4>I810FB: fb0         : Intel(R) 810E Framebuffer Device v0.9.0
>> -<4>I810FB: Video RAM   : 4096K
>> -<4>I810FB: Monitor     : H: 30-83 KHz V: 55-75 Hz
>> -<4>I810FB: Mode        : 1280x1024-8bpp@60Hz
>> +<4>i810fb_alloc_fbmem: can't bind framebuffer memory
>> +<4>i810fb: probe of 0000:00:01.0 failed with error -16
>>  <6>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing e=
nabled
>>  <6>serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
>>  <6>serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
>>
>> Please let me know if you need more information.
>>
>>    =20
>
> Don't know.  But I bet someone on the Cc does...
>  =20
Tilman,
Thanks for reporting.
Can you try the attached patch to see if that fixes the problem.

Regards,
Thomas Hellstr=F6m



--------------040402070000080100090800
Content-Type: text/x-patch;
 name="i810fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i810fix.diff"

diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
index 91c1f36..6ef0960 100644
--- a/drivers/char/agp/generic.c
+++ b/drivers/char/agp/generic.c
@@ -190,6 +190,7 @@ struct agp_memory *agp_create_memory(int
 		return NULL;
 	}
 	new->num_scratch_pages = scratch_pages;
+	new->type = AGP_NORMAL_MEMORY;
 	return new;
 }
 EXPORT_SYMBOL(agp_create_memory);
diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
index b8896c8..5a0713c 100644
--- a/drivers/char/agp/intel-agp.c
+++ b/drivers/char/agp/intel-agp.c
@@ -260,6 +260,7 @@ static int intel_i810_insert_entries(str
 		readl(intel_i810_private.registers+I810_PTE_BASE+((i-1)*4));
 		break;
 	case AGP_PHYS_MEMORY:
+	case AGP_NORMAL_MEMORY:
 		if (!mem->is_flushed)
 			global_cache_flush();
 		for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {

--------------040402070000080100090800--



