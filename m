Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262251AbRERM6z>; Fri, 18 May 2001 08:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262312AbRERM6g>; Fri, 18 May 2001 08:58:36 -0400
Received: from [207.107.200.46] ([207.107.200.46]:35853 "EHLO can-2-map.rr.ca")
	by vger.kernel.org with ESMTP id <S262251AbRERM6e>;
	Fri, 18 May 2001 08:58:34 -0400
Message-ID: <3B369B9D2358D4119EAC0008C791FF9F0ECC6D@can-2-map2.rr.ca>
From: "Tomlinson, Edward" <tomlinson@rolls-royce.ca>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [Panic] skb problems in 2.4.5-pre3 (repeatable)
Date: Fri, 18 May 2001 08:54:19 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This does not seem to be making it to the from my sympatico account...  Is 
lkml blocking sympatico.ca? 

Hopefully outlook does not scramble it too badly.

> I have had this happen three times.  It seems to get trigged when
> forwarding
> from my internal networks to the internet via a pppoe connection.
> 
> The box is debian unstable synced to May 17th.  The ide and lvm patches
> are applied on top of -pre3.
> 
> BTW this is repeatable.  I get my son to try to connect to 'battle net'
> from his W98 box and the kernel panics (three for three... For now the
> interface is down).
> 
> Here is the oops.
> 
> ksymoops 2.4.1 on i586 2.4.5-pre3.  Options used
>      -V (default)
>      -k /var/log/ksymoops/20010517194827.ksyms (specified)
>      -l /var/log/ksymoops/20010517194827.modules (specified)
>      -o /lib/modules/2.4.5-pre3/ (default)
>      -m /boot/System.map-2.4.5-pre3 (default)
> 
> Warning (compare_maps): ksyms_base symbol
>  __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring
>  ksyms_base entry oscar login: Unable to handle kernel paging request at
>  virtual address 0000582c c01b4302
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c01b4302>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010202
> eax: d221f300   ebx: 0000582c   ecx: 00000000   edx: 0000582c
> esi: d26c0e60   edi: d1d9cac0   ebp: 00000060   esp: c023bddc
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 0, stackpage=c023b000)
> Stack: ffb7d820 c01b43ab d26c0e60 ffb7d820 d26c0e60 c01b4953 d26c0e60
>  d26c0e60 d3b13800 d1314120 d3b13800 ffffffe6 c01b77d6 d26c0e60 00000002
>  d13154e0 d26c0e60 c01ba903 d26c0e60 d26c0e60 00000000 00000004 c01c48bc
>  c01c4935 Call Trace: [<ffb7d820>] [<c01b43ab>] [<ffb7d820>] [<c01b4953>]
>  [<c01b77d6>] [<c01ba903>] [<c01c48bc>] [<c01c4935>] [<c01bc9af>]
>  [<c01c20ac>] [<c01c48a2>] [<c01c48bc>] [<c01c20fa>] [<c01bc9af>]
>  [<c01c2054>] [<c01c20ac>] [<c01c1348>] [<c01c14bf>] [<c01c1348>]
>  [<c01bc9af>] [<c01c11a5>] [<c01c1348>] [<c01b7d6b>] [<c01154e0>]
>  [<c0107ed2>] [<c01051f0>] [<c0106bf0>] [<c01051f0>] [<c0105213>]
>  [<c0105277>] [<c0105000>] [<c0100197>]
> Code: 8b 1b 8b 42 70 83 f8 01 74 0a ff 4a 70 0f 94 c0 84 c0 74 09
> 
> >>EIP; c01b4302 <skb_drop_fraglist+1a/40>   <=====
> 
> Trace; ffb7d820 <END_OF_CODE+29019e61/????>
> Trace; c01b43ab <skb_release_data+5f/70>
> Trace; ffb7d820 <END_OF_CODE+29019e61/????>
> Trace; c01b4953 <skb_linearize+cb/12c>
> Trace; c01b77d6 <dev_queue_xmit+26/1e4>
> Trace; c01ba903 <neigh_resolve_output+113/184>
> Trace; c01c48bc <ip_finish_output2+0/b4>
> Trace; c01c4935 <ip_finish_output2+79/b4>
> Trace; c01bc9af <nf_hook_slow+e7/130>
> Trace; c01c20ac <ip_forward_finish+0/54>
> Trace; c01c48a2 <ip_finish_output+e2/e8>
> Trace; c01c48bc <ip_finish_output2+0/b4>
> Trace; c01c20fa <ip_forward_finish+4e/54>
> Trace; c01bc9af <nf_hook_slow+e7/130>
> Trace; c01c2054 <ip_forward+194/1ec>
> Trace; c01c20ac <ip_forward_finish+0/54>
> Trace; c01c1348 <ip_rcv_finish+0/1a8>
> Trace; c01c14bf <ip_rcv_finish+177/1a8>
> Trace; c01c1348 <ip_rcv_finish+0/1a8>
> Trace; c01bc9af <nf_hook_slow+e7/130>
> Trace; c01c11a5 <ip_rcv+325/35c>
> Trace; c01c1348 <ip_rcv_finish+0/1a8>
> Trace; c01b7d6b <net_rx_action+13b/218>
> Trace; c01154e0 <do_softirq+40/64>
> Trace; c0107ed2 <do_IRQ+a2/b0>
> Trace; c01051f0 <default_idle+0/28>
> Trace; c0106bf0 <ret_from_intr+0/20>
> Trace; c01051f0 <default_idle+0/28>
> Trace; c0105213 <default_idle+23/28>
> Trace; c0105277 <cpu_idle+3f/54>
> Trace; c0105000 <do_linuxrc+0/dc>
> Trace; c0100197 <L6+0/2>
> Code;  c01b4302 <skb_drop_fraglist+1a/40>
> 00000000 <_EIP>:
> Code;  c01b4302 <skb_drop_fraglist+1a/40>   <=====
>    0:   8b 1b                     mov    (%ebx),%ebx   <=====
> Code;  c01b4304 <skb_drop_fraglist+1c/40>
>    2:   8b 42 70                  mov    0x70(%edx),%eax
> Code;  c01b4307 <skb_drop_fraglist+1f/40>
>    5:   83 f8 01                  cmp    $0x1,%eax
> Code;  c01b430a <skb_drop_fraglist+22/40>
>    8:   74 0a                     je     14 <_EIP+0x14> c01b4316
>  <skb_drop_fraglist+2e/40> Code;  c01b430c <skb_drop_fraglist+24/40>
>    a:   ff 4a 70                  decl   0x70(%edx)
> Code;  c01b430f <skb_drop_fraglist+27/40>
>    d:   0f 94 c0                  sete   %al
> Code;  c01b4312 <skb_drop_fraglist+2a/40>
>   10:   84 c0                     test   %al,%al
> Code;  c01b4314 <skb_drop_fraglist+2c/40>
>   12:   74 09                     je     1d <_EIP+0x1d> c01b431f
>  <skb_drop_fraglist+37/40>
> 
> Kernel panic: Aiee, killing interrupt handler!
> 
> 1 warning issued.  Results may not be reliable.
> 
> TIA
> Ed Tomlinson <tomlins@cam.org>
> 
> -------------------------------------------------------
> 
> -------------------------------------------------------
