Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUJNWTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUJNWTq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUJNWRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:17:44 -0400
Received: from mail4.utc.com ([192.249.46.193]:44182 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S267306AbUJNUjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 16:39:46 -0400
Message-ID: <416EE3FA.1070802@cybsft.com>
Date: Thu, 14 Oct 2004 15:39:22 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Daniel Walker <dwalker@mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>, Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
In-Reply-To: <20041014143131.GA20258@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030506080903090505090208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030506080903090505090208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i have released the -U1 PREEMPT_REALTIME patch:
>  
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U1
> 
> this is a strict bugfixes-only release. With -U1 i cannot reproduce any
> of the bugs on my testsystems anymore, but take care nevertheless, this
> is still experimental code.
> 

Got this one running on my SMP workstation FINALLY. The problems that I 
have been having with the keyboard not working goes away if I compile in 
CONFIG_SERIO_PCIPS2 instead of making it a module. :-/ Anyway I am 
getting some "using smp_processor_id messages" all of which seem to be 
getting generated from ip_tables as in:



--------------030506080903090505090208
Content-Type: text/plain;
 name="smpdump.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smpdump.txt"

Oct 14 15:35:52 swdev14 kernel: using smp_processor_id() in preemptible [00000001] code: thunderbird-bin/3933
Oct 14 15:35:52 swdev14 kernel: caller is ipt_do_table+0x79/0x335 [ip_tables]
Oct 14 15:35:52 swdev14 kernel:  [<c011878e>] smp_processor_id+0xa8/0xb9
Oct 14 15:35:52 swdev14 kernel:  [<e08550a8>] ipt_do_table+0x79/0x335 [ip_tables]
Oct 14 15:35:52 swdev14 kernel:  [<e08550a8>] ipt_do_table+0x79/0x335 [ip_tables]
Oct 14 15:35:52 swdev14 kernel:  [<e09ba0b5>] ipt_local_out_hook+0x76/0x79 [iptable_filter]
Oct 14 15:35:52 swdev14 kernel:  [<c02394ea>] nf_iterate+0x70/0xa1
Oct 14 15:35:52 swdev14 kernel:  [<c024ef4f>] dst_output+0x0/0x2f
Oct 14 15:35:52 swdev14 kernel:  [<c023982d>] nf_hook_slow+0x79/0x126
Oct 14 15:35:52 swdev14 kernel:  [<c024ef4f>] dst_output+0x0/0x2f
Oct 14 15:35:52 swdev14 kernel:  [<c024cfe2>] ip_queue_xmit+0x495/0x59e
Oct 14 15:35:52 swdev14 kernel:  [<c024ef4f>] dst_output+0x0/0x2f
Oct 14 15:35:52 swdev14 kernel:  [<c01325d5>] __mcount+0x1d/0x21
Oct 14 15:35:52 swdev14 kernel:  [<c0298716>] _spin_unlock_irq+0xb/0x35
Oct 14 15:35:52 swdev14 kernel:  [<c01171e7>] finish_task_switch+0x3c/0x85
Oct 14 15:35:52 swdev14 kernel:  [<c0111d1c>] mcount+0x14/0x18
Oct 14 15:35:52 swdev14 kernel:  [<c01325d5>] __mcount+0x1d/0x21
Oct 14 15:35:52 swdev14 kernel:  [<c0263c48>] tcp_v4_send_check+0xe/0xe2
Oct 14 15:35:52 swdev14 kernel:  [<c025d95b>] tcp_transmit_skb+0x435/0x85b
Oct 14 15:35:52 swdev14 kernel:  [<c0111d1c>] mcount+0x14/0x18
Oct 14 15:35:52 swdev14 kernel:  [<c0263c48>] tcp_v4_send_check+0xe/0xe2
Oct 14 15:35:52 swdev14 kernel:  [<c025da07>] tcp_transmit_skb+0x4e1/0x85b
Oct 14 15:35:52 swdev14 kernel:  [<c01af5ee>] memcpy+0x12/0x3c
Oct 14 15:35:52 swdev14 kernel:  [<c025e830>] tcp_write_xmit+0x14c/0x2c6
Oct 14 15:35:52 swdev14 kernel:  [<c0252608>] tcp_sendmsg+0x50d/0x10a7
Oct 14 15:35:52 swdev14 kernel:  [<c0111d1c>] mcount+0x14/0x18
Oct 14 15:35:52 swdev14 kernel:  [<c02525dc>] tcp_sendmsg+0x4e1/0x10a7
Oct 14 15:35:52 swdev14 kernel:  [<c0224f0e>] sock_sendmsg+0xfa/0xfc
Oct 14 15:35:52 swdev14 kernel:  [<c0274665>] inet_sendmsg+0x50/0x5b
Oct 14 15:35:52 swdev14 kernel:  [<c0224f0e>] sock_sendmsg+0xfa/0xfc
Oct 14 15:35:52 swdev14 kernel:  [<c01325d5>] __mcount+0x1d/0x21
Oct 14 15:35:52 swdev14 kernel:  [<c01af10e>] find_next_bit+0x16/0x92
Oct 14 15:35:52 swdev14 kernel:  [<c0117b37>] find_busiest_group+0xd4/0x2e0
Oct 14 15:35:52 swdev14 kernel:  [<c0131d20>] _mutex_unlock+0xe/0x5e
Oct 14 15:35:52 swdev14 kernel:  [<c0111d1c>] mcount+0x14/0x18
Oct 14 15:35:52 swdev14 kernel:  [<c0131d20>] _mutex_unlock+0xe/0x5e
Oct 14 15:35:52 swdev14 kernel:  [<c0131cba>] _mutex_lock+0x29/0x3f
Oct 14 15:35:52 swdev14 kernel:  [<c013186b>] autoremove_wake_function+0x0/0x57
Oct 14 15:35:52 swdev14 kernel:  [<c0224c69>] sockfd_lookup+0x1f/0x74
Oct 14 15:35:52 swdev14 kernel:  [<c0111d1c>] mcount+0x14/0x18
Oct 14 15:35:52 swdev14 kernel:  [<c0226493>] sys_sendto+0xed/0x10c
Oct 14 15:35:52 swdev14 kernel:  [<c0173221>] inode_times_differ+0x9/0x4a
Oct 14 15:35:52 swdev14 kernel:  [<c017332a>] update_atime+0xc8/0xcd
Oct 14 15:35:52 swdev14 kernel:  [<c01325d5>] __mcount+0x1d/0x21
Oct 14 15:35:52 swdev14 kernel:  [<c02264bd>] sys_send+0xb/0x3f
Oct 14 15:35:52 swdev14 kernel:  [<c0226d5e>] sys_socketcall+0x12e/0x239
Oct 14 15:35:52 swdev14 kernel:  [<c0111d1c>] mcount+0x14/0x18
Oct 14 15:35:52 swdev14 kernel:  [<c02264ed>] sys_send+0x3b/0x3f
Oct 14 15:35:52 swdev14 kernel:  [<c0226d5e>] sys_socketcall+0x12e/0x239
Oct 14 15:35:52 swdev14 kernel:  [<c0158cdd>] sys_read+0x78/0x7a
Oct 14 15:35:52 swdev14 kernel:  [<c0106161>] sysenter_past_esp+0x52/0x71

--------------030506080903090505090208--
