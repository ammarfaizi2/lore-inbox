Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276933AbRJKVGZ>; Thu, 11 Oct 2001 17:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276923AbRJKVGP>; Thu, 11 Oct 2001 17:06:15 -0400
Received: from adsl-64-166-152-214.dsl.snfc21.pacbell.net ([64.166.152.214]:8714
	"EHLO gw.yeah.cx") by vger.kernel.org with ESMTP id <S276937AbRJKVGF> convert rfc822-to-8bit;
	Thu, 11 Oct 2001 17:06:05 -0400
Date: Thu, 11 Oct 2001 14:09:43 -0700
From: Andrew Over <ajo@acm.org>
To: linux-kernel@vger.kernel.org
Subject: Oops on removing via-rhine [2.4.10-ac11]
Message-ID: <20011011140943.A10576@yeah.cx>
Reply-To: Andrew Over <ajo@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.20i
X-OS: Linux 2.4.5-ac17 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Received the following oops when trying to remove via-rhine.

The kernel is 'tainted' by the ALSA modules (no NVdriver!), which
don't yet have the MODULE_LICENSE stuff done.

This occurs with kernel 2.4.10-ac11 (and also 2.4.10-ac8).  System in question is an Athlon 1400 running on a KT266 mobo.

After the oops, via-rhine is reported by lsmod as "(deleted)".

This oops is reasonably easy to reproduce (reinsert and remove
via-rhine enough times and it happens), and any further information is
available upon request.  Next time I reboot, I'll try reproducing the
problem without the ALSA modules.


ksymoops output:

Warning (compare_ksyms_lsmod): module via-rhine is in lsmod but not in ksyms, pr
obably no symbols exported
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0129841>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c18542d0   ebx: 00000000   ecx: c18542d0   edx: 00000000
esi: c1896c00   edi: c18542d0   ebp: bfffe8fc   esp: dcb6df28
ds: 0018   es: 0018   ss: 0018
Process rmmod (pid: 6729, stackpage=dcb6d000)
Stack: dfbfa400 c1896c00 dfbfa540 bfffe8fc ed0800ff 0000001c c1896c00 c01acd3f 
       c0129f1a c0129f44 c010b6bd e08fdbab c1896c00 00000200 df5b0000 1f5b0000 
       c1896c00 dfbfa400 c1896c00 e08fe860 e08fc000 c01ad01f c1896c00 e08fc000 
Call Trace: [<c01acd3f>] [<c0129f1a>] [<c0129f44>] [<c010b6bd>] [<e08fdbab>] 
   [<e08fe860>] [<c01ad01f>] [<e08fdc0a>] [<e08fe860>] [<c01150c7>] [<c0114457>]
 
   [<c0106c4b>] 
Code: 0f 0b 8b 57 08 85 d2 74 02 0f 0b 89 f8 2b 05 2c 04 27 c0 69 

>>EIP; c0129840 <__free_pages_ok+10/1c0>   <=====
Trace; c01acd3e <pci_release_regions+6e/80>
Trace; c0129f1a <__free_pages+1a/20>
Trace; c0129f44 <free_pages+24/30>
Trace; c010b6bc <pci_free_consistent+1c/20>
Trace; e08fdbaa <_end+2066e636/20670a8c>
Trace; e08fe860 <_end+2066f2ec/20670a8c>
Trace; c01ad01e <pci_unregister_driver+3e/60>
Trace; e08fdc0a <_end+2066e696/20670a8c>
Trace; e08fe860 <_end+2066f2ec/20670a8c>
Trace; c01150c6 <free_module+16/a0>
Trace; c0114456 <sys_delete_module+f6/1c0>
Trace; c0106c4a <system_call+32/38>
Code;  c0129840 <__free_pages_ok+10/1c0>
00000000 <_EIP>:
Code;  c0129840 <__free_pages_ok+10/1c0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0129842 <__free_pages_ok+12/1c0>
   2:   8b 57 08                  mov    0x8(%edi),%edx
Code;  c0129844 <__free_pages_ok+14/1c0>
   5:   85 d2                     test   %edx,%edx
Code;  c0129846 <__free_pages_ok+16/1c0>
   7:   74 02                     je     b <_EIP+0xb> c012984a <__free_pages_ok+1a/1c0>
Code;  c0129848 <__free_pages_ok+18/1c0>
   9:   0f 0b                     ud2a   
Code;  c012984a <__free_pages_ok+1a/1c0>
   b:   89 f8                     mov    %edi,%eax
Code;  c012984c <__free_pages_ok+1c/1c0>
   d:   2b 05 2c 04 27 c0         sub    0xc027042c,%eax
Code;  c0129852 <__free_pages_ok+22/1c0>
  13:   69 00 00 00 00 00         imul   $0x0,(%eax),%eax


ver_linux output:

Linux cartman 2.4.10-ac11 #1 Wed Oct 10 19:40:56 PDT 2001 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11l
mount                  2.11l
modutils               2.4.10
e2fsprogs              1.25
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         3c59x isofs snd-pcm-oss snd-mixer-oss serial snd-card-cmipci snd-pcm snd-opl3 snd-timer snd-hwdep snd-mpu401-uart snd-rawmidi snd-seq-device snd soundcore via-rhine


