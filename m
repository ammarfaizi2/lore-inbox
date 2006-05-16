Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWEPNtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWEPNtQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 09:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWEPNtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 09:49:16 -0400
Received: from mail.unixshell.com ([207.210.106.37]:36034 "EHLO
	mail.unixshell.com") by vger.kernel.org with ESMTP id S1751095AbWEPNtP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 09:49:15 -0400
Message-ID: <4469D84F.8080709@tektonic.net>
Date: Tue, 16 May 2006 09:49:03 -0400
From: Matt Ayres <matta@tektonic.net>
Organization: TekTonic
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Patrick McHardy <kaber@trash.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: Panic in ipt_do_table with 2.6.16.13-xen
References: <4468BE70.7030802@tektonic.net> <4468D613.20309@trash.net>	<44691669.4080903@tektonic.net> <Pine.LNX.4.64.0605152331140.10964@d.namei>
In-Reply-To: <Pine.LNX.4.64.0605152331140.10964@d.namei>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



James Morris wrote:
> On Mon, 15 May 2006, Matt Ayres wrote:
> 
>> I had initially sent my traces to the Xen guys.  They have not stated it is
>> NOT specific to Xen, just that's it's unlikely.  I did not experience the
>> problem with kernel 2.6.12, just with 2.6.16 (up to .13 bugfix release).  I
>> have completely disabled all support for SCTP (protocol/netfilter/conntrack)
>> as I know it is still quite buggy.  I know Xen touches the network code a lot,
>> but nothing specific to iptables.  I had contacted them twice before LKML as I
>> didn't want to post patch specific problems here.  I have no other patches
>> applied besides the Xen patch.
>>
>> My ruleset is pretty bland.  2 rules in the raw table to tell the system to
>> only track my forwarded ports, 2 rules in the nat table for forwarding
>> (intercepting) 2 ports, and then in the FORWARD tables 2 rules per VM to just
>> account traffic.
> 
> Can you try using a different NIC?
> 

This happens on 30 different hosts.  Using the same kernel I get varying 
uptime of "hasn't crashed since the upgrade to 2.6.16" to "crashes every 
day".  All are Tyan S2882D boards w/ integrated Tigon3.  The trace I 
posted to this thread indicate tg3, but in many other traces I have the 
trace doesn't include any driver calls.  They all panic in ipt_do_table. 
  I would have pasted the others, but I didn't save the System.map for 
either of them and they are all pretty similar.

Here is another that just crashed:

 >>EIP; c03d96a9 <ipt_do_table+ad/2d0>   <=====

 >>esp; c0517d8c <init_thread_union+1d8c/2000>

Trace; c03acc04 <ip_forward_finish+0/36>
Trace; c03da724 <ipt_hook+1c/20>
Trace; c03a2e50 <nf_iterate+2c/5e>
Trace; c03acc04 <ip_forward_finish+0/36>
Trace; c03acc04 <ip_forward_finish+0/36>
Trace; c03a2f4b <nf_hook_slow+3c/c3>
Trace; c03acc04 <ip_forward_finish+0/36>
Trace; c03acdd8 <ip_forward+19e/22e>
Trace; c03acc04 <ip_forward_finish+0/36>
Trace; c03abcf7 <ip_rcv+40e/48f>
Trace; c037dcb5 <netif_receive_skb+255/294>
Trace; c02e82e6 <tg3_poll+532/76c>
Trace; c037bd82 <net_rx_action+aa/17c>
Trace; c011ea17 <__do_softirq+73/f0>
Trace; c011ead4 <do_softirq+40/64>
Trace; c010606b <do_IRQ+1f/25>
Trace; c02fc87f <evtchn_do_upcall+60/96>
Trace; c0104a2c <hypervisor_callback+2c/34>
Trace; c010342e <xen_idle+5e/7d>
Trace; c0103509 <cpu_idle+bc/d5>
Trace; c05184e0 <start_kernel+344/34b>

Code;  c03d96a9 <ipt_do_table+ad/2d0>
00000000 <_EIP>:
Code;  c03d96a9 <ipt_do_table+ad/2d0>   <=====
    0:   89 44 24 18               mov    %eax,0x18(%esp)   <=====
Code;  c03d96ad <ipt_do_table+b1/2d0>
    4:   89 c6                     mov    %eax,%esi
Code;  c03d96af <ipt_do_table+b3/2d0>
    6:   8b 44 24 40               mov    0x40(%esp),%eax
Code;  c03d96b3 <ipt_do_table+b7/2d0>
    a:   8b 6c 24 18               mov    0x18(%esp),%ebp
Code;  c03d96b7 <ipt_do_table+bb/2d0>
    e:   03 74 83 0c               add    0xc(%ebx,%eax,4),%esi
Code;  c03d96bb <ipt_do_table+bf/2d0>
   12:   03 6c 83 20               add    0x20(%ebx,%eax,4),%ebp
Code;  c03d96bf <ipt_do_table+c3/2d0>
   16:   c7 44 24 00 00 00 00      movl   $0x0,0x0(%esp)
Code;  c03d96c6 <ipt_do_table+ca/2d0>
   1d:   00

  <0>Kernel panic - not syncing: Fatal exception in interrupt 



Thanks,
Matt Ayres
