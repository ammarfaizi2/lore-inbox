Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbTJaLbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 06:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTJaLbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 06:31:25 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:18091 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S263267AbTJaLbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 06:31:18 -0500
Message-ID: <3FA247BE.5090700@sun.com>
Date: Fri, 31 Oct 2003 12:30:06 +0100
From: Raffaele Brancaleoni <raffaele.brancaleoni@sun.com>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.6.0-test[89] in tcp_v4_get_port (kernel with IPv6 enabled)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I just encountered a oops with kernels 2.6.0-test8 and -test9 (system
freezes the hard way, not even magic-key works). Problem does not exist
in 2.4.20.

It looks to me its a regression (or has it ever been integrated?) of
bug 456 (from bugme.osdl.org) but I'm far from being an expert.

I can trigger it easily by running the test suite of mod_perl 1.99
(it crashes systematically at the very end of the tests).

You'll find below all details I could collect about this issue 
(linux_ver, ksymoops, the oops I wrote down).

I found a thread about similar issue in the archive
(thread subject: "oops in inet_bind/tcp_v4_get_port"). Yoshifuji Hideaki 
  provided a patch but unfortunately it causes some problems with 
ip_nat_helper and ip_nat_cores modules compilation (duplicate functions 
definitions)...

Can anyone help with this? Do not hesitate to let me know would you need
other data to help in investigating this issue.

Thanks,

Raffaele.

P.S.: I don't know how reliable the ksymoops output is due to the fact I 
could not save the kallsyms at the time of the oops. Anyway, as modules 
are force-loaded at boot in the same order, I hope it will still be useful.

P.S.2: For any reply, would you mind CC:'ing me as I'm not on the list?
____

