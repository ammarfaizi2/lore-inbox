Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272651AbRIPSLX>; Sun, 16 Sep 2001 14:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272650AbRIPSLN>; Sun, 16 Sep 2001 14:11:13 -0400
Received: from mx1.fuse.net ([216.68.2.90]:9379 "EHLO mta01.fuse.net")
	by vger.kernel.org with ESMTP id <S272651AbRIPSK6>;
	Sun, 16 Sep 2001 14:10:58 -0400
Message-ID: <3BA4EB3C.4000407@fuse.net>
Date: Sun, 16 Sep 2001 14:11:08 -0400
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010819
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Module version tags not created correctly.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all.

Compiling 2.4.9-ac10 with the following relevant config options yields a 
number of symbols incorrectly exported/defined.

CONFIG_MODVERSIONS=y
CONFIG_MK7=y
CONFIG_NETLINK=y
CONFIG_NETFILTER=y
    All netfliter options built as modules.
[if any others would help, please ask]

Yields the following entries in /proc/ksyms:

0201b90 _mmx_memcpy_R__ver__mmx_memcpy
c0201de0 mmx_clear_page_R__ver_mmx_clear_page
c0201e30 mmx_copy_page_R__ver_mmx_copy_page
c02494a8 jh_splice_lock_R__ver_jh_splice_lock
c02494ac journal_oom_retry_R__ver_journal_oom_retry
c01ff300 netlink_set_err_R__ver_netlink_set_err
c01ff150 netlink_broadcast_R__ver_netlink_broadcast
c01feed0 netlink_unicast_R__ver_netlink_unicast
c01ff6f0 netlink_kernel_create_R__ver_netlink_kernel_create
c01ff930 netlink_dump_start_R__ver_netlink_dump_start
c01ffa10 netlink_ack_R__ver_netlink_ack
c01d4cb0 nf_register_hook_R__ver_nf_register_hook
c01d4d20 nf_unregister_hook_R__ver_nf_unregister_hook
c01d4d60 nf_register_sockopt_R__ver_nf_register_sockopt
c01d4e50 nf_unregister_sockopt_R__ver_nf_unregister_sockopt
c01d53a0 nf_reinject_R__ver_nf_reinject
c01d50a0 nf_register_queue_handler_R__ver_nf_register_queue_handler
c01d5100 nf_unregister_queue_handler_R__ver_nf_unregister_queue_handler
c01d5260 nf_hook_slow_R__ver_nf_hook_slow
c02bf3a0 nf_hooks_R__ver_nf_hooks
c01d4fc0 nf_setsockopt_R__ver_nf_setsockopt
c01d4ff0 nf_getsockopt_R__ver_nf_getsockopt
c02bfba0 ip_ct_attach_R__ver_ip_ct_attach

The short-term fix I've used is to disable CONFIG_MODVERSIONS.

The resulting kernel [make dep clean bzImage modules], by the by, loads 
and runs fine, but insmod/modprobe/depmod fails for any module looking 
for those handles, which includes, to my knowledge, all of netfilter and 
nVIDIA's kernel module.  Haven't tried to make an exhaustive list, but 
if one would help, I'd be glad to.

System is a Debian unstable, updated roughly every day.  Modutils 
version 2.4.8, genksyms installed and works everywhere else.

Thanks in advance.
Nathan


