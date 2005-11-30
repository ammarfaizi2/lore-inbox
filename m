Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbVK3S61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbVK3S61 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 13:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbVK3S61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 13:58:27 -0500
Received: from smtpout.mac.com ([17.250.248.45]:52213 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751501AbVK3S61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 13:58:27 -0500
In-Reply-To: <s5h3bleieve.wl%tiwai@suse.de>
References: <E066EDFE-FA32-4600-A1EC-721055EFA829@mac.com> <s5h3bleieve.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: multipart/mixed; boundary=Apple-Mail-2-451071230
Message-Id: <4147B17B-AAF6-491A-84A4-8501ADEBF5B6@mac.com>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH][RFC][2.6.15-rc3] snd_powermac: Add ID for Spring 2005 17" Powerbook
Date: Wed, 30 Nov 2005 13:58:13 -0500
To: Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-2-451071230
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

On Nov 30, 2005, at 05:55, Takashi Iwai wrote:
> At Tue, 29 Nov 2005 14:02:58 -0500,
> Kyle Moffett wrote:
>>
>> The audio chip in my Spring 2005 17" PowerBook was incorrectly  
>> recognized as an AWACS chip.  This adds the chip ID to the  
>> snd_powermac driver such that it is recognized as a Toonie (I  
>> don't know if that's correct, but it's the only one that makes it  
>> work at all). and sorts the ID lists numerically.  NOTE:  This  
>> chip is only minimally supported at this point; it has system beep  
>> support and very low volume speaker output, and that's about it.
>>
>> Signed-off-by: Kyle Moffett <mrmacman_g4@mac.com>
>
> Thanks, I applied it to ALSA tree now.

Damn, best revert that patch, I just realized I'm now getting a  
nonfatal oops during boot (probably due to the fact that the chip is  
not at all like a Toonie and only works using that driver due to  
sheer luck:

--Apple-Mail-2-451071230
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	x-unix-mode=0644;
	name="oops.txt"
Content-Disposition: attachment;
	filename=oops.txt

Nov 30 13:49:49 localhost kernel: input: PowerMac Beep as /class/input/input5
Nov 30 13:49:49 localhost kernel: Unable to handle kernel paging request for data at address 0xfe66e000
Nov 30 13:49:49 localhost kernel: Faulting instruction address: 0xc0015978
Nov 30 13:49:49 localhost kernel: Oops: Kernel access of bad area, sig: 11 [#1]
Nov 30 13:49:49 localhost kernel: PREEMPT 
Nov 30 13:49:49 localhost kernel: Modules linked in: sr_mod snd_powermac snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc sbp2 scsi_mod appletouch eth1394
Nov 30 13:49:49 localhost kernel: NIP: C0015978 LR: C00156D0 CTR: C0015970
Nov 30 13:49:49 localhost kernel: REGS: efe13be0 TRAP: 0300   Not tainted  (2.6.15-rc2-aphrodite2)
Nov 30 13:49:49 localhost kernel: MSR: 00009032 <EE,ME,IR,DR>  CR: 20000482  XER: 00000000
Nov 30 13:49:49 localhost kernel: DAR: FE66E000, DSISR: 40000000
Nov 30 13:49:49 localhost kernel: TASK = c1808c70[1095] 'alsactl' THREAD: efe12000
Nov 30 13:49:49 localhost kernel: GPR00: 00000004 EFE13C90 C1808C70 00000000 00880000 00000000 00000000 00000000 
Nov 30 13:49:49 localhost kernel: GPR08: 00000000 FDDEE000 C0015970 C0420000 20000448 100225F4 10026C68 00000000 
Nov 30 13:49:49 localhost kernel: GPR16: 7FFFA470 00000000 00000000 7FFFA580 1001D670 00000001 00000002 00000001 
Nov 30 13:49:49 localhost kernel: GPR24: C0F054A0 C0F054A0 C0E51800 FFFFFFF3 00000000 C19D8800 EFECA0C8 EFECA0C8 
Nov 30 13:49:49 localhost kernel: NIP [C0015978] core99_read_gpio+0x8/0x20
Nov 30 13:49:49 localhost kernel: LR [C00156D0] pmac_do_feature_call+0xb0/0x120
Nov 30 13:49:49 localhost kernel: Call Trace:
Nov 30 13:49:49 localhost kernel: [EFE13C90] [C00E8438] ext3_find_entry+0x458/0x650 (unreliable)
Nov 30 13:49:49 localhost kernel: [EFE13D10] [F2559754] check_audio_gpio+0x54/0x80 [snd_powermac]
Nov 30 13:49:49 localhost kernel: [EFE13D20] [F2559E88] toonie_put_mute_switch+0x88/0xe0 [snd_powermac]
Nov 30 13:49:49 localhost kernel: [EFE13D30] [F20EFA34] snd_ctl_elem_write+0x1d4/0x230 [snd]
Nov 30 13:49:49 localhost kernel: [EFE13D60] [F20F06AC] snd_ctl_ioctl+0xc1c/0x11f0 [snd]
Nov 30 13:49:49 localhost kernel: [EFE13EB0] [C009E804] do_ioctl+0x44/0xb0
Nov 30 13:49:49 localhost kernel: [EFE13ED0] [C009E8FC] vfs_ioctl+0x8c/0x510
Nov 30 13:49:49 localhost kernel: [EFE13F10] [C009EE14] sys_ioctl+0x94/0xb0
Nov 30 13:49:49 localhost kernel: [EFE13F40] [C000E46C] ret_from_syscall+0x0/0x44
Nov 30 13:49:49 localhost kernel: --- Exception: c01 at 0xfd8aeec
Nov 30 13:49:49 localhost kernel:     LR = 0xfe0e208
Nov 30 13:49:49 localhost kernel: Instruction dump:
Nov 30 13:49:49 localhost kernel: 4e800020 60000000 7d4903a6 4e800421 80010014 38210010 7c0803a6 4e800020 
Nov 30 13:49:49 localhost kernel: 60000000 60000000 3d60c042 812b342c <7c6920ae> 0c030000 4c00012c 4e800020 


--Apple-Mail-2-451071230
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


Sorry for the trouble and thanks anyways!

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/E/U d- s++: a18 C++++>$ ULBX*++++(+++)>$ P++++(+++)>$ L++++ 
(+++)>$ !E- W+++(++) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP 
+ t+(+++) 5 X R? !tv-(--) b++++(++) DI+(++) D+++ G e>++++$ h*(+)>++$ r 
%(--)  !y?-(--)
------END GEEK CODE BLOCK------




--Apple-Mail-2-451071230--
