Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTEHVVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 17:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTEHVVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 17:21:51 -0400
Received: from tomts12.bellnexxia.net ([209.226.175.56]:57334 "EHLO
	tomts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262123AbTEHVVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:21:46 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: "David S. Miller" <davem@redhat.com>, wli@holomorphy.com
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
Date: Thu, 8 May 2003 17:34:54 -0400
User-Agent: KMail/1.5.9
Cc: helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       akpm@digeo.com
References: <20030507.064010.42794250.davem@redhat.com> <20030508013854.GW8931@holomorphy.com> <20030508.102155.132908119.davem@redhat.com>
In-Reply-To: <20030508.102155.132908119.davem@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305081734.54621.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since I have not noticed anyone posting one, here is the opps that kills -mm3
here:

agpgart: Found an AGP 1.0 compliant device.
agpgart: Putting AGP V2 device at 00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 01:00.0 into 1x mode
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
e0d4e34d
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<e0d4e34d>]    Not tainted VLI
EFLAGS: 00010282
EIP is at icmp_reply_translation+0x19/0x1ec [ipchains]
eax: 00000000   ebx: dad7e014   ecx: de807894   edx: cc48b088
esi: cc48b064   edi: de807894   ebp: de831cfc   esp: de831ce8
ds: 007b   es: 007b   ss: 0068
Process pppoe (pid: 544, threadinfo=de830000 task=dfaeb300)
Stack: dad7e014 cc48b064 de831dd8 cc48b108 cfa35c41 de831d38 e0d4d237 de807894 
       cc48b064 00000000 00000001 de831dd8 c0346ca0 00000002 e0d56600 00000004 
       e0d4c64e e0d56888 00000002 dedd1a00 de831d54 e0d4c72c de831dd8 de831dc4 
Call Trace:
 [<e0d4d237>] check_for_demasq+0xa7/0x1cc [ipchains]
 [<e0d56600>] ip_conntrack_protocol_icmp+0x0/0x40 [ipchains]
 [<e0d4c64e>] fw_in+0x162/0x2b8 [ipchains]
 [<e0d56888>] ipfw_ops+0x0/0x18 [ipchains]
 [<e0d4c72c>] fw_in+0x240/0x2b8 [ipchains]
 [<c0215e07>] nf_iterate+0x3f/0x9c
 [<c021d120>] ip_rcv_finish+0x0/0x200
 [<c02161b9>] nf_hook_slow+0x95/0x128
 [<c021d120>] ip_rcv_finish+0x0/0x200
 [<e0d56640>] preroute_ops+0x0/0x1c [ipchains]
 [<c021cf70>] ip_rcv+0x39c/0x3d8
 [<c021d120>] ip_rcv_finish+0x0/0x200
 [<c020fd2b>] netif_receive_skb+0x11b/0x14c
 [<c020fdcd>] process_backlog+0x71/0x124
 [<c020fef2>] net_rx_action+0x72/0x148
 [<c011a8a2>] do_softirq+0x52/0xac
 [<c011a94e>] local_bh_enable+0x52/0x6c
 [<e0d294fb>] ppp_asynctty_receive+0x4f/0x84 [ppp_async]
 [<c01b516d>] pty_write+0xed/0x150
 [<c01b4424>] write_chan+0x1a8/0x204
 [<c0114168>] default_wake_function+0x0/0x18
 [<c0114168>] default_wake_function+0x0/0x18
 [<c01aebd7>] tty_write+0x203/0x2c4
 [<c01b427c>] write_chan+0x0/0x204
 [<c0143aee>] vfs_write+0xa2/0xd0
 [<c0143b96>] sys_write+0x2e/0x4c
 [<c0108dd7>] syscall_call+0x7/0xb

Code: 00 eb a9 b8 01 00 00 00 8d 65 d4 5b 5e 5f c9 c3 89 f6 55 89 e5 83 ec 08 57 56 53 8b 7d 08 8b 45 0c 05 a4 00 00 00 89 45 f8 8b 07 <8b> 40 20 8a 00 24 0f 25 ff 00 00 00 8d 04 85 1c 00 00 00 50 57 
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

and decoding the code:

ksymoops 2.4.8 on i586 2.5.69-mm1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.69-mm1/ (default)
     -m /boot/System.map-2.5.69-mm3 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Code: 00 eb a9 b8 01 00 00 00 8d 65 d4 5b 5e 5f c9 c3 89 f6 55 89 e5 83 ec 08 57 56 53 8b 7d 08 8b 45 0c 05 a4 00 00 00 89 45 f8 8b 07 <8b> 40 20 8a 00 24 0f 25 ff 00 00 00 8d 04 85 1c 00 00 00 50 57
Using defaults from ksymoops -t elf32-i386 -a i386


Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   00 eb                     add    %ch,%bl
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   a9 b8 01 00 00            test   $0x1b8,%eax
Code;  ffffffdc <__kernel_rt_sigreturn+1b9c/????>
   7:   00 8d 65 d4 5b 5e         add    %cl,0x5e5bd465(%ebp)
