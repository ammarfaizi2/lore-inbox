Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbTGAPtX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 11:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbTGAPtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 11:49:23 -0400
Received: from mailproxy3.netcologne.de ([194.8.194.221]:50866 "EHLO
	mailproxy3.netcologne.de") by vger.kernel.org with ESMTP
	id S262498AbTGAPtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 11:49:19 -0400
From: Olaf Wendisch <nc-drwendde@netcologne.de>
To: alan@redhat.com
Subject: i810_audio module oopses on removing
Date: Tue, 1 Jul 2003 18:03:23 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LDbA/fmruczpG9H"
Message-Id: <200307011803.23910.nc-drwendde@netcologne.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_LDbA/fmruczpG9H
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
trying to remove the module i810_audio using 2.4.21-ac4
does reliably result in an oops:
Jul  1 10:00:35 legendre kernel: Intel 810 + AC97 Audio, version 0.24, 
09:17:53 Jul  1 2003
Jul  1 10:00:35 legendre kernel: i810: Intel ICH2 found at IO 0xe800 and 
0xec00, MEM 0x0000 and 0x0000, IRQ 10
Jul  1 10:00:36 legendre kernel: i810_audio: Audio Controller supports 6 
channels.
Jul  1 10:00:36 legendre kernel: i810_audio: Defaulting to base 2 channel 
mode.
Jul  1 10:00:36 legendre kernel: i810_audio: Resetting connection 0
Jul  1 10:00:36 legendre kernel: ac97_codec: AC97  codec, id: CMI97 (CMedia)
Jul  1 10:00:36 legendre kernel: AC97 codec does not have proper volume 
support.
Jul  1 10:00:36 legendre kernel: i810_audio: only 48Khz playback available.
Jul  1 10:00:36 legendre kernel: i810_audio: AC'97 codec 0, new EID value = 
0x05c6
Jul  1 10:00:36 legendre kernel: i810_audio: AC'97 codec 0, DAC map 
configured, total channels = 6

Warning (compare_ksyms_lsmod): module i810_audio is in lsmod but not in ksyms, 
probably no symbols exported
Jul  1 10:00:42 legendre kernel: f895fcea
Jul  1 10:00:42 legendre kernel: Oops: 0002
Jul  1 10:00:42 legendre kernel: CPU:    0
Jul  1 10:00:42 legendre kernel: EIP:    0010:[<f895fcea>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jul  1 10:00:42 legendre kernel: EFLAGS: 00010246
Jul  1 10:00:42 legendre kernel: eax: 00000000   ebx: f7b02b80   ecx: f89622d8   
edx: 00000000
Jul  1 10:00:42 legendre kernel: esi: f6f44000   edi: 00000000   ebp: bfffe968   
esp: f4b6ff54
Jul  1 10:00:42 legendre kernel: ds: 0018   es: 0018   ss: 0018
Jul  1 10:00:42 legendre kernel: Process rmmod (pid: 513, stackpage=f4b6f000)
Jul  1 10:00:42 legendre kernel: Stack: c020d605 f74208c0 00000000 f896852c 
f7b02b80 0000ec00 00000100 f7eeb400
Jul  1 10:00:42 legendre kernel:        f8969ae0 c020e59b f7eeb400 f8964000 
fffffff0 f89689be f8969ae0 c01186c2
Jul  1 10:00:42 legendre kernel:        f8964000 f8964000 fffffff0 f4eae000 
c0117b27 f8964000 00000000 00001000
Jul  1 10:00:42 legendre kernel: Call Trace:    [unregister_sound_mixer+23/27] 
[<f896852c>] [<f8969ae0>] [pci_unregister_driver+88/90] [<f89689be>]
Jul  1 10:00:42 legendre kernel:   [<f8969ae0>] [free_module+166/174] 
[sys_delete_module+161/428] [system_call+51/56]
Jul  1 10:00:42 legendre kernel: Code: 89 50 04 89 02 c7 43 04 00 00 00 00 c7 
03 00 00 00 00 ff 05


>>EIP; f895fcea <[ac97_codec]ac97_release_codec+21/62>   <=====

>>ebx; f7b02b80 <_end+377bb8d4/38617db4>
>>ecx; f89622d8 <[ac97_codec]codec_sem+0/f>
>>esi; f6f44000 <_end+36bfcd54/38617db4>
>>esp; f4b6ff54 <_end+34828ca8/38617db4>

Trace; f8969ae0 <.data.end+77f9/????>

Code;  f895fcea <[ac97_codec]ac97_release_codec+21/62>
00000000 <_EIP>:
Code;  f895fcea <[ac97_codec]ac97_release_codec+21/62>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  f895fced <[ac97_codec]ac97_release_codec+24/62>
   3:   89 02                     mov    %eax,(%edx)
Code;  f895fcef <[ac97_codec]ac97_release_codec+26/62>
   5:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  f895fcf6 <[ac97_codec]ac97_release_codec+2d/62>
   c:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  f895fcfc <[ac97_codec]ac97_release_codec+33/62>
  12:   ff 05 00 00 00 00         incl   0x0

2 warnings issued.  Results may not be reliable.

Attached is my .config.
Cheers,
	Olaf

--Boundary-00=_LDbA/fmruczpG9H
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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
fxFwpIjtTgAA

--Boundary-00=_LDbA/fmruczpG9H--

