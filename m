Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbVLFUMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbVLFUMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbVLFUMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:12:34 -0500
Received: from mail.gmx.de ([213.165.64.20]:6877 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932627AbVLFUMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:12:33 -0500
X-Authenticated: #26200865
Message-ID: <4395F0AB.1080408@gmx.net>
Date: Tue, 06 Dec 2005 21:12:27 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, stable@kernel.org,
       acpi-devel <acpi-devel@lists.sourceforge.net>
Subject: Re: [stable] [PATCH] Fix oops in asus_acpi.c on Samsung P30/P35 Laptops
References: <4395D945.6080108@gmx.net> <20051206192136.GA22615@kroah.com>
In-Reply-To: <20051206192136.GA22615@kroah.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH schrieb:
> On Tue, Dec 06, 2005 at 07:32:37PM +0100, Carl-Daniel Hailfinger wrote:
> 
>>Hi,
>>
>>on insmod of asus_acpi on my Samsung P35 laptop I get the following
>>Oops (perfectly reproducible):
>>
>>Asus Laptop ACPI Extras version 0.29
>>Unable to handle kernel NULL pointer dereference at virtual address 00000000
>> printing eip:
>>e1dfc362
>>*pde = 00000000
>>Oops: 0000 [#1]
>>Modules linked in: asus_acpi thermal processor fan button battery ac 
>>snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm 
>>snd_timer snd soundcore
>>snd_page_alloc ipt_TOS ipt_LOG ipt_limit ipt_pkttype pcmcia firmware_class 
>>ipt_state ip6t_REJECT ipt_REJECT iptable_mangle iptable_nat iptable_filter 
>>ip6table_mangle
>>ip_nat_ftp ip_nat ip_conntrack_ftp ip_conntrack nfnetlink ip_tables 
>>ip6table_filter ip6_tables ipv6 evdev sg sd_mod sr_mod scsi_mod intel_agp 
>>agpgart ohci1394 ieee1394
>>yenta_socket rsrc_nonstatic pcmcia_core ehci_hcd uhci_hcd i2c_i801 joydev 
>>dm_mod usbcore 8139too mii reiserfs ide_cd cdrom ide_disk piix ide_core
>>CPU:    0
>>EIP:    0060:[<e1dfc362>]    Not tainted VLI
>>EFLAGS: 00010203   (2.6.15-rc5)
>>EIP is at asus_hotk_get_info+0x17f/0x76c [asus_acpi]
>>eax: def75000   ebx: de8aaf54   ecx: 00000002   edx: 00000003
>>esi: 00000000   edi: e1e82a9c   ebp: dde2fea0   esp: de8aaf48
>>ds: 007b   es: 007b   ss: 0068
>>Process modprobe (pid: 6566, threadinfo=de8aa000 task=ddac05b0)
>>Stack: 00000000 00005105 deef8000 00000010 dde2fea0 dfeddc00 e1e83196 
>>dfeddc84
>>       dfedd820 e1dfc982 e1dfca11 dfeddc00 e1e849e0 00000000 c021c2fa 
>>       dfeddc00
>>       e1e849e0 c021c39e e1e84b00 0805bc08 00000028 de8aa000 e1dfcb20 
>>       c0133b32
>>Call Trace:
>> [<e1dfc982>] asus_hotk_check+0x33/0x34 [asus_acpi]
>> [<e1dfca11>] asus_hotk_add+0x8e/0x148 [asus_acpi]
>> [<c021c2fa>] acpi_bus_driver_init+0x2e/0x57
>> [<c021c39e>] acpi_driver_attach+0x3e/0x63
>> [<e1dfcb20>] asus_acpi_init+0x55/0x7d [asus_acpi]
>> [<c0133b32>] sys_init_module+0xf2/0x180
>> [<c0102e6f>] sysenter_past_esp+0x54/0x75
>>Code: 08 68 7f 30 e8 e1 e8 0e f2 31 de 58 5a a1 10 4d e8 e1 ba 03 00 00 00 
>>bf 9c 2a e8 e1 89 d1 c7 40 14 12 00 00 00 8b 75 08 49 78 08 <ac> ae 75 08 
>>84 c0 75 f5 31 c0 eb 04
>>19 c0 0c 01 85 c0 75 11 a1
>>
>>
>>This oops affects all kernels since 2.6.12. Patch follows.
>>Please apply.
> 
> 
> Is this patch accepted by the acpi maintainers yet?

No, although it was posted to acpi-devel, it did not generate any
comment. The problem itself has been posted to acpi-devel many times
over. The first patch by Christian Aichinger did generate some
feedback and the patch I sent was his newest version which nobody
commented upon. This patch is also the last patch from
http://bugzilla.kernel.org/show_bug.cgi?id=5067
Only users commented on the patch, not any maintainer.

However, since this oops has been unfixed for over 5 months and
nobody seems to care, I submitted the patch to stable@ in the
hope somebody would at least look at it.


>>+	/* INIT on Samsung's P35 returns an integer, possible return
>>+	 * values are tested below */
>>+	if (model->type == ACPI_TYPE_INTEGER) {
>>+		if (model->integer.value == -1 ||
>>+			model->integer.value == 0x58 ||
>>+			model->integer.value == 0x38) {
>>+			hotk->model = P30;
>>+			printk(KERN_NOTICE
>>+				       "  Samsung P35 detected, 
>>supported\n");
> 
> 
> Linewrapped :(

Should not be. I just rechecked the settings, used view-source of
my mail and looked at the MARC archive. It's not wrapped afaics but
I might be wrong. Do you want the patch as attachment?
However, if you refer to the coding style, I have to agree.

> Are you sure that if logic is correct?

Well, it doesn't oops anymore and SUSE has been shipping this patch
in their kernels for SUSE 10.0. I don't know whether the logic is
correct, but at least it didn't break anything and fixed the bug.

> thanks,
> 
> greg k-h

Regards,
Carl-Daniel
