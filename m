Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbUKHW16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbUKHW16 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbUKHW16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:27:58 -0500
Received: from alog0167.analogic.com ([208.224.220.182]:12160 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261277AbUKHW1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:27:38 -0500
Date: Mon, 8 Nov 2004 17:25:20 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Karsten Wiese <annabellesgarden@yahoo.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.10-rc1-mm3
In-Reply-To: <200411082240.02787.annabellesgarden@yahoo.de>
Message-ID: <Pine.LNX.4.61.0411081716280.8258@chaos.analogic.com>
References: <200411081334.18751.annabellesgarden@yahoo.de>
 <200411082240.02787.annabellesgarden@yahoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004, Karsten Wiese wrote:

> Am Montag 08 November 2004 13:34 schrieb Karsten Wiese:
>> Hi
>>
>> This bug is triggered by logging on to bash (runlevel 3),
>> typing "cat /proc/acpi", then <TAB> gives the correct "/" to complete,
>> the 2nd <TAB> has no visual effect, the 3rd <TAB> generates this oops:
>>
>> Unable to handle kernel paging request at virtual address f89e7b00
>>  printing eip:
>> c0187452
>> *pde = 37ff1067
>> *pte = 00000000
>> Oops: 0000 [#1]
>> PREEMPT SMP
>> Modules linked in: binfmt_misc video ohci1394 ieee1394 uhci_hcd intel_agp agpgart i2c_i801 i2c_core snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore ext3 jbd ata_piix libata sd_mod scsi_mod
>> CPU:    0
>> EIP:    0060:[<c0187452>]    Not tainted VLI
>> EFLAGS: 00010286   (2.6.10-rc1-mm3)
>> EIP is at proc_get_inode+0xa0/0x184
>
> Found out, what happened:
> By accident I had ibm_acpi.ko built. Its name "ibm" was still present under "/proc/acpi".
> This is not an ibm(-laptop)-machine, so ibm_acpi.ko is useless here.
> "Unable to handle kernel paging request at virtual address f89e7b00":
> this address corresponds to the "struct module *" of ibm_acpi.ko, which was not loaded anymore.
> So the real bug here is that there is a non NULL "struct module *", where the corresponding module is unloaded.
> Or so I guess.....
>
> Best regards,
> Karsten

Yes, there is a patch floating around. The problem is
that the module name can be too long and it overwrites
kernel structures so that when the module is unloaded, part
of the structure remains corrupt so the kernel calls it
on the next open().


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
