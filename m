Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293269AbSCFHL5>; Wed, 6 Mar 2002 02:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293277AbSCFHLj>; Wed, 6 Mar 2002 02:11:39 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:40579 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S293283AbSCFHLV>; Wed, 6 Mar 2002 02:11:21 -0500
Date: Wed, 6 Mar 2002 08:56:55 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@suse.de>
Subject: [PANIC] 2.5.5-pre1 elevator.c
Message-ID: <Pine.LNX.4.44.0203060855330.2839-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I'm not quite sure where to really start with this one because i 
haven't the faintest clue about the IO scheduler juju.

Scenario: My test box locked up (only sysrq worked so i managed to dump 
stuff to a serial console). When it locked it was doing a dd if=/dev/hdc 
of=/build where /dev/hdc is a disc (FreeBSD 4.4-REL - 636M) i was copying 
to an NFS volume. Here is the task information for dd.

dd            D 00000000     0  7944   7672                     (NOTLB)
Call Trace: [<c012b4dc>] [<c012b514>] [<c012bc6f>] [<c01d981c>] 
[<c012c1ac>] 
   [<c012c050>] [<c013af86>] [<c011d37b>] [<c010a434>] [<c0108bef>]

Trace; c012b4dc <__lock_page+6c/90>
Trace; c012b514 <lock_page+14/20>
Trace; c012bc6f <do_generic_file_read+26f/460>
Trace; c01d981c <batch_entropy_process+ac/b0>
Trace; c012c1ac <generic_file_read+7c/130>
Trace; c012c050 <file_read_actor+0/e0>
Trace; c013af86 <sys_read+96/d0>
Trace; c011d37b <do_softirq+5b/c0>
Trace; c010a434 <do_IRQ+e4/f0>
Trace; c0108bef <syscall_call+7/b>

And here is the PC dump.

Pid: 0, comm:              swapper
EIP: 0010:[<c0118790>] CPU: 0 EFLAGS: 00000246    Not tainted
EAX: 00000000 EBX: c02a3ba0 ECX: 00000001 EDX: 00000000
ESI: 00000000 EDI: c01094a0 EBP: c02e3ec0 DS: 0018 ES: 0018
CR0: 8005003b CR2: 080d928c CR3: 0fd21280 CR4: 000002f0
Call Trace: [<c011bf3b>] [<c0109159>] [<c01094a0>] [<c010955f>] 
[<c01d9800>] 
   [<c01ebb68>] [<c01d99c6>] [<c01d0772>] [<c0118e8b>] [<c0119119>] 
[<c0108cd8>] 
   [<c01ebb68>] [<c01fd4a9>] [<c02070ec>] [<c0207471>] [<c0121075>] 
[<d08349f4>] 
   [<c0121075>] [<c010a1ea>] [<c01153d3>] [<c01319f8>] [<c022e91b>] 
[<c022ea82>] 
   [<c0230a5d>] [<c028fbf0>] [<c028d4d3>] [<c0207400>] [<c0207120>] 
[<c025f478>] 
   [<c025f835>] [<c0232c09>] [<c024118b>] [<c0241524>] [<c01fd2c6>] 
[<c0207400>] 
   [<c010a1ea>] [<c010a3e1>] [<c0106d50>] [<c0106d50>] [<c0106d50>] 
[<c0106d74>] 
   [<c0106df2>] [<c0105000>] 