Code;  ffffffe2 <__kernel_rt_sigreturn+1ba2/????>
   d:   5f                        pop    %edi
Code;  ffffffe3 <__kernel_rt_sigreturn+1ba3/????>
   e:   c9                        leave
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   c3                        ret
Code;  ffffffe5 <__kernel_rt_sigreturn+1ba5/????>
  10:   89 f6                     mov    %esi,%esi
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   55                        push   %ebp
Code;  ffffffe8 <__kernel_rt_sigreturn+1ba8/????>
  13:   89 e5                     mov    %esp,%ebp
Code;  ffffffea <__kernel_rt_sigreturn+1baa/????>
  15:   83 ec 08                  sub    $0x8,%esp
Code;  ffffffed <__kernel_rt_sigreturn+1bad/????>
  18:   57                        push   %edi
Code;  ffffffee <__kernel_rt_sigreturn+1bae/????>
  19:   56                        push   %esi
Code;  ffffffef <__kernel_rt_sigreturn+1baf/????>
  1a:   53                        push   %ebx
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   8b 7d 08                  mov    0x8(%ebp),%edi
Code;  fffffff3 <__kernel_rt_sigreturn+1bb3/????>
  1e:   8b 45 0c                  mov    0xc(%ebp),%eax
Code;  fffffff6 <__kernel_rt_sigreturn+1bb6/????>
  21:   05 a4 00 00 00            add    $0xa4,%eax
Code;  fffffffb <__kernel_rt_sigreturn+1bbb/????>
  26:   89 45 f8                  mov    %eax,0xfffffff8(%ebp)
Code;  fffffffe <__kernel_rt_sigreturn+1bbe/????>
  29:   8b 07                     mov    (%edi),%eax
Code;  00000000 Before first symbol
  2b:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000003 Before first symbol
  2e:   8a 00                     mov    (%eax),%al
Code;  00000005 Before first symbol
  30:   24 0f                     and    $0xf,%al
Code;  00000007 Before first symbol
  32:   25 ff 00 00 00            and    $0xff,%eax
Code;  0000000c Before first symbol
  37:   8d 04 85 1c 00 00 00      lea    0x1c(,%eax,4),%eax
Code;  00000013 Before first symbol
  3e:   50                        push   %eax
Code;  00000014 Before first symbol
  3f:   57                        push   %edi


1 error issued.  Results may not be reliable.

On May 8, 2003 01:21 pm, David S. Miller wrote:
>    Can you try one kernel with the netfilter cset backed out, and another
>    with the re-slabification patch backed out? (But not with both backed
>    out simultaneously).
>
> Not needed, this should cure the problem:
>
> --- net/ipv4/netfilter/ip_nat_core.c.~1~	Thu May  8 11:23:22 2003
> +++ net/ipv4/netfilter/ip_nat_core.c	Thu May  8 11:25:56 2003
> @@ -861,6 +861,7 @@
>  	} *inside;
>  	unsigned int i;
>  	struct ip_nat_info *info = &conntrack->nat.info;
> +	int hdrlen;
>
>  	if (!skb_ip_make_writable(pskb,(*pskb)->nh.iph->ihl*4+sizeof(*inside)))
>  		return 0;
> @@ -868,10 +869,12 @@
>
>  	/* We're actually going to mangle it beyond trivial checksum
>  	   adjustment, so make sure the current checksum is correct. */
> -	if ((*pskb)->ip_summed != CHECKSUM_UNNECESSARY
> -	    && (u16)csum_fold(skb_checksum(*pskb, (*pskb)->nh.iph->ihl*4,
> -					   (*pskb)->len, 0)))
> -		return 0;
> +	if ((*pskb)->ip_summed != CHECKSUM_UNNECESSARY) {
> +		hdrlen = (*pskb)->nh.iph->ihl * 4;
> +		if ((u16)csum_fold(skb_checksum(*pskb, hdrlen,
> +						(*pskb)->len - hdrlen, 0)))
> +			return 0;
> +	}
>
>  	/* Must be RELATED */
>  	IP_NF_ASSERT((*pskb)->nfct
> @@ -948,10 +951,12 @@
>  	}
>  	READ_UNLOCK(&ip_nat_lock);
>
> +	hdrlen = (*pskb)->nh.iph->ihl * 4;
> +
>  	inside->icmp.checksum = 0;
> -	inside->icmp.checksum = csum_fold(skb_checksum(*pskb,
> -						       (*pskb)->nh.iph->ihl*4,
> -						       (*pskb)->len, 0));
> +	inside->icmp.checksum = csum_fold(skb_checksum(*pskb, hdrlen,
> +						       (*pskb)->len - hdrlen,
> +						       0));
>  	return 1;
>
>   unlock_fail:
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"aart@kvack.org"> aart@kvack.org </a>




