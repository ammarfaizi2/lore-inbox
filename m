Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWIILjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWIILjO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 07:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWIILjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 07:39:13 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:7697 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S932085AbWIILjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 07:39:13 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: Oops after 30 days of uptime
Date: Sat, 9 Sep 2006 13:38:55 +0200
User-Agent: KMail/1.9.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kaber@trash.net
References: <200609011852.39572.linux@rainbow-software.org> <20060909101927.GA12986@1wt.eu> <200609091243.39220.linux@rainbow-software.org>
In-Reply-To: <200609091243.39220.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 4091
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200609091338.56539.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 September 2006 12:43, Ondrej Zary wrote:
> On Saturday 09 September 2006 12:19, Willy Tarreau wrote:
> > On Sat, Sep 09, 2006 at 12:15:25PM +0200, Ondrej Zary wrote:
> > > On Saturday 09 September 2006 07:20, you wrote:
> > > > On Fri, Sep 01, 2006 at 06:52:39PM +0200, Ondrej Zary wrote:
> > > > > Hello,
> > > > > my home router crashed after about a month. It does this sometimes
> > > > > but this time I was able to capture the oops. Here is the result of
> > > > > running ksymoops on it (took a photo of the screen and then
> > > > > manually converted to plain-text). Does it look like a bug or
> > > > > something other?
> > > >
> > > > I have another problem with your oops. It looks like you used a
> > > > /proc/ksyms from another running kernel. The symbol decoding does not
> > > > match the code. For instance, in the disassembled code, you'll see
> > > > that two functions are indicated for the same sequence of
> > > > instructions (init_or_cleanup then ip_conntrack_protocol_register).
> > > > And the difference does not look like a small offset, since neither
> > > > of those functions seem to produce comparable code here.
> > >
> > > Sorry, it's the first time I tried to use ksymoops (was reporting only
> > > 2.6 oopses before) and I probably screwed up. The problem is that there
> > > is no /proc/ksyms (maybe because CONFIG_MODULES is disabled?):
> > >
> > > root@router:~# ls -l /proc/k*
> > > -r-------- 1 root root 33558528 2006-09-09 11:58 /proc/kcore
> > > -r-------- 1 root root        0 2006-09-07 14:32 /proc/kmsg
> >
> > Yes, that's very likely the reason.
> >
> > > I also didn't have the System.map file but found it in the tree on my
> > > desktop machine (where that kernel was compiled) - haven't touched that
> > > directory since the kernel compile so it should be correct one.
> >
> > This is strange, because as I said, the symbols do not seem to match the
> > dumped data. If you still have your directory intact, could you please
> > send me offlist (or put at some URL) your System.map and vmlinux (not
> > bzImage) ? Please gzip them BTW.
>
> Uhm, found the problem. The running kernel is not the last one I compiled.
> I added HTB to the kernel and recompiled it but the running version is
> without that. I have the old config file - so it might be possible to
> recreate the System.map - going to try that now.

Looks like the attempt was successful - the decoded oops now makes sense.
Re-created vmlinux, .config and System.map files are available at 
http://www.rainbow-software.org/linux/old.tgz

Hopefully correctly decoded oops:

ksymoops 2.4.11 on i486 2.4.31.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.31/ (default)
     -m System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address c2000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01eeb9e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010a96
eax: db1cec0a   ebx: 7af4a90b   ecx: fff113e8   edx: 00000008
esi: c1ffffe8   edi: c17835a4   ebp: c0b4b8b4   esp: c0227cd0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0227000)
Stack: fd00a8c0 c17835a4 c01e6587 c0227ce8 00000008 0000a0c5 0000dff0 0000200f
       c01e8757 0000dff0 0000200f 00005f3a 00000000 00000028 c1783590 c0b4b8b4
       c01e7162 c1783590 00000028 c0b4b8b4 00000000 00000006 c0b4b810 00000000
Call Trace:    [<c01e6587>] [<c01e8757>] [<c01e7162>] [<c01e72ea>] [<c017fda8>]
  [<c01baca0>] [<c01e5ed4>] [<c01baca0>] [<c01e5fba>] [<c01baca0>] [<c01afe00>]
  [<c01baca0>] [<c01baca0>] [<c01b00d0>] [<c01baca0>] [<c01b8270>] [<c01b9652>]
  [<c01baca0>] [<c01b8270>] [<c01b82ba>] [<c01b0110>] [<c01b05dc>] [<c01b8214>]
  [<c01b8270>] [<c01b7220>] [<c01b739b>] [<c01b7220>] [<c01b0110>] [<c01b70a6>]
  [<c01b7220>] [<c01a87bb>] [<c01a885d>] [<c01a8970>] [<c011427a>] [<c01081cd>]
  [<c0105250>] [<c010a3b8>] [<c0105250>] [<c0105273>] [<c01052d8>] [<c0105000>]
  [<c0105027>]
