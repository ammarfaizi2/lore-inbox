Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267013AbTAPEhK>; Wed, 15 Jan 2003 23:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267026AbTAPEhJ>; Wed, 15 Jan 2003 23:37:09 -0500
Received: from holomorphy.com ([66.224.33.161]:6543 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267013AbTAPEhH>;
	Wed, 15 Jan 2003 23:37:07 -0500
Date: Wed, 15 Jan 2003 20:46:00 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lots of calls to __write/read_lock_failed
Message-ID: <20030116044600.GN919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
References: <3E263285.2000204@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E263285.2000204@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 08:18:13PM -0800, Dave Hansen wrote:
>  file_table:_raw_read_lock() 3300000
>  Call Trace:
>   [<c0152469>] fget+0x9d/0xa0
>   [<c0152b27>] sys_fsync+0x21/0xbe
>   [<c0151b53>] sys_writev+0x47/0x56
>   [<c010931f>] syscall_call+0x7/0xb

read_lock(&file->files_lock);


On Wed, Jan 15, 2003 at 08:18:13PM -0800, Dave Hansen wrote:
> filemap:_raw_read_lock() 1450000
>  Call Trace:
>   [<c0136937>] do_generic_mapping_read+0x411/0x43e
>   [<c0136d98>] file_send_actor+0x0/0x74
>   [<c0136e74>] generic_file_sendfile+0x68/0x76
>   [<c0136d98>] file_send_actor+0x0/0x74
>   [<c0151d48>] do_sendfile+0x1e6/0x28a
>   [<c0136d98>] file_send_actor+0x0/0x74
>   [<c0151e50>] sys_sendfile+0x64/0xcc
>   [<c010931f>] syscall_call+0x7/0xb

read_lock(&mapping->page_lock);

On Wed, Jan 15, 2003 at 08:18:13PM -0800, Dave Hansen wrote:
>  ip_output:_raw_read_lock() 2000000
>  Call Trace:
>   [<c02c90b2>] ip_finish_output2+0x154/0x226
>   [<c02c7466>] ip_queue_xmit+0x3dc/0x4ce
>   [<c011c71a>] default_wake_function+0x32/0x3e
>   [<c011c75e>] __wake_up_common+0x38/0x58
>   [<c02ddf24>] tcp_v4_send_check+0x54/0xe2
>   [<c02d81b6>] tcp_transmit_skb+0x2be/0x448
>   [<c02d54ca>] tcp_data_queue+0x23a/0x830
>   [<c02da693>] tcp_send_ack+0x81/0xb2
>   [<c02d68d1>] tcp_rcv_established+0x249/0x70e
>   [<c02defd1>] tcp_v4_do_rcv+0x12d/0x132
>   [<c02df452>] tcp_v4_rcv+0x47c/0x50c
>   [<c02c4363>] ip_local_deliver_finish+0x9f/0x19e
>   [<c02c4674>] ip_rcv_finish+0x212/0x29f
>   [<c02b410e>] netif_receive_skb+0xc2/0x17c
>   [<c02b4245>] process_backlog+0x7d/0x10c
>   [<c02b4395>] net_rx_action+0xc1/0x178
>   [<c01248e7>] do_softirq+0xb7/0xba
>   [<c010b390>] do_IRQ+0xec/0xf8
>   [<c0106eca>] default_idle+0x0/0x2e

read_lock_bh(&hh->hh_lock);

On Wed, Jan 15, 2003 at 08:18:13PM -0800, Dave Hansen wrote:
> time:_raw_write_lock() 1350000
> Call Trace:
>  [<c010f321>] timer_interrupt+0x99/0x9c
>  [<c010b150>] handle_IRQ_event+0x38/0x5c
>  [<c010b330>] do_IRQ+0x8c/0xf8
>  [<c0106eca>] default_idle+0x0/0x2e
>  [<c0106eca>] default_idle+0x0/0x2e
>  [<c0109c8c>] common_interrupt+0x18/0x20
>  [<c0106eca>] default_idle+0x0/0x2e
>  [<c0106eca>] default_idle+0x0/0x2e
>  [<c0106ef4>] default_idle+0x2a/0x2e
>  [<c0106f6b>] cpu_idle+0x39/0x42
>  [<c01212a5>] printk+0x15d/0x190

read_lock_irqsave(&xtime_lock, flags)
or
write_lock_irq(&xtime_lock);


Bill
