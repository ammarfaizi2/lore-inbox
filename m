Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266004AbUHWRLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUHWRLd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266127AbUHWRLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:11:33 -0400
Received: from legaleagle.de ([217.160.128.82]:44678 "EHLO www.legaleagle.de")
	by vger.kernel.org with ESMTP id S266004AbUHWRLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:11:04 -0400
Message-ID: <412A2525.9010606@trash.net>
Date: Mon, 23 Aug 2004 19:11:01 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Voluspa <lista4@comhem.se>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.8-rc4-bk1 problem: unregister_netdevice: waiting for ppp0
References: <200408221504.i7MF4Z719895@d1o404.telia.com>
In-Reply-To: <200408221504.i7MF4Z719895@d1o404.telia.com>
Content-Type: multipart/mixed;
 boundary="------------090406090109010602040601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090406090109010602040601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Voluspa wrote:

>Greetings,
>
>NOTE
>I wrote the text below just prior to the posting of
>01-2.6-cbq-leaks.diff but applying it doesn't change the
>situation here. I still get the same Oops as below. Slight
>changes in memory address but the Call Trace is identical.
>So, different problem?
>ENDNOTE
>  
>

Did you also apply this patch ? If not, please try it and tell us
if it helps.

Regards
Patrick

>Yes, saw the same thing on eth0 but had a confusing time to catch a
>clean error situation. Having been used to stable kernels for a long
>time I've disabled all debugging options and compile for size. So
>when 2.6.8[.1] threw an Oops at the end of every "shutdown -r now"
>the feedback was useless ("halt" gave no Oops). What looked to be
>the same Oops came when doing a "rmmod 8139too". 2.6.7 has no such
>issues.
>
>Turning on CONFIG_KALLSYMS (and CONFIG_CC_OPTIMIZE_FOR_SIZE off), with
>CONFIG_FRAME_POINTER, a slew of other debug options and the
>CONFIG_MAGIC_SYSRQ, hid the Oops and gave the result Nuno Silva
>has described.
>
>To make a long story short, I didn't trust my very old system enough
>to report.
>
>But now I've seen the QoS/wshaper connection and achieved a good Oops
>with only CONFIG_KALLSYMS and CONFIG_FRAME_POINTER set.
>
>Typing it here in case it has some kind of value (hand-copied):
>
>[...]
>Unmounting local filesystems...
>Flushing filesystem buffers...
>Please stand by while rebooting...
>Unable to handle kernel paging request at virtual address 8bc289a9
> printing eip:
>c02ae9c0
>*pde = 00000000
>Ooops: 0000 [#1]
>PREEMPT
>Modules linked in: 8139too crc32
>CPU:    0
>EIP:    0060:[<c02ae9c0>]   Not tainted
>EFLAGS: 00010286   (2.6.8-debug)
>EIP is at fib_sync_down+0x50/0xb0
>eax: cfaee800 ebx: 948bff0d ecx: 8bc28955 edx: c0267eb8
>esi: 00000001 edi: 00000000 ebp: cf0a1ea4 esp: cf0a1e8c
>de: 007b es: 007b ss: 0068
>Process reboot (pid: 151, threadinfo=cf0a1000 task=cfa3e090)
>Stack:
>000000ff 00000001 cfaee800 cfaee800 cfaee800 00000002 cf0a1eb0 c02ad8d1
>c033affc cf0a1ebc c02ad9b9 c033affc cf0a1ed0 c0121508 cfaee800 00000002
>00001003 cf0a1ee0 c025dadf cfaee800 00000002 cf0a1ef8 c025ef32 00000000
>Call Trace:
> [<c0104d7a>] show_stack+0x7a/0x90
> [<c0104ef9>] show_registers+0x149/0x1a0
> [<c010508d>] die+0x8d/0x100
> [<c0111b45>] do_page_fault+0x1e5/0x569
> [<c0104a15>] error_code+0x2d/0x38
> [<c02ad8d1>] fib_disable_ip+0x11/0x30
> [<c02ad9b9>] fib_netdev_event+0x69/0x80
> [<c0121508>] notifier_call_chain+0x28/0x50
> [<c025dadf>] dev_close+0x8f/0xa0
> [<c025ef32>] dev_change_flags+0x52/0x120
> [<c02a82f5>] devinet_ioctl+0x245/0x590
> [<c02aa573>] inet_ioctl+0x63/0xb0
> [<c0255b82>] sock_ioctl+0xe2/0x230
> [<c0159a95>] sys_ioctl+0x105/0x260
> [<c010400b>] syscall_call+0x7/0xb
>Code: 8b 41 54 85 c0 74 19 8d 51 58 31 f6 8b 5a 04 f6 c3 01 74 2c
>/etc/rc.d/rc.6: line 49: 151 Segmentation fault /sbin/reboot -d -f -i
>INIT: no more processes left in this runlevel
><5>portmap: server localhost not responding, timed out
>RPC: failed to contact portmap (errno -5).
>portmap: server localhost not responding, timed out
>RPC: failed to contact portmap (errno -5).
>--endOops--
>
>The -i parametre to reboot (which is a symlink to halt) means to shut
>down all network interfaces. My halt command doesn't use the -i, hence
>the lack of Oops.
>
>Mvh
>Mats Johannesson
>
>
>
>  
>


--------------090406090109010602040601
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/15 19:33:16-07:00 kaber@trash.net 
#   [PKT_SCHED]: cacheline-align qdisc data in qdisc_create()
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# net/sched/sch_api.c
#   2004/08/15 19:32:59-07:00 kaber@trash.net +13 -8
#   [PKT_SCHED]: cacheline-align qdisc data in qdisc_create()
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
diff -Nru a/net/sched/sch_api.c b/net/sched/sch_api.c
--- a/net/sched/sch_api.c	2004-08-23 19:06:53 +02:00
+++ b/net/sched/sch_api.c	2004-08-23 19:06:53 +02:00
@@ -389,7 +389,8 @@
 {
 	int err;
 	struct rtattr *kind = tca[TCA_KIND-1];
-	struct Qdisc *sch = NULL;
+	void *p = NULL;
+	struct Qdisc *sch;
 	struct Qdisc_ops *ops;
 	int size;
 
@@ -407,12 +408,18 @@
 	if (ops == NULL)
 		goto err_out;
 
-	size = sizeof(*sch) + ops->priv_size;
+	/* ensure that the Qdisc and the private data are 32-byte aligned */
+	size = ((sizeof(*sch) + QDISC_ALIGN_CONST) & ~QDISC_ALIGN_CONST);
+	size += ops->priv_size + QDISC_ALIGN_CONST;
 
-	sch = kmalloc(size, GFP_KERNEL);
+	p = kmalloc(size, GFP_KERNEL);
 	err = -ENOBUFS;
-	if (!sch)
+	if (!p)
 		goto err_out;
+	memset(p, 0, size);
+	sch = (struct Qdisc *)(((unsigned long)p + QDISC_ALIGN_CONST)
+	                       & ~QDISC_ALIGN_CONST);
+	sch->padded = (char *)sch - (char *)p;
 
 	/* Grrr... Resolve race condition with module unload */
 
@@ -420,8 +427,6 @@
 	if (ops != qdisc_lookup_ops(kind))
 		goto err_out;
 
-	memset(sch, 0, size);
-
 	INIT_LIST_HEAD(&sch->list);
 	skb_queue_head_init(&sch->q);
 
@@ -470,8 +475,8 @@
 
 err_out:
 	*errp = err;
-	if (sch)
-		kfree(sch);
+	if (p)
+		kfree(p);
 	return NULL;
 }
 

--------------090406090109010602040601--