Code: 8b 5e 18 11 d8 8b 5e 1c 11 d8 8d 76 20 49 75 d3 83 d0 00 89


>>EIP; c01eeb9e <csum_partial+72/c8>   <=====

>>esp; c0227cd0 <init_task_union+1cd0/2000>

Trace; c01e6587 <ip_nat_cheat_check+27/50>
Trace; c01e8757 <tcp_manip_pkt+57/80>
Trace; c01e7162 <manip_pkt+32/90>
Trace; c01e72ea <do_bindings+12a/310>
Trace; c017fda8 <ei_start_xmit+248/260>
Trace; c01baca0 <ip_finish_output2+0/e0>
Trace; c01e5ed4 <ip_nat_fn+194/1a0>
Trace; c01baca0 <ip_finish_output2+0/e0>
Trace; c01e5fba <ip_nat_out+6a/70>
Trace; c01baca0 <ip_finish_output2+0/e0>
Trace; c01afe00 <nf_iterate+30/80>
Trace; c01baca0 <ip_finish_output2+0/e0>
Trace; c01baca0 <ip_finish_output2+0/e0>
Trace; c01b00d0 <nf_hook_slow+b0/150>
Trace; c01baca0 <ip_finish_output2+0/e0>
Trace; c01b8270 <ip_forward_finish+0/50>
Trace; c01b9652 <ip_finish_output+102/110>
Trace; c01baca0 <ip_finish_output2+0/e0>
Trace; c01b8270 <ip_forward_finish+0/50>
Trace; c01b82ba <ip_forward_finish+4a/50>
Trace; c01b0110 <nf_hook_slow+f0/150>
Trace; c01b05dc <eth_header+5c/120>
Trace; c01b8214 <ip_forward+1a4/200>
Trace; c01b8270 <ip_forward_finish+0/50>
Trace; c01b7220 <ip_rcv_finish+0/1b0>
Trace; c01b739b <ip_rcv_finish+17b/1b0>
Trace; c01b7220 <ip_rcv_finish+0/1b0>
Trace; c01b0110 <nf_hook_slow+f0/150>
Trace; c01b70a6 <ip_rcv+346/380>
Trace; c01b7220 <ip_rcv_finish+0/1b0>
Trace; c01a87bb <netif_receive_skb+10b/140>
Trace; c01a885d <process_backlog+6d/110>
Trace; c01a8970 <net_rx_action+70/110>
Trace; c011427a <do_softirq+5a/b0>
Trace; c01081cd <do_IRQ+9d/b0>
Trace; c0105250 <default_idle+0/30>
Trace; c010a3b8 <call_do_IRQ+5/d>
Trace; c0105250 <default_idle+0/30>
Trace; c0105273 <default_idle+23/30>
Trace; c01052d8 <cpu_idle+38/50>
Trace; c0105000 <_stext+0/0>
Trace; c0105027 <rest_init+27/30>

Code;  c01eeb9e <csum_partial+72/c8>
00000000 <_EIP>:
Code;  c01eeb9e <csum_partial+72/c8>   <=====
   0:   8b 5e 18                  mov    0x18(%esi),%ebx   <=====
Code;  c01eeba1 <csum_partial+75/c8>
   3:   11 d8                     adc    %ebx,%eax
Code;  c01eeba3 <csum_partial+77/c8>
   5:   8b 5e 1c                  mov    0x1c(%esi),%ebx
Code;  c01eeba6 <csum_partial+7a/c8>
   8:   11 d8                     adc    %ebx,%eax
Code;  c01eeba8 <csum_partial+7c/c8>
   a:   8d 76 20                  lea    0x20(%esi),%esi
Code;  c01eebab <csum_partial+7f/c8>
   d:   49                        dec    %ecx
Code;  c01eebac <csum_partial+80/c8>
   e:   75 d3                     jne    ffffffe3 <_EIP+0xffffffe3>
Code;  c01eebae <csum_partial+82/c8>
  10:   83 d0 00                  adc    $0x0,%eax
Code;  c01eebb1 <csum_partial+85/c8>
  13:   89 00                     mov    %eax,(%eax)

 <0>Kernel panic: Aiee, killing interrupt handler!

1 error issued.  Results may not be reliable.


> > > > You should backup the /proc/ksyms from your currently running kernel,
> > > > and reuse it to decode the next oops when it occurs. BTW, could you
> > > > provide the full config file and tell us what version of GCC you're
> > > > using ? Maybe we can try to find the same code sequence in a module
> > > > and identify it without waiting for further oops.
> > >
> > > I've used GCC 2.95.3. Attached is dmesg and config file.
> >
> > Thanks, this can constitute a good starting point.
> >
> > Regards,
> > Willy

-- 
Ondrej Zary
