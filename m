Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283212AbRLDP06>; Tue, 4 Dec 2001 10:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283054AbRLDOmT>; Tue, 4 Dec 2001 09:42:19 -0500
Received: from danielle.hinet.hr ([195.29.148.143]:18360 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S284383AbRLDOfR>; Tue, 4 Dec 2001 09:35:17 -0500
Date: Tue, 4 Dec 2001 15:35:07 +0100
From: Mario Mikocevic <mozgy@hinet.hr>
To: Doug Ledford <dledford@redhat.com>
Cc: Nathan Bryant <nbryant@optonline.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
Message-ID: <20011204153507.A842@danielle.hinet.hr>
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0C61CC.1060703@redhat.com>; from dledford@redhat.com on Tue, Dec 04, 2001 at 12:40:28AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Well, your second version of the file had the merge done right (my code 
> didn't include S/PDIF support or PM support, so those parts were 
> different, but the parts that were the same as my code were done 
> correctly).  I'm attaching a patch that bumps the code from your 0.05b 
> to a unified 0.06 and I'm also placing the 0.06 i810_audio.c.gz file on 
> my web site in the same place that I put the 0.05 version.  If people 
> could please test this and report problems back, I would like to get 
> this one off my plate (aka, I don't want to hear any more about artsd 
> not working ever again so I want testers to tell me that it's fixed ;-)

Umh, problems ->

modprobe produced an oops (17-pre2), module is left in init state :

# lsmod
Module                  Size  Used by
i810_audio             19472   1  (initializing)
ac97_codec              9632   0  [i810_audio]

Intel 810 + AC97 Audio, version 0.06, 15:21:16 Dec  4 2001
PCI: Found IRQ 9 for device 00:1f.5
PCI: Sharing IRQ 9 with 00:1f.3
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH2 found at IO 0xef00 and 0xe800, IRQ 9
i810_audio: Audio Controller supports 6 channels.
ac97_codec: AC97 Audio codec, id: 0x4144:0x5360 (Analog Devices AD1885)
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2


# ksymoops < oops0 
ksymoops 2.4.1 on i686 2.4.17-pre2-mzg2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-pre2-mzg2/ (default)
     -m /boot/System.map-2.4.17-pre2-mzg2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

cpu: 0, clocks: 1329057, slice: 664528
ac97_codec: AC97 Audio codec, id: 0x4144:0x5360 (Analog Devices AD1885)
CPU:    0
EIP:    0010:[<d08f944e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 14244000   ebx: 00000000   ecx: 18000004   edx: 00000000
esi: cfe07880   edi: cfe077b0   ebp: 00000000   esp: ce817e90
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 727, stackpage=ce817000)
Stack: 00000000 cfe07780 0000009c cfe0781c cfea2400 d08fc761 cfe07780 0000bb80 
       00000180 d08fc60f d08fda60 cfe077b0 cfe07780 cfd96800 d08fd930 cfd96800 
       d08fd0c7 cfea2400 d08fcc17 d08fd998 d08fdac0 cfea2400 00000000 c01aa55c 
Call Trace: [<d08fc761>] [<d08fc60f>] [<d08fda60>] [<d08fd930>] [<d08fd0c7>] 
   [<d08fcc17>] [<d08fd998>] [<d08fdac0>] [<c01aa55c>] [<d08fd998>] [<d08fdac0>] 
   [<c01aa5c2>] [<d08fdac0>] [<d08fcd94>] [<d08fdac0>] [<d08fd740>] [<c0117f25>] 
   [<d08fdbd8>] [<d08f9060>] [<c0106f1b>] 
Code: f7 35 28 d9 8f d0 89 07 8b 07 59 5b 5e 5f 5d c3 89 f6 55 57 

>>EIP; d08f944e <[i810_audio]i810_set_dac_rate+9e/b0>   <=====
Trace; d08fc761 <[i810_audio]i810_configure_clocking+c1/2c0>
Trace; d08fc60f <[i810_audio]i810_ac97_init+2bf/350>
Trace; d08fda60 <[i810_audio]i810_mixer_fops+0/60>
Trace; d08fd930 <[i810_audio]card_names+0/14>
Trace; d08fd0c7 <[i810_audio].rodata.end+c/11>
Trace; d08fcc17 <[i810_audio]i810_probe+2b7/360>
Trace; d08fd998 <[i810_audio]i810_pci_tbl+54/a8>
Trace; d08fdac0 <[i810_audio]i810_pci_driver+0/3f>
Trace; c01aa55c <pci_announce_device+3c/60>
Trace; d08fd998 <[i810_audio]i810_pci_tbl+54/a8>
Trace; d08fdac0 <[i810_audio]i810_pci_driver+0/3f>
Trace; c01aa5c2 <pci_register_driver+42/60>
Trace; d08fdac0 <[i810_audio]i810_pci_driver+0/3f>
Trace; d08fcd94 <[i810_audio]i810_init_module+24/a0>
Trace; d08fdac0 <[i810_audio]i810_pci_driver+0/3f>
Trace; d08fd740 <[i810_audio].LC31+28/40>
Trace; c0117f25 <sys_init_module+555/630>
Trace; d08fdbd8 <.data.end+d9/????>
Trace; d08f9060 <[i810_audio]i810_alloc_pcm_channel+0/4>
Trace; c0106f1b <system_call+33/38>
Code;  d08f944e <[i810_audio]i810_set_dac_rate+9e/b0>
00000000 <_EIP>:
Code;  d08f944e <[i810_audio]i810_set_dac_rate+9e/b0>   <=====
   0:   f7 35 28 d9 8f d0         div    0xd08fd928,%eax   <=====
Code;  d08f9454 <[i810_audio]i810_set_dac_rate+a4/b0>
   6:   89 07                     mov    %eax,(%edi)
Code;  d08f9456 <[i810_audio]i810_set_dac_rate+a6/b0>
   8:   8b 07                     mov    (%edi),%eax
Code;  d08f9458 <[i810_audio]i810_set_dac_rate+a8/b0>
   a:   59                        pop    %ecx
Code;  d08f9459 <[i810_audio]i810_set_dac_rate+a9/b0>
   b:   5b                        pop    %ebx
Code;  d08f945a <[i810_audio]i810_set_dac_rate+aa/b0>
   c:   5e                        pop    %esi
Code;  d08f945b <[i810_audio]i810_set_dac_rate+ab/b0>
   d:   5f                        pop    %edi
Code;  d08f945c <[i810_audio]i810_set_dac_rate+ac/b0>
   e:   5d                        pop    %ebp
Code;  d08f945d <[i810_audio]i810_set_dac_rate+ad/b0>
   f:   c3                        ret    
Code;  d08f945e <[i810_audio]i810_set_dac_rate+ae/b0>
  10:   89 f6                     mov    %esi,%esi
Code;  d08f9460 <[i810_audio]i810_set_adc_rate+0/b0>
  12:   55                        push   %ebp
Code;  d08f9461 <[i810_audio]i810_set_adc_rate+1/b0>
  13:   57                        push   %edi


1 warning issued.  Results may not be reliable.


-- 
Mario Mikoèeviæ (Mozgy)
mozgy at hinet dot hr
My favourite FUBAR ...