Unable to handle kernel paging request at virtual 010000c8
*pde = 00000000
Oops: 0000 [#1]
CPU: 0
EIP: 0060:[<c0315951>]  Not tainted
EFLAGS: 00010246
EIP is at tcp_v4_get_port+0x331/0x350
eax: 0100007f ebx: d6234470 ecx: d02df730 edx: d02df720
esi: 00002151 edi: d5c14060 ebp: d02df7b0 esp: d316bc70
ds: 007b es: 007b ss: 0068
Process TEST (pid: 4984, threadinfo=d316a000 task=d5ab46a0)

Stack: 00000000 00000000 00000000 00000000 00000001 00000000 00000000 
00000000
        00000000 00000001 d7ac8544 ffffffea d5c14060 d5c14188 d316bec8 
c0328c62
        d5c14060 00002151 c02dc2dc 00000003 00002151 d5c763a0 d316bce8 
00000010

Call Trace:
      [<c0328c62>] inet_bind+0x1c2/0x2c0
      [<c02dc2dc>] move_addr_to_kernel+0x5e/0xa0
      [<c02dd8eb>] sys_bind+0x7b/0xb0
      [<c011e742>] schedule+0x2f2/0x590
      [<c02de703>] sys_socketcall+0xd3/0x2c0
      [<c012994a>] ptrace_notify+0x4a/0x74
      [<c010ff18>] do_syscall_trace+0x48/0x80
      [<c010b4db>] syscall_call+0x7/0xb

Code: 0f b6 40 49 24 20 84 c0 75 a0 eb 88 8b 7c 24 40 8b 7f 24 89
<0> Kernel panic: fatal exception in interrupt
In interrupt handler - not syncing
____

Linux nightawk 2.6.0-test9 #2 Thu Oct 30 12:52:54 CET 2003 i686 Pentium III
        (Coppermine) GenuineIntel GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.12
e2fsprogs              1.33
reiserfsprogs          3.6.8
pcmcia-cs              3.2.4
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.9
Net-tools              1.60
Kbd                    1.06
Sh-utils               5.0
Modules Loaded         uhci_hcd usbcore autofs4 twofish sha512 blowfish 
sha256
pppoe pppox ppp_generic slhc ircomm_tty ircomm irtty_sir sir_dev irport 
irda
ipt_MASQUERADE ipt_owner ipt_SAME ipt_helper ipt_NETMAP ip_nat_snmp_basic
arpt_mangle ipt_REDIRECT ipt_ULOG ipt_mark smbfs nfsd exportfs lockd sunrpc
snd_pcm_oss snd_mixer_oss snd_au8810 snd_pcm snd_page_alloc snd_timer
snd_ac97_codec snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore fan
thermal processor button battery ac 8139too mii

_____

ksymoops 2.4.9 on i686 2.6.0-test9.  Options used
      -V (default)
      -k /proc/kallsyms (specified)
      -l /proc/modules (specified)
      -o /lib/modules/2.6.0-test9 (specified)
      -m /boot/System.map-2.6.0-test9 (specified)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a 
valid ksym
s file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual 010000c8
*pde = 00000000
Oops: 0000 [#1]
CPU: 0
EIP: 0060:[<c0315951>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 0100007f ebx: d6234470 ecx: d02df730 edx: d02df720
esi: 00002151 edi: d5c14060 ebp: d02df7b0 esp: d316bc70
ds: 007b es: 007b ss: 0068
Stack: 00000000 00000000 00000000 00000000 00000001 00000000 00000000 
00000000
        00000000 00000001 d7ac8544 ffffffea d5c14060 d5c14188 d316bec8 
c0328c62
        d5c14060 00002151 c02dc2dc 00000003 00002151 d5c763a0 d316bce8 
00000010
Call Trace:
      [<c0328c62>] inet_bind+0x1c2/0x2c0
      [<c02dc2dc>] move_addr_to_kernel+0x5e/0xa0
      [<c02dd8eb>] sys_bind+0x7b/0xb0
      [<c011e742>] schedule+0x2f2/0x590
      [<c02de703>] sys_socketcall+0xd3/0x2c0
      [<c012994a>] ptrace_notify+0x4a/0x74
      [<c010ff18>] do_syscall_trace+0x48/0x80
      [<c010b4db>] syscall_call+0x7/0xb
Code: 0f b6 40 49 24 20 84 c0 75 a0 eb 88 8b 7c 24 40 8b 7f 24 89


 >>EIP; c0315951 <tcp_v4_get_port+331/350>   <=====

 >>eax; 0100007f <__crc_ide_driveid_update+33f88/a9af9>
 >>ebx; d6234470 <__crc_ide_error+795b4/84c4e>
 >>ecx; d02df730 <__crc_pcmcia_request_configuration+c5a37/47edc2>
 >>edx; d02df720 <__crc_pcmcia_request_configuration+c5a27/47edc2>
 >>edi; d5c14060 <__crc_sockfd_lookup+d86e8/3f795e>
 >>ebp; d02df7b0 <__crc_pcmcia_request_configuration+c5ab7/47edc2>
 >>esp; d316bc70 <__crc_dst_alloc+16f570/20c86c>

Trace; c0328c62 <inet_bind+1c2/2c0>
Trace; c02dc2dc <move_addr_to_kernel+5c/a0>
Trace; c02dd8eb <sys_bind+7b/b0>
Trace; c011e742 <schedule+2f2/590>
Trace; c02de703 <sys_socketcall+d3/2c0>
Trace; c012994a <ptrace_notify+4a/74>
Trace; c010ff18 <do_syscall_trace+48/80>
Trace; c010b4db <syscall_call+7/b>

Code;  c0315951 <tcp_v4_get_port+331/350>
00000000 <_EIP>:
Code;  c0315951 <tcp_v4_get_port+331/350>   <=====
    0:   0f b6 40 49               movzbl 0x49(%eax),%eax   <=====
Code;  c0315955 <tcp_v4_get_port+335/350>
    4:   24 20                     and    $0x20,%al
Code;  c0315957 <tcp_v4_get_port+337/350>
    6:   84 c0                     test   %al,%al
Code;  c0315959 <tcp_v4_get_port+339/350>
    8:   75 a0                     jne    ffffffaa <_EIP+0xffffffaa>
Code;  c031595b <tcp_v4_get_port+33b/350>
    a:   eb 88                     jmp    ffffff94 <_EIP+0xffffff94>
Code;  c031595d <tcp_v4_get_port+33d/350>
    c:   8b 7c 24 40               mov    0x40(%esp,1),%edi
Code;  c0315961 <tcp_v4_get_port+341/350>
   10:   8b 7f 24                  mov    0x24(%edi),%edi
Code;  c0315964 <tcp_v4_get_port+344/350>
   13:   89 00                     mov    %eax,(%eax)

<0> Kernel panic: fatal exception in interrupt

1 warning issued.  Results may not be reliable.