>>EIP; c0118790 <panic+e0/f0>   <=====
Trace; c011bf3b <do_exit+2b/2c0>
Trace; c0109159 <die+79/90>
Trace; c01094a0 <do_invalid_op+0/d0>
Trace; c010955f <do_invalid_op+bf/d0>
Trace; c01d9800 <batch_entropy_process+90/b0>
Trace; c01ebb68 <elevator_linus_add_request+38/90>
Trace; c01d99c6 <add_blkdev_randomness+46/50>
Trace; c01d0772 <vsnprintf+2a2/420>
Trace; c0118e8b <call_console_drivers+eb/100>
Trace; c0119119 <release_console_sem+69/e0>
Trace; c0108cd8 <error_code+34/40>
Trace; c01ebb68 <elevator_linus_add_request+38/90>
Trace; c01fd4a9 <ide_do_drive_cmd+c9/120>
Trace; c02070ec <cdrom_decode_status+1fc/230>
Trace; c0207471 <cdrom_read_intr+71/330>
Trace; c0121075 <update_process_times+25/30>
Trace; d08349f4 <_end+104b9320/204ce98c>
Trace; c0121075 <update_process_times+25/30>
Trace; c010a1ea <handle_IRQ_event+3a/70>
Trace; c01153d3 <try_to_wake_up+183/190>
Trace; c01319f8 <kfree+1d8/270>
Trace; c022e91b <kfree_skbmem+b/60>
Trace; c022ea82 <__kfree_skb+112/120>
Trace; c0230a5d <skb_free_datagram+1d/30>
Trace; c028fbf0 <rpc_unlock_task+90/a0>
Trace; c028d4d3 <udp_data_ready+243/280>
Trace; c0207400 <cdrom_read_intr+0/330>
Trace; c0207120 <cdrom_timer_expiry+0/40>
Trace; c025f478 <udp_queue_rcv_skb+178/1c0>
Trace; c025f835 <udp_rcv+165/2c0>
Trace; c0232c09 <netif_rx+79/f0>
Trace; c024118b <ip_local_deliver+12b/1c0>
Trace; c0241524 <ip_rcv+304/370>
Trace; c01fd2c6 <ide_intr+d6/150>
Trace; c0207400 <cdrom_read_intr+0/330>
Trace; c010a1ea <handle_IRQ_event+3a/70>
Trace; c010a3e1 <do_IRQ+91/f0>
Trace; c0106d50 <default_idle+0/30>
Trace; c0106d50 <default_idle+0/30>
Trace; c0106d50 <default_idle+0/30>
Trace; c0106d74 <default_idle+24/30>
Trace; c0106df2 <cpu_idle+32/50>
Trace; c0105000 <_stext+0/0>

Ok so i can see it wasn't really a panic from seeing that, it just got 
escalated to one because we were in an interrupt handler. My reading of 
the trace is that we didn't really die in the entropy stuff but just 
before that in elevator_linus_add_request+38, batch_entropy_process+90 
doesn't point to an instruction anyway.

0xc01ebb30 <elevator_linus_add_request>:        push   %ebp
0xc01ebb31 <elevator_linus_add_request+1>:      push   %edi
0xc01ebb32 <elevator_linus_add_request+2>:      push   %esi
0xc01ebb33 <elevator_linus_add_request+3>:      push   %ebx
0xc01ebb34 <elevator_linus_add_request+4>:      sub    $0x4,%esp
0xc01ebb37 <elevator_linus_add_request+7>:      mov    0x20(%esp,1),%esi
0xc01ebb3b <elevator_linus_add_request+11>:     movl   $0x0,(%esp,1)
0xc01ebb42 <elevator_linus_add_request+18>:     mov    0x18(%esp,1),%edi
0xc01ebb46 <elevator_linus_add_request+22>:     mov    0x1c(%esp,1),%ebx
0xc01ebb4a <elevator_linus_add_request+26>:     mov    (%esi),%eax
0xc01ebb4c <elevator_linus_add_request+28>:     mov    0x30(%edi),%ebp
0xc01ebb4f <elevator_linus_add_request+31>:     cmp    %edi,%eax
0xc01ebb51 <elevator_linus_add_request+33>:
    je     0xc01ebb6c <elevator_linus_add_request+60>
0xc01ebb53 <elevator_linus_add_request+35>:     testb  $0x20,0x1c(%eax)
0xc01ebb57 <elevator_linus_add_request+39>:
    je     0xc01ebb6c <elevator_linus_add_request+60>
0xc01ebb59 <elevator_linus_add_request+41>:     push   $0xed
0xc01ebb5e <elevator_linus_add_request+46>:     push   $0xc02bc3e5
0xc01ebb63 <elevator_linus_add_request+51>:     call   0xc0114800 <do_BUG>
0xc01ebb68 <elevator_linus_add_request+56>:     ud2a	<==

	if (insert_here->next != &q->queue_head)
		BUG_ON(list_entry_rq(insert_here->next)->flags & 
REQ_STARTED); <==

Thanks,
	Zwane Mwaikambo


