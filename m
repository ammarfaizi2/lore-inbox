Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129645AbQKWCUC>; Wed, 22 Nov 2000 21:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129994AbQKWCTv>; Wed, 22 Nov 2000 21:19:51 -0500
Received: from cp38760-a.roose1.nb.nl.home.com ([212.204.135.104]:29969 "EHLO
        obelix.fvdpol.home.nl") by vger.kernel.org with ESMTP
        id <S129645AbQKWCTe>; Wed, 22 Nov 2000 21:19:34 -0500
Date: Thu, 23 Nov 2000 02:49:27 +0100
From: Frank van de Pol <fvdpol@home.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11 + ALSA 0.6pre1 version is OOPSing 
Message-ID: <20001123024927.B6395@idefix.fvdpol.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After upgrade to 2.4.0-test11 my copy of ALSA 0.6pre1 (cvs version) stopped
working (causing OOPS on module load of snd-card-sbawe). I reverted back to
2.4.0-test10 and verified that the problem does not exist in that version.

I'm running an SMP kernel in case that matters. Similar problem was also
reported by another ALSA user (might be irrelevant, but he's also using
SMP). Problem exists after fresh rebuild of both linux and ALSA, and is
reproducable between reboots.

The (source) code at which the OOPS occurs looks sane. 

Could any of the changes between 2.4.0-test10 and 2.4.0-test11 cause this
behaviour??? 

Thanks,
Frank.




I'm using kernel 2.4.0-test11, and the 20 nov 2000, 23:15 cvs version.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c885d054
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c885d054>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: 00000020   ecx: c0237fa0   edx: c105a114
esi: 00000008   edi: 00000000   ebp: c885e944   esp: c7b09ef4
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 109, stackpage=c7b09000)
Stack: c885dc18 c885e79c c885da9c ffffffff 00000299 c885d000 c885db90 00000007 
       c011c2fd c7b08000 00000000 00000000 bfffdf90 00000007 c882a000 c882a000 
       c7b08000 00000054 c7b09f60 c885e8e8 c1531000 000017b0 0000000e c1532000 
Call Trace: [<c885dc18>] [<c885e79c>] [<c885da9c>] [<c885d000>] [<c885db90>] [<c011c2fd>] [<c882a000>] 
       [<c882a000>] [<c885e8e8>] [<c885a000>] [<c885d060>] [<c010a723>] 
Code: 00 00 00 00 00 00 00 00 00 00 00 00 8b 7c 24 14 74 1a 89 f6 

>>EIP; c885d054 <[snd-card-sbawe]snd_legacy_auto_probe+0/34>   <=====
Trace; c885dc18 <[snd-card-sbawe]alsa_card_sb16_init+88/fc>
Trace; c885e79c <[snd-card-sbawe]possible_ports.5+0/13>
Trace; c885da9c <[snd-card-sbawe]snd_sb16_probe_legacy_port+0/80>
Trace; c885d000 <[snd-sb16-dsp]__kstrtab_snd_sb16dsp_interrupt+16fa/174e>
Trace; c885db90 <[snd-card-sbawe]init_module+0/0>
Trace; c011c2fd <sys_init_module+5b5/69c>
Trace; c882a000 <[soundcore]__kstrtab_mod_firmware_load+10a6/10fa>
Trace; c882a000 <[soundcore]__kstrtab_mod_firmware_load+10a6/10fa>
Trace; c885e8e8 <[snd-card-sbawe]__module_description+14/4b3>
Trace; c885a000 <[snd-pcm]__kstrtab_snd_pcm_lib_fragment_bytes+1730/1784>
Trace; c885d060 <[snd-card-sbawe]snd_legacy_auto_probe+c/34>
Trace; c010a723 <system_call+33/38>
Code;  c885d054 <[snd-card-sbawe]snd_legacy_auto_probe+0/34>   <=====
00000000 <_EIP>:   <=====
Code;  c885d060 <[snd-card-sbawe]snd_legacy_auto_probe+c/34>
   c:   8b 7c 24 14               mov    0x14(%esp,1),%edi
Code;  c885d064 <[snd-card-sbawe]snd_legacy_auto_probe+10/34>
  10:   74 1a                     je     2c <_EIP+0x2c> c885d080 <[snd-card-sbawe]snd_legacy_auto_probe+2c/34>
Code;  c885d066 <[snd-card-sbawe]snd_legacy_auto_probe+12/34>
  12:   89 f6                     mov    %esi,%esi


[root@idefix /root]# cat /proc/modules
binfmt_misc             3688   0
nfs                    53056   1 (autoclean)
nfsd                   46536   8 (autoclean)
lockd                  38856   1 (autoclean) [nfs nfsd]
sunrpc                 62104   1 (autoclean) [nfs nfsd lockd]
de4x5                  42644   1 (autoclean)
serial                 43556   0 (autoclean)
agpgart                14468   0 (unused)
st                     27624   0 (unused)
nls_iso8859-1           2840   4 (autoclean)
nls_cp437               4352   4 (autoclean)
vfat                   11596   4 (autoclean)
fat                    32216   0 (autoclean) [vfat]
snd-card-sbawe          6460 (initializing)
snd-sb16-dsp            6428   0 [snd-card-sbawe]
snd-pcm                34168   0 [snd-sb16-dsp]
snd-sb16-csp           16248   0 [snd-card-sbawe]
snd-sb-common           7308   0 [snd-card-sbawe snd-sb16-dsp snd-sb16-csp]
snd-opl3                6496   0 [snd-card-sbawe]
snd-hwdep               3852   0 [snd-sb16-csp snd-opl3]
snd-timer               9816   0 [snd-pcm snd-opl3]
snd-emu8000            11268   0 [snd-card-sbawe]
snd-mpu401-uart         3416   0 [snd-card-sbawe snd-sb16-dsp]
snd-rawmidi            10584   0 [snd-mpu401-uart]
snd-seq-device          4336   0 [snd-opl3 snd-emu8000 snd-rawmidi]
snd                    28376   0 [snd-card-sbawe snd-sb16-dsp snd-pcm
snd-sb16-csp snd-sb-common snd-opl3 snd-hwdep snd-timer snd-emu8000
snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3812   0 [snd]
usb-uhci               23404   0 (unused)
usbcore                53056   1 [usb-uhci]


-- 
+---- --- -- -  -   -    - 
|Frank van de Pol                  -o)
| FvdPol@home.nl                   /\\
|                                 _\_v
|Linux - Why use Windows, since there is a door?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
