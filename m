Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264429AbTCXVxG>; Mon, 24 Mar 2003 16:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264430AbTCXVxG>; Mon, 24 Mar 2003 16:53:06 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:19597 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264429AbTCXVxF>; Mon, 24 Mar 2003 16:53:05 -0500
Date: Mon, 24 Mar 2003 22:04:04 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: conntrack related slab corruption in 2.5.65
Message-ID: <20030324220404.GB3034@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slab corruption: start=cf480a84, expend=cf480bb7, problemat=cf480aec
Last user: [<c03ed43a>](destroy_conntrack+0xf8/0x159)
Data: ********************************************************************************************************EC 0A 48 CF EC 0A 48 CF ***************************************************************************************************************************************************************************************************A5 
Next: 71 F0 2C .3A D4 3E C0 71 F0 2C .********************
slab error in check_poison_obj(): cache `ip_conntrack': object was modified after freeing
Call Trace:
 [<c0144496>] check_poison_obj+0x155/0x195
 [<c0145e4b>] kmem_cache_alloc+0x139/0x177
 [<c03edfba>] init_conntrack+0x8d/0x44f
 [<c03edfba>] init_conntrack+0x8d/0x44f
 [<c03ee586>] ip_conntrack_in+0x20a/0x2bc
 [<c03db2eb>] udp_connect+0xa8/0x353
 [<c03aa074>] nf_iterate+0x5f/0x93
 [<c03b9634>] dst_output+0x0/0x2d
 [<c03aa3db>] nf_hook_slow+0xa9/0x205
 [<c03b9634>] dst_output+0x0/0x2d
 [<c03b7a84>] ip_queue_xmit+0x435/0x525
 [<c03b9634>] dst_output+0x0/0x2d
 [<c039d1df>] __kfree_skb+0x89/0xfe
 [<c014437c>] check_poison_obj+0x3b/0x195
 [<c03d0eeb>] tcp_v4_send_check+0x4d/0xd8
 [<c03ca6ae>] tcp_transmit_skb+0x3b0/0x5b3
 [<c03cd026>] tcp_connect+0x3af/0x47b
 [<c02aa34e>] secure_tcp_sequence_number+0x82/0xa0
 [<c03d0237>] tcp_v4_connect+0x393/0x5db
 [<c03e3f1d>] inet_stream_connect+0x264/0x3bc
 [<c0398ae2>] move_addr_to_kernel+0x6b/0x6f
 [<c039a2d8>] sys_connect+0x78/0x99
 [<c0398c00>] sock_destroy_inode+0x1d/0x21
 [<c0398c00>] sock_destroy_inode+0x1d/0x21
 [<c0178bbc>] destroy_inode+0x36/0x50
 [<c017a493>] iput+0x63/0x7c
 [<c01760b3>] dput+0x24/0x333
 [<c039adb1>] sys_socketcall+0xb2/0x262
 [<c015c938>] filp_close+0xe9/0x12d
 [<c015ca13>] sys_close+0x97/0xdf
 [<c010978f>] syscall_call+0x7/0xb


